cat << _EOF
{
				name: LiveOPP Varm,
				elements: [
_EOF

for i in /sys/kernel/liveopp/arm_step*; do
				freq=( `grep "Frequency show" $i` )
				freq=$((freq[2]/1000))
				cat << _EOF
				{
							SSeekBar: {
								title: "$freq MHz",
								unit: "V",
								weight:0.000001,
								min: 700000,
								max: 1425000,
								step: 12500,
								action: "liveopp $i varm"
				}},
_EOF
done
echo "]}"
