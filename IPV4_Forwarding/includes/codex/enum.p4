/*
etherType protocol number
*/

// Ethernet Frame Format
// https://en.wikipedia.org/wiki/EtherType (Length field)
// etherType
const bit<16> 	TYPE_IPV4 = 0x0800; // 0b100000000000
const bit<16> 	TYPE_ARP = 0x0806; // 0b100000000110
const bit<16>   TYPE_VLAN=0x8100; // VLAN-tagged frame // 0b1000000100000000
const bit<16>   TYPE_IPV6=0x86DD; // 0b1000011011011101
const bit<16>   TYPE_MPLS_uni=0x8847; // MPLS unicast // 0b1000100001000111
const bit<16>   TYPE_MPLS_mul=0x8848; // MPLS multicast // 0b1000100001001000

// IP protocol numbers found in the field Protocol of the IPv4 header and the Next Header field of the IPv6 header
// It is an identifier for the encapsulated protocol and determines the layout of the data that immediately follows the header
// This field defines the protocol used in the data portion of the IP datagram
// https://en.wikipedia.org/wiki/List_of_IP_protocol_numbers
const bit<8>    PROTO_ICMP=1;
const bit<8>    PROTO_IPV4=4;
const bit<8>    PROTO_TCP=6;
const bit<8>    PROTO_UDP=17;
const bit<8>    PROTO_IPV6=41;

// INT 
const bit<6>    DSCP_INT=0x17;

// INT Header type - destination and hop-by-hop
const bit<8>    INT_TYPE_DST=0x1;
const bit<8>    INT_TYPE_HOP=0x2;