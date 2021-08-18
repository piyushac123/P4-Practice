/*
Layer 2 protocol
*/

// standard ethernet
header ethernet_t{
	bit<48> dstAddr;
	bit<48> srcAddr;
	bit<16> etherType;
}

// 802.1 Q (ethernet with VLAN)