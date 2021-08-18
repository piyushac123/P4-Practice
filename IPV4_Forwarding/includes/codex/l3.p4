/*
Layer 3 protocol
*/

// IPV4 Header
header ipv4_t{
	bit<4>	ver;
	bit<4>	ihl;
	bit<8>	tos;
	bit<16>	tlen;
	bit<16>	iden;
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