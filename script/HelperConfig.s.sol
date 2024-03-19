// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import {Script} from "forge-std/Script.sol";
import { MockV3Aggregator }  from "../test/mocks/MockV3Aggregator.sol";

contract HelperConfig is Script {

    NetworkConfig public activeNetworkConfig;

    struct NetworkConfig{
        address priceFeed;
    }

    constructor(){
        if (block.chainid == 11155111){
            activeNetworkConfig = getSepoliaEthConfig();
        } else if (block.chainid == 1){
            activeNetworkConfig = getMainNetEthConfig();
        }        
        else{
            activeNetworkConfig = getAnvilEthConfig();
        }

    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory sepoliaConfig = NetworkConfig({
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        });

        return sepoliaConfig;
    }

    function getMainNetEthConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory mainNetConfig = NetworkConfig({
            priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        });

        return mainNetConfig;
    }

    function getAnvilEthConfig() public returns (NetworkConfig memory) {
        
        vm.startBroadcast();
        MockV3Aggregator priceFeed = new MockV3Aggregator(8, 3000);
        vm.stopBroadcast();

        NetworkConfig memory anvilConfig = NetworkConfig({
            priceFeed: address(priceFeed)
        });

        return anvilConfig;
    }

}