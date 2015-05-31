chargalg=/sys/kernel/abb-chargalg/
cat << _EOF
{
	name: Power,
	elements: [
		{SLiveLabel: {
			title: "End Of Charge",
			action: "generic $chargalg/eoc_status"
		}}
_EOF

echo "]}"
