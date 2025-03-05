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
        vol={
            level=0,
            min=-100,
            max=0,
            res=1,
            send="ac-gt"
        },
        reverb={
            level=0,
            min=-100,
            max=0,
            res=1,
            send="ac-gt-rv"
        }
    },
    organ={
        vol={
            level=0,
            min=-100,
            max=0,
            res=1,
            send="organ",
        },
        hpf_cutoff={
            level=108,
            min=0,
            max=136,
            res=0.5,
            send="wvtbl-hpf"
        },
        lpf_cutoff={
            level=124,
            min=0,
            max=136,
            res=0.5,
            send="wvtbl-lpf"
        },
        overdrive={
            level=-6, -- in dbs
            min=-100,
            max=20,
            res=1,
            send="wvtbl-drive"
        },
        vibrato_mix={
            level=1,
            max=100,
            min=0,
            res=1,
            send="wvtbl-vib-mix",
            transform=function(v) return v/100*2-1 end,
        },
        vibrato_rate={
            level=8,
            min=.2,
            max=12,
            res=.1,
            send="wvtbl-vib",
            path="rate"
        },
        vibrato_range={
            level=3,
            min=2.2,
            max=8,
            res=.1,
            send="wvtbl-vib",
            path="range",
            transform=function(v) return {2, v} end,
            is_table=true
        },
        reverb={
            level=-14,
            min=-100,
            max=0,
            res=1,
            send="wvtbl-verb"
        },
    },
    bells={
        vol={
            level=0,
            min=-100,
            max=0,
            res=1,
            send="bells",
        },
        lpf_cutoff={
            level=96,
            min=0,
            max=136,
            res=0.5,
            send="smp-synth-lpf"
        },
    },
    vox_fx={
        vol={
            level=0,
            min=-100,
            max=0,
            res=1,
            send="vox",
        },
        dry={
            level=0,
            min=-100,
            max=0,
            res=1,
            send="vox-dry",
        },
        delay_lpf={
            level=136,
            min=0,
            max=136,
            res=0.5,
            send="vox-delay-lpf"
        },
        feedback={
            level=0, -- in dbs
            min=-100,
            max=0,
            res=1,
            send="vox-feedback"
        },
    }
}

return instruments