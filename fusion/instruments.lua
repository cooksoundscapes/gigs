local instruments = {
    pages={
        {
            {"master", "vol"},
            {"drive", "gain"},
            {"synth", "bypass"},
            {"vibrato", "mix"}
        },
        {
            {"delay", "level"},
            {"delay", "time"},
            {"delay", "feedback"},
            {"delay", "modulation"}
        },
        {
            {"tremolo", "strength"},
            {"tremolo", "rate"},
            {"tremolo", "wave"}
        },
        {
            {"synth", "pitch1"},
            {"synth", "pitch2"},
            {"synth", "osc2"},
            {"synth", "glide"}
        },
        {
            {"synth", "pulse_width"},
            {"synth", "pwm"},
            {"synth", "cutoff"},
            {"synth", "q"}
        }
    },
    master={
        vol={
            level=0,
            min=-100,
            max=40,
            res=1,
            send="master"
        }
    },
    synth={
        bypass={
            level=0,
            min=0,
            max=1,
            res=1,
            send="gt-synth-switch",
        },
        pitch1={
            level=0,
            min=-24,
            max=24,
            res=.1,
            send="pitch-1",
            path="gt-synth"
        },
        pitch2={
            level=0,
            min=-24,
            max=24,
            res=.1,
            send="pitch-2",
            path="gt-synth"
        },
        osc2={
            level=0,
            min=0,
            max=1,
            res=.1,
            send="osc2",
            path="gt-synth"
        },
        glide={
            level=0,
            min=0,
            max=60,
            res=1,
            send="glide",
            path="gt-synth"
        },
        pulse_width={
            level=0.5,
            min=.1,
            max=.9,
            res=.1,
            send="gt-synth-pw",
        },
        pwm={
            level=1.1,
            min=0,
            max=4,
            res=.1,
            send="gt-synth-pwm",
        },
        cutoff={
            level=1.1,
            min=80,
            max=16000,
            res=17.5,
            send="cutoff",
            path="gt-synth"
        },
        q={
            level=1.1,
            min=.75,
            max=4,
            res=.25,
            send="q",
            path="gt-synth"
        },
    },
    drive={
        gain={
            level=0,
            min=0,
            max=100,
            res=1,
            send="drive"
        }
    },
    vibrato={
        mix={
            level=0,
            min=0,
            max=100,
            res=1,
            send="vibrato",
            transform=function(v) return v/100*2-1 end
        },
        wave={
            level=0,
            min=0,
            max=1,
            res=1,
            send="vib-wave",
            transform=function(v) return v * 2 end
        },
        rate={
            level=1.1,
            min=0.4,
            max=12,
            res=.2,
            send="vib-rate",
        },
        strength={
            level=4,
            min=2.2,
            max=8,
            res=.2,
            send="vib-rate",
        },
    },
    delay={
        level={
            level=-100,
            min=-100,
            max=0,
            res=1,
            send="level",
            path="delay"
        },
        feedback={
            level=-100,
            min=-100,
            max=0,
            res=1,
            send="fdbk",
            path="delay"
        },
        time={
            level=300,
            min=10,
            max=2000,
            res=5,
            send="time",
            path="delay"
        },
        mod={
            level=0,
            min=0,
            max=.9,
            res=.1,
            send="mod.depth",
            path="delay"
        },
        lpf={
            level=21000,
            min=20,
            max=21000,
            res=17.5,
            send="lop",
            path="delay"
        },
    },
    tremolo={
        speed={
            level=6,
            min=.2,
            max=18,
            res=.2,
            send="trem-rate"
        },
        strength={
            level=0,
            min=-.95,
            max=0,
            res=.05,
            send="trem-strength"
        },
        wave={
            level=0,
            min=0,
            max=4,
            res=1,
            send="trem-wave"
        },
    },
    degrade={
        strength={
            level=0,
            min=0,
            max=100,
            res=1,
            send="downsamp",
            transform=function(v) return v/100 end
        },
        interp={
            level=0,
            min=0,
            max=1,
            res=1,
            send="downsamp-interp"
        }
    }
}

return instruments