local segment_meter = pd.Class:new():register("segment_meter")

function segment_meter:initialize(_, atoms)
    self.inlets = 1
    self.outlets = 2
    self.offset = atoms[1] or 0
    self.height = atoms[2] or 8
    self.step = atoms[3] or 8

    self.levels = {
        weak=1,
        mid=5,
        peak=3
    }
    self.mid_threshold = (self.height / 2) * self.step + self.offset
    self.peak_threshold = (self.height - 1) * self.step + self.offset

    self.last = 0
    return true
end

function segment_meter:in_1_float(f)
    -- +3dB de compensação do env~, adequação do range pra -60~0dB
    local quantized = math.floor(math.max(0, math.min(100, f + 3.5 -40)) / 60 * self.height)

    if quantized == self.last then
        return
    elseif quantized > self.last then
        local diff = quantized - self.last
        for i=1,diff do
            local note_on = (i-1 + self.last) * self.step + self.offset

            local on_value = self.levels.weak
            if note_on >= self.peak_threshold then
                on_value = self.levels.peak
            elseif note_on >= self.mid_threshold then
                on_value = self.levels.mid
            end
            self:outlet(1, "list", {note_on, on_value})
        end
        --self:outlet(1, "list", {quantized * self.step + self.offset, self.on_value})
    elseif quantized < self.last then
        local diff = self.last - quantized
        for i=1,diff do
            local note_off = (i-1 + quantized) * self.step + self.offset
            self:outlet(1, "list", {note_off, 0})
        end
    end
    self.last = quantized
    self:outlet(2, "float", {quantized})
end