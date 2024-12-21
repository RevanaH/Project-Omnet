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

network LoRaVehicleTest
{
    parameters:
        int numberOfNodes = default(5); // Jumlah node
        int numberOfGateways = default(1); // Jumlah gateway
        int networkSizeX = default(5000); // Area jaringan
        int networkSizeY = default(5000);
        @display("bgb=5620,4170");
    submodules:
        loRaNodes[numberOfNodes]: LoRaNode {
            @display("p=400,304");
        }
        loRaGW[numberOfGateways]: LoRaGW {
            @display("p=272,291");
        }
        LoRaMedium: LoRaMedium {
            @display("p=399,66");
        }
        networkServer: StandardHost {
            parameters:
                @display("p=49,44");
        }
        configurator: Ipv4NetworkConfigurator {
            parameters:
                assignDisjunctSubnetAddresses = false;
                @display("p=514,31");
        }
        internetCloud: InternetCloud {
            @display("p=272,44");
        }
        gwRouter[numberOfGateways]: Router {
            //            @display("p=278,141, uniform(200, 300)");
            @display("p=231,134");
        }
        nsRouter: Router {
            @display("p=137,44");
        }
    connections:
        networkServer.ethg++ <--> Eth1G <--> nsRouter.ethg++;
        nsRouter.pppg++ <--> Eth1G <--> internetCloud.pppg++;
        for i=0..numberOfGateways-1 {
            internetCloud.pppg++ <--> Eth1G <--> gwRouter[i].pppg++;
            gwRouter[i].ethg++ <--> Eth1G <--> loRaGW[i].ethg++;
        }
}
network LoRaVehicleTest1000
{
    parameters:
        int numberOfNodes = default(7);
        int numberOfGateways = default(1);
        int networkSizeX = default(2000);
        int networkSizeY = default(2000);
        @display("bgb=2000,2000");
    submodules:
        loRaNodes[numberOfNodes]: LoRaNode {
            @display("p=400,304");
        }
        loRaGW[numberOfGateways]: LoRaGW {
            //@display("p=157,238;is=s");
            @display("p=1000,1000;is=s");
        }
        LoRaMedium: LoRaMedium {
            @display("p=1152,864");
        }
        networkServer: StandardHost {
            parameters:
                @display("p=892,806");
        }
        configurator: Ipv4NetworkConfigurator {
            parameters:
                assignDisjunctSubnetAddresses = false;
                @display("p=1161,689");
        }
        internetCloud: InternetCloud {
            @display("p=1074,806");
        }
        gwRouter[numberOfGateways]: Router {
            @display("p=1074,896");
        }
        nsRouter: Router {
            @display("p=980,806");
        }
    connections:
        networkServer.ethg++ <--> Eth1G <--> nsRouter.ethg++;
        nsRouter.pppg++ <--> Eth1G <--> internetCloud.pppg++;
        for i=0..numberOfGateways-1 {
            internetCloud.pppg++ <--> Eth1G <--> gwRouter[i].pppg++;
            gwRouter[i].ethg++ <--> Eth1G <--> loRaGW[i].ethg++;
        }

}

network LoRaVehicleTest2000
{
    parameters:
        int numberOfNodes = default(7);
        int numberOfGateways = default(1);
        int networkSizeX = default(4000);
        int networkSizeY = default(4000);
        @display("bgb=4000,4000");
    submodules:
        loRaNodes[numberOfNodes]: LoRaNode {
            @display("p=400,304");
        }
        loRaGW[numberOfGateways]: LoRaGW {
            //@display("p=157,238;is=s");
            @display("p=2000,2000;is=s");
        }
        LoRaMedium: LoRaMedium {
            @display("p=2152,1864");
        }
        networkServer: StandardHost {
            parameters:
                @display("p=1892,1806");
        }
        configurator: Ipv4NetworkConfigurator {
            parameters:
                assignDisjunctSubnetAddresses = false;
                @display("p=2161,1689");
        }
        internetCloud: InternetCloud {
            @display("p=2074,1806");
        }
        gwRouter[numberOfGateways]: Router {
            @display("p=2074,1896");
        }
        nsRouter: Router {
            @display("p=1980,1806");
        }
    connections:
        networkServer.ethg++ <--> Eth1G <--> nsRouter.ethg++;
        nsRouter.pppg++ <--> Eth1G <--> internetCloud.pppg++;
        for i=0..numberOfGateways-1 {
            internetCloud.pppg++ <--> Eth1G <--> gwRouter[i].pppg++;
            gwRouter[i].ethg++ <--> Eth1G <--> loRaGW[i].ethg++;
        }

}

network LoRaVehicleTest3000
{
    parameters:
        int numberOfNodes = default(7);
        int numberOfGateways = default(1);
        int networkSizeX = default(6000);
        int networkSizeY = default(6000);
        @display("bgb=6000,6000");
    submodules:
        loRaNodes[numberOfNodes]: LoRaNode {
            @display("p=400,304");
        }
        loRaGW[numberOfGateways]: LoRaGW {
            //@display("p=157,238;is=s");
            @display("p=3000,3000;is=s");
        }
        LoRaMedium: LoRaMedium {
            @display("p=3152,2864");
        }
        networkServer: StandardHost {
            parameters:
                @display("p=2892,2806");
        }
        configurator: Ipv4NetworkConfigurator {
            parameters:
                assignDisjunctSubnetAddresses = false;
                @display("p=3161,2689");
        }
        internetCloud: InternetCloud {
            @display("p=3074,2806");
        }
        gwRouter[numberOfGateways]: Router {
            @display("p=3074,2896");
        }
        nsRouter: Router {
            @display("p=2980,2806");
        }
    connections:
        networkServer.ethg++ <--> Eth1G <--> nsRouter.ethg++;
        nsRouter.pppg++ <--> Eth1G <--> internetCloud.pppg++;
        for i=0..numberOfGateways-1 {
            internetCloud.pppg++ <--> Eth1G <--> gwRouter[i].pppg++;
            gwRouter[i].ethg++ <--> Eth1G <--> loRaGW[i].ethg++;
        }

}

