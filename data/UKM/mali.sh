function join { local IFS="$1"; shift; echo "$*"; }

freqs=`awk 'BEGIN {getline} {printf("%d: \"%d MHz\", ", $1, $2/1000)}' /sys/kernel/mali/mali_dvfs_config`

cat << _EOF
{
				name: MALI,
				elements: [{
					STitleBar: {title: "Mali module params"}
				}, {
					SSeekBar: {
						title: "PM sampling rate",
						unit: "ms",
						min: 100,
						max: 2000,
						step: 100,
						action: "generic /sys/module/mali/parameters/mali_pm_sampling_rate"
					}
				}, {
					SSeekBar: {
						title: "Utilization sampling rate",
						unit: "ms",
						min: 100,
						max: 2000,
						step: 100,
						action: "generic /sys/module/mali/parameters/mali_utilization_sampling_rate"
					}
				}, {
					SSeekBar: {
						title: "OPP 100 up threshold",
						min: 30,
						max: 95,
						unit: "%",
						action: "generic_pct_255 /sys/module/mali/parameters/mali_utilization_low_to_high"
					}
				}, {
					SSeekBar: {
						title: "OPP 50 down threshold",
						min: 10,
						max: 50,
						unit: "%",
						action: "generic_pct_255  /sys/module/mali/parameters/mali_utilization_high_to_low"
					}
				}, {
					STitleBar: {title: "Mali boost"}
				}, {
					SSeekBar: {
						title: "Boost delay",
						unit: "ms",
						min: 100,
						max: 3000,
						step: 100,
						action: "generic /sys/kernel/mali/mali_boost_delay"
					}
				}, {
					STitleBar: {title: "Mali boost high"}
				}, {
					SSeekBar: {
						title: "Boost high freq",
						unit: "MHz",
						values: {$freqs},
						action: "mali_boost high idx"
					}
				}, {
					SSeekBar: {
						title: "Up threshold",
						min: 30,
						max: 95,
						unit: "%",
						action: "mali_boost high threshold"
					}
				}, {
					STitleBar: {title: "Mali boost low"}
				}, {
					SSeekBar: {
						title: "Boost low freq",
						unit: "MHz",
						values: {$freqs},
						action: "mali_boost low idx"
					}
				}, {
					SSeekBar: {
						title: "Down threshold",
						min: 10,
						max: 50,
						unit: "%",
						action: "mali_boost low threshold"
					}
				}, {
					STitleBar: {title: "Touchbooster"}
				}, {
					SOptionList: {
						values: {"on": "Enabled", "off": "Disabled"},
						action: "generic /sys/kernel/mxt224e/touchboost"
					}
				}, {
					SSeekBar: {
						title: "Touchboost delay",
						unit: "ms",
						min: 100,
						max: 3000,
						step: 100,
						action: "generic /sys/kernel/mxt224e/touchboost_delay"
					}
				}, {
					SCheckBox: {
						label: "Boost APE (GPU)",
						default: 1,
						action: "generic /sys/kernel/mxt224e/touchboost_ape"
					}
				}, {
					SCheckBox: {
						label: "Boost DDR (Memory)",
						default: 1,
						action: "generic /sys/kernel/mxt224e/touchboost_ddr"
					}
				}
]}
_EOF


