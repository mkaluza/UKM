cat << _EOF
{
				name: MALI Vape,
				elements: [{
							SSeekBar: {
								title: "OPP 50 Vape",
								unit: "V",
								weight:0.000001,
								min: 700000,
								max: 1425000,
								step: 12500,
								action: "mali_50_vape"
							}
				},
_EOF

while read line; do
				arr=( $line )
				idx=${arr[0]}
				[ $idx == "idx" ] && continue
				freq=${arr[1]}
				let freq=$(( freq/1000 ))
				vape=${arr[4]}

				cat << _EOF
				{
							SSeekBar: {
								title: "$freq MHz",
								unit: "V",
								weight:0.000001,
								min: 700000,
								max: 1425000,
								step: 12500,
								action: "mali_vape $idx"
				}},
_EOF
done < /sys/kernel/mali/mali_dvfs_config
echo "]}"

