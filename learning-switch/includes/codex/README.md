**codex folder contains selected protocol headers structure for different OSI Layers and some pre-defined field values**

- enum.p4 - contains etherType, Protocol number and INT
- l2.p4 - contains standard ethernet(and can include ethernet 802.1 Q (ethernet with VLAN)) i.e. Layer 2 protocol headers
- l3.p4 - contains ipv4, ipv6, arp, icmp, mpls i.e. Layer 3 protocol headers
- l4.p4 - contains tcp, udp i.e. Layer 4 protocol headers
- l567.p4 - contains sip i.e. Layer 5 protocol headers

[OSI 7 Layer with several protocols](https://en.wikipedia.org/wiki/List_of_network_protocols_(OSI_model))