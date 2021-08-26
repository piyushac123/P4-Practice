#ifndef _CHECKSUMS_
#define _CHECKSUMS_

#include "headers.p4"

// verify checksum
control basic_learning_switch_verifyCk(
	inout headers_t hdr,
	inout metadata_t metadata
){
	apply{}
}

// compute checksum (need)
control basic_learning_switch_computeCk(
	inout headers_t hdr,
	inout metadata_t metadata
){
	apply{
		update_checksum(
			hdr.ipv4.isValid(),
			{
				hdr.ipv4.ver,
				hdr.ipv4.ihl,
				hdr.ipv4.tos,
				hdr.ipv4.tlen,
				hdr.ipv4.identifier,
				hdr.ipv4.flags,
				hdr.ipv4.fragOffset,
				hdr.ipv4.ttl,
				hdr.ipv4.protocol,
				hdr.ipv4.srcAddr,
				hdr.ipv4.dstAddr
			},
			hdr.ipv4.hdrChecksum,
			HashAlgorithm.csum16
		);
	}
}

#endif