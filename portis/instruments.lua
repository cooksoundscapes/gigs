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
    mixer={
        organ_out_ch={
            level=5, --stereo
            min=0,
            max=5,
            res=1,
            send="organ-out-ch",
        },
        bells_out_ch={
            level=5, --stereo
            min=0,
            max=5,
            res=1,
            send="bells-out-ch"
        },
        vox_out_ch={
            level=5, --stereo
            min=0,
            max=5,
            res=1,
            send="vox-out-ch"
        },
        vox_in_ch={
            level=1,
            min=0,
            max=4,
            res=1,
            send="vox-in-ch"
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
            level=4147.56,
            min=10,
            max=21000.0,
            res=17.5,
            send="wvtbl-hpf"
        },
        lpf_cutoff={
            level=10929.8,
            min=10,
            max=21000.0,
            res=17.5,
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
            level=2600,
            min=10,
            max=21000.0,
            res=17.5,
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
        hpf_cutoff={
            level=20,
            min=10,
            max=21000.0,
            res=170.5,
            send="vox-hpf"
        },
        lpf_cutoff={
            level=21000,
            min=10,
            max=21000.0,
            res=170.5,
            send="vox-lpf"
        },
        overdrive={
            level=0, -- in dbs
            min=-100,
            max=20,
            res=1,
            send="vox-drive"
        },
    }
}

return instruments