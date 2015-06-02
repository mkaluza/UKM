for _dev in `ls /sys/block/mmcblk[0-9] /sys/block/mmcblk[0-9][0-9]`; do
dev=`basename $_dev`
cat << CTAG
{
	name:"I/O: $dev",
		elements:[
			{ STitleBar:{
				title:"I/O Control for $dev"
			}},
				{ SSeekBar:{
					title:"Read-ahead Size",
					description:"Set the read-ahead size for the internal storage.",
					min: 64,
					step: 64,
					max:1024,
					unit:" KB",
					default:`$BB cat /sys/block/$dev/queue/read_ahead_kb`,
					action:"ioset queue $dev read_ahead_kb"
				}},
				{ SOptionList:{
					title:"I/O Scheduler",
					description:"The I/O Scheduler decides how to prioritize and handle I/O requests. More info: <a href='http://timos.me/tm/wiki/ioscheduler'>HERE</a>",
					action:"ioset scheduler $dev",
					values:[
						`$UCI_ACTION/ioset scheduler`
					],
					notify:[
						{
							on:APPLY,
							do:[ REFRESH, CANCEL ],
							to:"/sys/block/$dev/queue/iosched",
						},
						{
							on:REFRESH,
							do:REFRESH,
							to:"/sys/block/$dev/queue/iosched",
						}
					]
				}},
			{ SPane:{
				title:"General I/O Tunables",
				description:"Set the internal storage general tunables"
			}},
				{ SCheckBox:{
					description:"Draw entropy from spinning (rotational) storage.",
					label:"Add Random",
					default:`$BB cat /sys/block/$dev/queue/add_random`,
					action:"ioset queue $dev add_random"
				}},
				{ SCheckBox:{
					description:"Maintain I/O statistics for this storage device. Disabling will break I/O monitoring apps.",
					label:"I/O Stats",
					default:`$BB cat /sys/block/$dev/queue/iostats`,
					action:"ioset queue $dev iostats"
				}},
				{ SCheckBox:{
					description:"Treat device as rotational storage.",
					label:"Rotational",
					default:`$BB cat /sys/block/$dev/queue/rotational`,
					action:"ioset queue $dev rotational"
				}},				
				{ SOptionList:{
					title:"No Merges",
					description:"Types of merges (prioritization) the scheduler queue for this storage device allows.",
					default:`$BB cat /sys/block/$dev/queue/nomerges`,
					action:"ioset queue $dev nomerges",
					values:{
						0:"All", 1:"Simple Only", 2:"None"
					}
				}},
				{ SOptionList:{
					title:"RQ Affinity",
					description:"Try to have scheduler requests complete on the CPU core they were made from. Higher is more aggressive. Some kernels only support 0-1.",
					default:`$BB cat /sys/block/$dev/queue/rq_affinity`,
					action:"ioset queue $dev rq_affinity",
					values:{
						0:"Disabled", 1:"Enabled", 2:"Aggressive"
					}
				}},
				{ SSeekBar:{
					title:"NR Requests",
					description:"Maximum number of read (or write) requests that can be queued to the scheduler in the block layer.",
					step:128,
					min:128,
					max:2048,
					default:`$BB cat /sys/block/$dev/queue/nr_requests`,
					action:"ioset queue $dev nr_requests"
				}},
			{ SPane:{
				title:"I/O Scheduler Tunables"
			}},
				{ STreeDescriptor:{
					path:"/sys/block/$dev/queue/iosched",
					generic: {
						directory: {},
						element: {
							SGeneric: { title:"@BASENAME" }
						}
					},
					exclude: [ "weights" ]
				}},
		]
}
CTAG
done
