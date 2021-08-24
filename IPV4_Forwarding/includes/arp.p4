#ifndef _ARP_
#define _ARP_

control arp(
	inout headers_t hdr,
	inout metadata_t metadata,
	inout standard_metadata_t standard_metadata
){
	// When called? does what?
	action send_to_cpu(){
		standard_metadata.egress_spec = CPU_PORT;
		hdr.packet_in.setValid();
		hdr.packet_in.ingress_port = (bit<16>) standard_metadata.ingress_port;
	}

	action flooding(){
		standard_metadata.mcast_grp = 1;
	}

	action arp_reply(bit<9> port){
		standard_metadata.egress_spec = port;
	}

	table arp_exact{
		key = {
			standard_metadata.ingress_port : exact;
			hdr.ethernet.dstAddr : exact;
		}
		actions = {
			send_to_cpu;
			flooding; // dstAddr = ff:ff:ff:ff:ff:ff
			arp_reply; // else this
		}
		size = 1024;
		default_action = send_to_cpu();
	}
	apply{
		if(standard_metadata.ingress_port == CPU_PORT){
			standard_metadata.egress_spec = (bit<9>)hdr.packet_out.egress_port;
			standard_metadata.mcast_grp = hdr.packet_out.mcast_grp;
			hdr.packet_out.setInvalid();
		}
		else{
			arp_exact.apply();
		}
	}
}

#endif