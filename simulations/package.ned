package flora.simulations;

import inet.applications.udpapp.UdpBasicApp;
import inet.applications.udpapp.UdpSinkApp;
import inet.node.inet.Router;
import inet.node.internetcloud.InternetCloud;
import flora.LoRaPhy.LoRaMedium;
import flora.LoraNode.LoRaNode;
import flora.LoraNode.LoRaGW;
import inet.node.inet.StandardHost;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.ethernet.Eth1G;

@license(LGPL);
network LoRaNetworkTest
{
    parameters:
        int numberOfNodes = default(10);
        int numberOfGateways = default(1);
        int networkSizeX = default(5000);
        int networkSizeY = default(5000);
        @display("bgb=5620,5170");
    submodules:
       // Define LoRa End Devices (nodes)
        loRaNodes[numberOfNodes]: LoRaNode {           // Use the LoRa medium for communication
            @display("p=$x, $y;is=s"); // Random placement
        }

        // Define LoRa Gateway
        loRaGW[numberOfGateways]: LoRaGW {           // Use the LoRa medium for communication
            @display("p=2500,2500;is=s");        // Central placement of the gateway
        }
         LoRaMedium: LoRaMedium {
            @display("p=2600,2500;is=n");
        }

        // Server jaringan diletakkan dekat dengan gateway
        networkServer: StandardHost {
            @display("p=2450,2450;is=n");
        }

        // Konfigurasi IPv4 diletakkan dekat dengan gateway
        configurator: Ipv4NetworkConfigurator {
            assignDisjunctSubnetAddresses = false;
            @display("p=2400,2450;is=n");
        }

        // Internet Cloud diletakkan dekat dengan gateway
        internetCloud: InternetCloud {
            @display("p=2550,2500;is=n");
        }

        // Router gateway diletakkan dekat dengan gateway
        gwRouter[numberOfGateways]: Router {
            @display("p=2500,2550;is=r");
        }

        // Router server jaringan diletakkan dekat dengan gateway
        nsRouter: Router {
            @display("p=2500,2450;is=r");
        }
    connections allowunconnected:
        networkServer.ethg++ <--> Eth1G <--> nsRouter.ethg++;
        nsRouter.pppg++ <--> Eth1G <--> internetCloud.pppg++;
        for i=0..numberOfGateways-1 {
            internetCloud.pppg++ <--> Eth1G <--> gwRouter[i].pppg++;
            gwRouter[i].ethg++ <--> Eth1G <--> loRaGW[i].ethg++;
        }
}
