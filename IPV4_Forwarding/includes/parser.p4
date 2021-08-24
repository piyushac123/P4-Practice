#ifndef _PARSER_
#define _PARSER_

#include "headers.p4"

// PARSER
parser basic_learning_switch_parser(
	packet_in packet,
	out headers_t hdr,
	inout metadata_t metadata,
	inout standard_metadata_t standard_metadata
){
	state start{
		transition select(standard_metadata.ingress_port){
			CPU_PORT : parse_packet_out;
			default : parse_ethernet;
		}
	}
	// Here extract is necessary?
	state parse_packet_out{
		packet.extract(hdr.packet_out);
		transition parse_ethernet;
	}
	state parse_ethernet{
		packet.extract(hdr.ethernet);
		transtion select(hdr.ethernet.etherType){
			TYPE_IPV4 : parse_ipv4;
			default : accept;
		}
	}
	state parse_ipv4{
		packet.extract(hdr.ipv4);
		transition accept;
	}
}

// DEPARSER
control basic_learning_switch_deparser(
	packet_out packet,
	in headers_t hdr
){
	// Emit only if header is valid
	apply{
		packet.emit(hdr.packet_in)
		packet.emit(hdr.ethernet);
		packet.emit(hdr.ipv4);
		packet.emit(hdr.tcp);
		packet.emit(hdr.udp);
	}
}

#endif