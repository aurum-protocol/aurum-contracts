// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Script} from "forge-std/Script.sol";
import {AggregatorAdapter} from "../src/AggregatorAdapter.sol";

contract DeployAggregatorAdapters is Script {
    address internal constant SONIC_API3_wS = 0x8927DA1377C78D25E78c335F48a6f8e42Cce0C09;
    address internal constant SONIC_API3_USDC = 0xD3C586Eec1C6C3eC41D276a23944dea080eDCf7f;
    address internal constant SONIC_API3_WETH = 0x5b0cf2b36a65a6BB085D501B971e4c102B9Cd473;

    function run() public {
        uint deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        new AggregatorAdapter(SONIC_API3_wS);
        new AggregatorAdapter(SONIC_API3_USDC);
        new AggregatorAdapter(SONIC_API3_WETH);
        vm.stopBroadcast();
    }

    function testDeploy() public {}
}
