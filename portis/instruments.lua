local types = require('_common.types')

local instruments = {
    pages={
        {
            {"organ", "vol"},
            {"bells", "vol"},
            {"vox_fx", "vol"},
        },
        {
            {"organ", "overdrive"},
            {"organ", "hpf_cutoff"},
            {"organ", "lpf_cutoff"},
            {"bells", "lpf_cutoff"}
        },
    },
    midi_mapping={
        [33]={
            [48]={"organ", "vol"},
            [49]={"bells", "vol"},
            [50]={"vox_fx", "vol"},
            [55]={"vox_fx", "delay_lpf"},
            [56]={"vox_fx", "dry"},
        }
    },
    ac_gt={
        vol=types:volume({level=0, send="ac-gt"}),
        reverb=types:volume({level=0, send="ac-gt-rv"}),
    },
    organ={
        vol=types:volume({level=0, send="organ"}),
        hpf_cutoff=types:freq_sweep({level=108, send="wvtbl-hpf"}),
        lpf_cutoff=types:freq_sweep({level=124, send="wvtbl-lpf"}),
        overdrive=types:volume({level=-6,  max=20, send="wvtbl-drive"}),
        vibrato_mix=types:balance({level=50, send="wvtbl-vib-mix"}),
        reverb=types:volume({level=-14, send="wvtbl-verb"}),
        vibrato_rate={
            level=8,
            min=.2,
            max=12,
            res=.1,
            send="wvtbl-vib",
            path="rate",
            suffix="Hz",
        },
        vibrato_range={
            level=3,
            min=2.2,
            max=8,
            res=.1,
            send="wvtbl-vib",
            path="range",
            transform=function(v) return {2, v} end,
            is_table=true,
            suffix="ms",
        },
    },
    bells={
        vol=types:volume({level=0, send="bells"}),
        lpf_cutoff=types:freq_sweep({level=96, send="smp-synth-lpf"})
    },
    vox_fx={
        vol=types:volume({level=0, send="vox"}),
        dry=types:volume({level=0, send="vox-dry"}),
        feedback=types:volume({level=0, send="vox-feedback"}),
        delay_lpf=types:freq_sweep({level=136, send="vox-delay-lpf"}),
    }
}

return instruments