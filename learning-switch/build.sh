#!/bin/sh

# Step 1 : Create *.json and *.p4info
make

# Step 2 : 
sudo python ../utils/run_exercise.py --topo topology.json --switch_json learning-switch.json --behavioral-exe simple_switch_grpc
# sudo python ../utils/run_exercise.py --topo topology.json --switch_json learning-switch.json --behavioral-exe simple_switch_grpc --> Why?
