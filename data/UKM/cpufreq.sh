FREQS=`cat  /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies | sed -e "s/ \+/,/g"`
GOVS=`cat  /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors | sed -e "s/ \+/,/g"`
cat << __EOF
{
	name: CPUFreq,
	elements: [
	{
		STitleBar: {title: "CPU frequency scaling"}
	}, {
		SOptionList: {
			title: "CPU governor",
			values: [ $GOVS ],
			action:"generic /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"
		}
	}, {
	  STitleBar: {title: "Frequency range"}
	}, {
		SSeekBar:{
			title:"CPU max frequency",
			description:"Set the maximum freqency the CPU scales up to.",
			unit:"MHz",
			weight:0.001,
			values: [ $FREQS ],
			action:"generic /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq"
		}
	}, {
		SSeekBar:{
			title:"CPU min frequency",
			description:"Set the minimum freqency the CPU scales down to.",
			unit:"MHz",
			weight:0.001,
			values: [ $FREQS ],
			action:"generic /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq"
		}
	}, {
	  STitleBar: {title: "Governor settings"}
	}, {
		STreeDescriptor:{
			path:"/sys/devices/system/cpu/cpufreq",
			generic: {
				directory: {
					STreeDescriptor:{
						generic: {
							directory: {},
							element: {
								SGeneric: { title:"@NAME" }
							}
						},
						matched: {
							elements: [
								{ "timer_rate" : {
									SSeekBar: {
										title:"Timer rate",
										description:"Controls the frequency in which the governor polls for frequency changes.",
										weight: 0.001,
										min:10000, max:100000, step:10000, unit:"ms"
									}
								}}
							]
						},
						exclude: [
							"boost",
							"boostpulse",
							"boostpulse_duration",
							"cpu_utilization",
							"sampling_rate_min",
							"up_threshold_h",
							"up_threshold_l"
						]
					}
				}
			},
			exclude: [ "ondemand", "iks-cpufreq" ]
		}
	}
	]
}
__EOF
