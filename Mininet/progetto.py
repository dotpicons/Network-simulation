#!/usr/bin/python

from mininet.net import Mininet
from mininet.node import Controller, RemoteController, OVSController
from mininet.node import CPULimitedHost, Host, Node
from mininet.node import OVSKernelSwitch, UserSwitch
from mininet.node import IVSSwitch
from mininet.cli import CLI
from mininet.log import setLogLevel, info
from mininet.link import TCLink, Intf
from subprocess import call


a = input ( "Digitare 1 per rate 2-3=10 Mbit, 2 per rate 2-3=500 Kbit:" )

if a == 1:
	print a,": rate s2-s3= 10 Mbit"
	b = 10
if a == 2:
	print a,": rate s2-s3= 500 Kbit"
	b = 0.5
def myNetwork():

    net = Mininet( topo=None,
                   build=False,
                   ipBase='10.0.0.0/8')

    info( '*** Adding controller\n' )
    c0=net.addController(name='c0',
                      controller=Controller,
                      protocol='tcp',
                      port=6633)

    info( '*** Add switches\n')
    s3 = net.addSwitch('s3', cls=OVSKernelSwitch)
    s4 = net.addSwitch('s4', cls=OVSKernelSwitch)

    info( '*** Add hosts\n')
    h6 = net.addHost('h6', cls=Host, ip='10.0.0.6', defaultRoute=None)
    h2 = net.addHost('h2', cls=Host, ip='10.0.0.2', defaultRoute=None)
    h1 = net.addHost('h1', cls=Host, ip='10.0.0.1', defaultRoute=None)
    h5 = net.addHost('h5', cls=Host, ip='10.0.0.5', defaultRoute=None)

    info( '*** Add links\n')
    s4h5 = {'bw':2,'delay':'10ms','max_queue_size':10}
    net.addLink(s4, h5, cls=TCLink , **s4h5)
    s4h6 = {'bw':2,'delay':'10ms','max_queue_size':10}
    net.addLink(s4, h6, cls=TCLink , **s4h6)
    h1s3 = {'bw':2,'delay':'10ms','max_queue_size':10}
    net.addLink(h1, s3, cls=TCLink , **h1s3)
    h2s3 = {'bw':2,'delay':'10ms','max_queue_size':10}
    net.addLink(h2, s3, cls=TCLink , **h2s3)
    s3s4 = {'bw':b,'delay':'10ms','max_queue_size':10}
    net.addLink(s3, s4, cls=TCLink , **s3s4)

    info( '*** Starting network\n')
    net.build()

    info( '*** Starting controllers\n')
    for controller in net.controllers:
        controller.start()

    info( '*** Starting switches\n')
    net.get('s3').start([c0])
    net.get('s4').start([c0])

    info( '*** Post configure switches and hosts\n')
    print " "    
    print " "
    print " "
    print " "
    print "*******Attendi circa 15 secondi...*******"
    print " "
    print " "
    print " "
    print " "
    h1.cmdPrint("iperf -s -p 5566 -i 1 > risultati &")
    h5.cmdPrint("iperf -c 10.0.0.1 -p 5566 -t 15 ")
    h1.cmdPrint("cat risultati | grep sec | head -15 | tr '-' ' ' | awk '{print $4,$8}' > nuovi") 
    #h1.cmdPrint("gnuplot>plot 'nuovi' title 'ftp flow' with linespoints") 
    #h1.cmdPrint("plot nuovi title ftp flow with linespoints ") 

    #CLI(net)
    #net.stop()

if __name__ == '__main__':
    setLogLevel( 'info' )
    myNetwork()

 #h1.cmdPrint("iperf -s -p 5566 -i 1 > result") & h5.cmdPrint("iperf -c 10.0.0.1 -p 5566 -t 15") 




