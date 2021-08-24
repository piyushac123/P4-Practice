#include<core.p4>
#include<v1model.p4>

#include "includes/headers.p4"
#include "includes/parser.p4"
#include "includes/checksum.p4"
#include "includes/actions.p4"

// application
#include "includes/packetio.p4"
#include "includes/ipv4_forward.p4"
#include "includes/arp.p4"

// INGRESS PIPELINE
control basic_learning_switch_ingress(
	inout headers_t hdr,
	inout metadata_t metadata,
	inout standard_metadata_t standard_metadata
){
	apply{
		// Pipelines in Ingress ----> ?

		// IPV4 Forwarding
		ipv4_forwarding.apply(hdr, metadata, standard_metadata);

		// ARP
		arp.apply(hdr, metadata, standard_metadata);
	}
}

// EGRESS PIPELINE
control basic_learning_switch_egress(
	inout headers_t hdr,
	inout metadata_t metadata,
	inout standard_metadata_t standard_metadata
){
	apply{
		// Pipelines in Egress ----> ?
	}
}

// SWITCH ARCHITECTURE
V1Switch(
	basic_learning_switch_parser(),
	basic_learning_switch_verifyCk(),
	basic_learning_switch_ingress(),
	basic_learning_switch_egress(),
	basic_learning_switch_computeCk(),
	basic_learning_switch_deparser()
) main;