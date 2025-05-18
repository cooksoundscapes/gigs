return {
    _new = function(param_table, type_def)
        setmetatable(param_table, { __index = type_def })
        return param_table
    end,
    volume = function(self, t)
        return self._new(t, self.volume_t)
    end,
    freq_sweep = function(self, t)
        return self._new(t, self.freq_sweep_t)
    end,
    balance = function(self, t)
        return self._new(t, self.balance_t)
    end,
    freq_sweep_t = {
        min=0,
        max=136,
        res=1,
        suffix="Hz",
        ui_transform=function(v) return 440 * 2 * ((v - 69) / 12) end,
    },
    volume_t = {
        min=-100,
        max=0,
        res=1,
        suffix="dB",
    },
    balance_t={
        max=100,
        min=0,
        res=1,
        transform=function(v) return v/100*2-1 end,
        suffix="%"
    },
}