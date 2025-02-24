// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Script} from "forge-std/Script.sol";
import {AggregatorUsdStub} from "../src/AggregatorUsdStub.sol";

contract DeployAggregatorUsdStub is Script {
    function run() public {
        uint deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        new AggregatorUsdStub();
        vm.stopBroadcast();
    }

    function testDeploy() public {}

}
