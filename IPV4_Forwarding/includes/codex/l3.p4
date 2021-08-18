/*
Layer 3 protocol
*/

// IPV4 Header
header ipv4_t{
	bit<4>	ver;
	bit<4>	ihl;
	bit<8>	tos;
	bit<16>	tlen;
	bit<16>	identifier;
	bit<3>	flags;
	bit<13>	fragOffset;
	bit<8>	ttl;
	bit<8>	protocol;
	bit<16>	hdrChecksum;
	bit<32> srcAddr;
	bit<32> dstAddr;
}

// IPV6 Header
header ipv6_t{
	bit<4>	ver;
	bit<8>	trafficCls;
	bit<20>	flowLabel;
	bit<16>	payloadLen;
	bit<8>	nextHeader;
	bit<8>	hopLimit;
	bit<32>	srcAddr;
	bit<32>	dstAddr;
}

// ARP Header
//https://www.google.com/search?q=arp+ip+protocol&tbm=isch&ved=2ahUKEwjv_Oem27ryAhVY7nMBHXQUDPwQ2-cCegQIABAA&oq=arp+ip+protocol&gs_lcp=CgNpbWcQAzIECAAQGDIECAAQGDoECAAQHjoGCAAQCBAeUJ32EliWtxNgoboTaAJwAHgAgAGRCIgB_SySAQ8wLjUuNC4yLjIuMS4xLjGYAQCgAQGqAQtnd3Mtd2l6LWltZ8ABAQ&sclient=img&ei=9g8dYe-pOtjcz7sP9Kiw4A8&client=ubuntu&hs=5Kk#imgrc=MQZx9Nz4W0jGQM&imgdii=7aYN0dA4CGI5LM

header arp_t{
	bit<16> hType; // Hardware Type (MAC Address) -> eg. 1 for Ethernet
	bit<16> pType; // Protocol Type (Protocol can b IPV4) -> eg. 0x0800 for IPV4 and 0x0806 for ARP
	bit<8>	hlen; // Hardware Length -> eg. 6 for Ethernet
	bit<8> 	protoLen; // Protocol Length -> eg. 4 for IPV4 
	bit<16> opr; // which operation -> request/reply? ->eg. 1 for Request or 2 for Response
	bit<48>	srcMacAddr; // Hardware Source Address ->eg. 6 octets for Ethernet Address
	bit<32> srcIPAddr; // Protocol Source Address ->eg. 4 octets for IPV4 Address
	bit<48>	dstMacAddr; // Hardware Destination Address ->eg. 6 octets for Ethernet Address
	bit<32> dstIPAddr; // Protocol Destination Address ->eg. 4 octets for IPV4 Address
}

// ICMP Request-Reply Timestamp Header
// https://www.google.com/search?q=icmp+timestamp+request+response+header&client=ubuntu&hs=ar5&channel=fs&sxsrf=ALeKk02vV7Lebb9cUrt8q1aeMekdgL5Fog:1629297877990&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjfooDK57ryAhUFwjgGHfQPDWoQ_AUoAXoECAEQAw&biw=1920&bih=827#imgrc=9fM0fQVUxRIAyM&imgdii=rq8s8-liaskA9M

header icmp_ts_t{
	bit<8>	type; // 13 or 14
	bit<8>	code; // sub-type -> 0
	bit<16>	hdrChecksum;
	bit<16>	identifier;
	bit<16>	seqNum; // sequence number
	bit<32>	orgTime; // originate timestamp -> when sender last touched data
	bit<32>	recTime; // received timestamp -> when receiver first received data
	bit<32>	tranTime; // transmit timestamp -> when echoer last touched data
}

// ICMP Header -> Destination unreachable
// https://en.wikipedia.org/wiki/Internet_Control_Message_Protocol

header icmp_t{
	bit<8> type; // 3
	bit<8> code; // type of error -> 0-15
	bit<16> hdrChecksum;
	bit<16> empty;
    bit<16> nextHopMtu; // contains MTU of next-hop network if code 4 error occurs
    // IP Header and first 8 bits of original datagram data ?
}

// MPLS Header -> The MPLS Header is added between the network layer header and link layer header of the OSI model. When a labeled packet is received by an MPLS router, the topmost label is examined. Based on the contents of the label a swap, push (impose) or pop (dispose) operation is performed on the packet's label stack.
// https://www.google.com/search?q=mpls+header&client=ubuntu&hs=Lal&channel=fs&sxsrf=ALeKk02AFo60HTWiyb-VI8PKqMAsvmyq6g:1629299369623&tbm=isch&source=iu&ictx=1&fir=4V3sDWUisZDY4M%252CTUyhjpZsnAnnpM%252C_&vet=1&usg=AI4_-kSMlzDH1qmKOqjy1e9l2VUqGXbctw&sa=X&ved=2ahUKEwjqk52R7bryAhWzzjgGHQhcBM8Q_h0wAnoECB8QBw&biw=1920&bih=827#imgrc=EsMn7sYPqWFbQM

header mpls_t {
    bit<20> label;
    bit<3>  tc; // traffic class (QoS and ECN)
    bit<1>  s;  // bottom-of-stack
    bit<8>  ttl;// time-of-live
}