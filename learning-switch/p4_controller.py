import argparse, os, sys, grpc

# set lib path
sys.path.append(
	os.path.join(os.path.dirname(os.path.abspath(__file__)),
	'../utils/'))

# and them import
# from p4runtime_lib.switch import ShutdownAllSwitchConnections
import p4runtime_lib.switch
import p4runtime_lib.helper
import p4runtime_lib.bmv2

# MAIN FUNCTION
def main(p4info_file_path, bmv2_file_path):
	# Instantiate a P4Runtime helper from the p4info file
	# print(args.p4info, args.bmv2_json)
	p4info_helper = p4runtime_lib.helper.P4InfoHelper(p4info_file_path)
	print(p4info_helper)
	port_map = {}
	arp_rules = {}
	bcast = "ff:ff:ff:ff:ff:ff"

	try:
		"""
		The two switches used in the creation and example-s1, s2
        The P4Runtime gRPC connection is used.
        And dump all P4Runtime messages and send them to the switch for storage in txt format
        -Taking the package of P4 here, port no starts from 50051
		"""

		s1 = p4runtime_lib.bmv2.Bmv2SwitchConnection(
			name = 's1',
			address = '127.0.0.1:50051',
			device_id = 0,
			proto_dump_file = 'logs/p4runtime-requests.txt')
		
		# Send the master arbitration update message to establish, making this controller become
        # master (required by P4Runtime before performing any other write operation)
		s1.MasterArbitrationUpdate()

		# Install the target P4 program to the switch
		s1.setForwardingPipelineConfig(p4info=p4info_helper.p4info,
			bmv2_json_file_path = bmv2_file_path)

		print "Installed P4 Program using SetForardingPipelineConfig on s1"

		# Build Multicast Group Entry
		mc_group_entry = p4info_helper.buildMCEntry(
			mc_group_id = 1,
			relicas = {
			1:1,
			2:2,
			3:3
			})

		s1.WritePRE(mc_group = mc_group_entry)
		print "Installed mgrp on s1."

		# p4info_pb2 -> p4.config.v1
		# p4runtime_pb2 -> p4.v1
		while True:
			packetin = s1.PacketIn()
			if packetin.WhichOneof('update') == 'packet':
				packet = pacektin.packet.payload
				pkt = Ether(_pkt=packet)
				metadata = packetin.packet.metadata
				# meta.value -> port value
				for meta in metadata:
					metadata_id = meta.metadata_id
					value = meta.value

				pkt_eth_src = pkt.getlayer(Ether).src
				pkt_eth_dst = pkt.getlayer(Ether).dst
				ether_type = pkt.getlayer(Ether).type

				# 2048 -> 0x0800, 2054 -> 0x0806
				if ether_type == 2048 or ether_type == 2054:
					# Get value of pkt_eth_src in dictionary port_map
					# if pkt_eth_src not exist insert it with value
					port_map.setdefault(pkt_eth_src, value)
					# map output port to destinations possible
					arg_rules.setdefault(value, [])

					if pkt_eth_dst == bcast:
						if bcast not in arp_rules:
							writeARPFlood(p4info_helper, sw=s1, in_port=value, dst_eth_addr=bcast)
							arp_rules[value].append(bcast)

						# build packetout
						packetout = p4info_helper.buildPacketOut(
							payload = packet,
							metadata = {
								1: "\000\000", 
								2: "\000\001"
							})
						# 1 -> output port
						# 2 -> some kind of choice?
						s1.PacketOut(packetout)
					else:
						if pkt_eth_dst not in arp_rules[value]:
							# I think
							# p4info_help -> instance of p4info
							# sw -> switch, in_port -> input port of packet
							# dst_eth_addr -> destination MAC address
							# port -> output port of packet towards destination
							
							# port_map : of current switch tells output port to go to destination
							# src -> sw=s1[in_port(value) -> port(port_map[pkt_eth_dst])] -> dst
							writeARPReply(p4info_helper,sw=s1,in_port=value,dst_eth_addr=pkt_eth_dst, port=port_map[pkt_eth_dst])
							arp_rules[value].append(pkt_eth_dst)
						if pkt_eth_src not in arp_rules[port_map[pkt_eth_dst]]:
							# dst -> sw=s1[in_port(port_map[pkt_eth_dst]) -> port(port_map[pkt_eth_src])] -> src
							writeARPReply(p4info_helper,sw=s1,in_port=port_map[pkt_eth_dst], port = port_map[pkt_eth_src])
							arp_rules[port_map[pkt_eth_dst]].append(pkt_eth_src)

						packetout = p4info_helper.buildPacketOut(
							payload = packet,
							metadata = {
								1: port_map[pkt_eth_dst],
								2: "\000\000"
							})
							# 1 -> output port
							# 2 -> some kind of choice?
						s1.PacketOut(packetout)
					print("Finished PacketOut.\n=========================")
					print("port_map:", port_map)
					print "arp_rules:%s" % arp_rules
					print "=========================\n"
	except KeyboardInterrupt:
		# using ctrl + c to exit
	   	print "Shutting down."
	except grpc.RpcError as e:
		printGrpcError(e)

	# Then close all the connections
	ShutdownAllSwitchConnections()

# START POSITION
# Simple P4 Controller
if __name__ == '__main__':
	"""
	Args :
	1. p4info - p4info build by p4 program (learning-switch.p4info)
	2. bmv2-json - json build by p4 program(learning-switch.json)
	"""
	parser = argparse.ArgumentParser(description = 'P4Runtime Controller')

	# Argument extraction
	parser.add_argument('--p4info',help='p4info proto in text format from p4c',
		type=str, action="store", required=False,
		default="./learning-switch.p4info")

	parser.add_argument('--bmv2-json',help='BMv2 JSON from p4c',
		type=str, action="store", required=False,
		default="./learning-switch.json")

	args = parser.parse_args()

	if not os.path.exists(args.p4info):
		parser.print_help()
		print "\np4info file not found: %s\nPlease compile the target P4 program first." % args.p4info
		parser.exit(1)
	if not os.path.exists(args.bmv2_json):
		parser.print_help()
		print "\nBMv2 JSON file not found: %s\nPlease compile the target P4 program first." % args.bmv2-json
		parser.exit(1)

	# Pass argument into main function
	main(args.p4info, args.bmv2_json)