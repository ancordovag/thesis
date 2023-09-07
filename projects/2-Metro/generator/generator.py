#!/bin/python
# Author: Marius Schneider
# Python: 2.7.1
# Generation of Internet-Connection Problem Instances

import random
import sys
import argparse

if __name__ == '__main__':

    description  = "usage: python -O master.py [options]"
    description += "\n not parsed parameters will be interpreted as default parameters for clasp"
    description += "\n Format: --[parameter name]=[new default values]"
    parser = argparse.ArgumentParser(prog="master.py",usage=description)
    req_group = parser.add_argument_group("Required Options")
    req_group.add_argument('--len', dest='len', action='store', default=10, required=True,  help='length of input array')    
    req_group.add_argument('--wid', dest='wid', action='store', default=10, type=int, required=True,  help='width of input array')  
    req_group.add_argument('--rHot', dest='hot', action='store', default=2, type=int, required=True,  help='number of required metros')
    req_group.add_argument('--pHot', dest='phot', action='store', default=5, type=int, required=True,  help='number of possible metro locations')
    req_group.add_argument('--nodes', dest='nodes', action='store', default=5, required=True,  help='number of nodes')
    req_group.add_argument('--maxCon', dest='mCon', action='store', default=5, type=int, required=True,  help='maximal Connections to Metro')
    req_group.add_argument('--maxLast', dest='mLast', action='store', default=5, type=int, required=True,  help='maximal Last to Metro')
    req_group.add_argument('--maxLoss', dest='mLoss', action='store', default=2, type=int, required=True,  help='maximal loss after breakdown of two Metros')
    
    args = parser.parse_args()
    
    fh = open("len"+str(args.len)+"wid"+str(args.wid)+"rHot"+str(args.hot)+"pHot"+str(args.phot)+"nodes"+str(args.nodes)+"maxCon"+str(args.mCon)+"maxLast"+str(args.mLast)+"maxLoss"+str(args.mLoss)+".lp","w")
    
    # print number of hotspots as fact
    fh.write("metros("+str(args.hot)+").\n")
    fh.write("maxLoss("+str(args.mLoss)+").\n")
    
    # generate all possible places for a node
    possible_nodes = []
    for l in range(1,int(args.len)+1):
        for w in range(1,args.wid+1):
            possible_nodes.append([l,w])
    possible_nr = int(args.len) * int(args.wid)
            
    # sample used nodes
    for n in range(1,int(args.nodes)+1):
        rand_id = random.randint(0,possible_nr-1)
        node = possible_nodes.pop(rand_id)
        possible_nr += -1
        last = random.randint(1,100)
        fh.write("lNode("+str(node[0])+","+str(node[1])+","+str(last)+").\n")
    
    for n in range(0,int(args.phot)):
        rand_id = random.randint(0,possible_nr-1)
        node = possible_nodes.pop(rand_id)
        possible_nr += -1
        last = random.randint(10,args.mLast)
        con = random.randint(2,args.mCon)
        fh.write("mNode("+str(node[0])+","+str(node[1])+","+str(last)+","+str(con)+").\n")