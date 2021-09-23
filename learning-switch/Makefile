all : learning-switch

learning-switch : learning-switch.p4
	p4c-bm2-ss --std p4-16 --target bmv2 --arch v1model -o learning-switch.json --p4runtime-file learning-switch.p4info --p4runtime-format text learning-switch.p4
