#ifndef _IPV4_FORWARD_
#define _IPV4_FORWARD_

#include "headers.p4"
#include "actions.p4" // For drop function

control ipv4_forwarding(
	inout headers_t hdr,
	inout metadata_t metadata,
	inout standard_metadata_t standard_metadata
){
	action ipv4_forward(bit<48> dstAddr, bit<9> port){
		standard_metadata.egress_spec = port;
		hdr.ethernet.srcAddr = hdr.ethernet.dstAddr;
		hdr.ethernet.dstAddr = dstAddr;
		hdr.ipv4.ttl = hdr.ipv4.ttl - 1;
	}

	table ipv4_lpm {
		key = {
			hdr.ipv4.dstAddr : lpm;
		}
		actions = {
			ipv4_forward;
			drop;
			NoAction;
		}
		size = 1024;
		default_action = drop();
	}

	apply{
		if(hdr.ipv4.isValid()){
			ipv4_lpm.apply();
		}
		
	}
}

#endif