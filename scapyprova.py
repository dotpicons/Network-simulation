#!/usr/bin/env python

import sys
from scapy.all import *

server_pkt=sr1(IP(dst=sys.argv[1],ttl=(1,10))/TCP())
if server_pkt:
	server_pkt.show()
