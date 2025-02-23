local patch_handler = pd.Class:new():register("patch_handler")

local function string_split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

local function prepare_path()
    local path = string_split(pd._pathnames.patch_handler, "/")
    table.remove(path, #path)
    local this_path = "/" .. table.concat(path, "/") .. "/"
    package.path = this_path .. "?.lua;" .. package.path
end

function patch_handler:initialize()
    prepare_path()
    self.instruments = require("instruments")
    self.actions = {
        ["encoders"]=function(atoms) self:handle_encoders(atoms) end,
        ["seq-buttons"]=function(atoms) self:handle_seq_buttons(atoms) end,
        ["nav-buttons"]=function(atoms) self:handle_nav_buttons(atoms) end,
        ["system"]=function(atoms) self:handle_system_msg(atoms) end
    }
    self.inlets = 1
    self.outlets = 1
    self.current_page = 1
    self.at_home_screen = true

    return true
end

function patch_handler:in_1(sel, atoms)
    if self.actions[sel] ~= nil then
        self.actions[sel](atoms)
    end
end

function patch_handler:handle_encoders(atoms)
    if self.at_home_screen then
        return
    end

    local enc = tonumber(atoms[1])
    local dir = atoms[2]
    local param_ref = self.instruments.pages[self.current_page][enc]
    if param_ref then
        local param = self.instruments[param_ref[1]][param_ref[2]]
        local incr = dir * param.res
        param.level = math.min(param.max, math.max(param.min, param.level + incr))

        local send_value = param.level
        if param.transform then
            send_value = param.transform(param.level)
        end

        local sel = "float"
        if param.path then
            sel = param.path
        elseif param.is_table then
            sel = "list"
        end

        if param.is_table then
            pd.send(param.send, sel, send_value)
            pd.send("observer", "list", {param_ref[1], param_ref[2], table.unpack(send_value)})
        else
            pd.send(param.send, sel, {send_value})
            pd.send("observer", "list", {param_ref[1], param_ref[2], send_value})
        end

        --manda no outlet 1 para send-osc (param) e concatena com param.path, exemplo:
        -- param.send = wvtbl-vib, param.path = rate, osc_send = wvtbl-vib-rate
        local osc_send = param.send
        if param.path then
            osc_send = osc_send .. "-" .. param.path
        end
        self:send_param_to_ui(osc_send, param.level)
    end
end

function patch_handler:handle_seq_buttons(atoms)
    pd.send("seq-buttons", "list", {tonumber(atoms[1]) - 1, (atoms[2] + 1) / 2})
end

function patch_handler:handle_nav_buttons(atoms)
    if self.at_home_screen then
        return
    end

    -- ignorar home button
    if atoms[1] ~= 1 then
        local btn = tonumber(atoms[1])
        local pressed = atoms[2] == 1

        if pressed then
            if btn == 3 then
                self.current_page = math.min(self.current_page + 1, #self.instruments.pages)
                pd.send("current-page", "float", {self.current_page})
                self:send_param_to_ui("page", self.current_page)
            elseif btn == 2 then
                self.current_page = math.max(self.current_page - 1, 1)
                pd.send("current-page", "float", {self.current_page})
                self:send_param_to_ui("page", self.current_page)
            end
        end
        pd.send("nav-buttons", "list", {tonumber(atoms[1]), atoms[2]})
    end
end

function patch_handler:handle_system_msg(atoms)
    if atoms[1] == "at_home" then
        self.at_home_screen = atoms[2] == 1
        pd.post(string.format("at home ? %s", self.at_home_screen))
    end
end

function patch_handler:send_param_to_ui(addr, value)
    self:outlet(1, addr, {value})
end
