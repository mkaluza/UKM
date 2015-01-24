cat << _EOF
{
				name: LiveOPP Varm,
				elements: [
_EOF

for i in /sys/kernel/liveopp/arm_step*; do
				n=`basename $i`
				freq=`cat $i | grep "Frequency show" | awk '{print $3/1000}'`
				cat << _EOF
				{
							SSeekBar: {
								title: "$freq MHz",
								unit: "V",
								weight:0.000001,
								min: 700000,
								max: 1425000,
								step: 12500,
								action: "liveopp varm $n"
				}},
_EOF
done
echo "]}"
