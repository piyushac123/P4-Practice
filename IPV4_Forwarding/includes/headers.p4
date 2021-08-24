// #ifndef and #define are known as header guards. Their primary purpose is to prevent C++ header files from being included multiple times.
#ifndef __HEADERS__
#define __HEADERS__

#include "codex/enum.p4"
#include "codex/l2.p4"
#include "codex/l3.p4"
#include "codex/l4.p4"
#include "codex/l567.p4"

#define CPU_PORT 255

// A packet_in is defined as a data plane packet that is sent by the P4Runtime server to the control plane for further inspection. 
@controller_header("packet_in")
header packet_in_header_t{
	bit<16> ingress_port;
}

// Similarly, a packet_out is defined as a data packet generated by the control plane and injected in the data plane via the P4Runtime server.
@controller_header("packet_out")
header packet_out_header_t{
	bit<16> egress_port;
	bit<16> mcast_grp;
}

// header struct for packet
struct headers_t{
	packet_out_header_t packet_out;
	packet_in_header_t packet_in;
	ethernet_t ethernet;
	ipv4_t ipv4;
	tcp_t tcp;
	udp_t udp;
}

// metadata inside switch pipeline
struct metadata_t{
	
}

#endif