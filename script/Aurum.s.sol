// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Script} from "forge-std/Script.sol";
import {Aurum} from "../src/Aurum.sol";

contract DeployAurum is Script {
    address public constant TREASURY = 0x1dF49E1211c2fd664b3D7A7480230E36f157e328;

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        new Aurum(TREASURY);
        vm.stopBroadcast();
    }

    function testDeploy() public {}
}
