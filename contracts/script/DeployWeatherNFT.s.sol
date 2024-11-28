// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/WeatherNFT.sol";

contract DeployWeatherNFT is Script {
    function run() external {
        vm.startBroadcast();

        WeatherNFT nft = new WeatherNFT();

        console.log("WeatherNFT deployed at:", address(nft));

        vm.stopBroadcast();
    }
}
