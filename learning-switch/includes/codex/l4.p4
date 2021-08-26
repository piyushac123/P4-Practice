/*
Layer 4 protocol
*/

// TCP header
header tcp_t{
	bit<16> srcPort;
	bit<16> dstPort;
	bit<32> seqNum;
	bit<32> ackNum;
	bit<4>	hlen;
	bit<6>	res;
	bit<6>	flags;
	bit<16> window;
	bit<16> hdrChecksum;
	bit<16>	urgentPtr;

}

// UDP header
header udp_t{
	bit<16> srcPort;
	bit<16> dstPort;
	bit<16>	length;
	bit<16>	hdrChecksum;
}

// VXLAN header