// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

/** Imports */
import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract DeployBasicNft is Script {
    uint256 public deployerKey;

    function run() external returns (BasicNft) {
        // if (block.chainid == 31337) {
        //     deployerKey = vm.envUint("ANVIL_PRIVATE_KEY");
        // } else if (block.chainid == 1115511) {
        //     deployerKey = vm.envUint("SEPOLIA_PRIVATE_KEY");
        // }

        // vm.startBroadcast(deployerKey);
        vm.startBroadcast();
        BasicNft basicNft = new BasicNft();
        vm.stopBroadcast();
        return basicNft;
    }
}
