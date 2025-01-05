// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {IAggregatorInterfaceMinimal} from "../../src/interfaces/IAggregatorInterfaceMinimal.sol";

contract MockAggregator is IAggregatorInterfaceMinimal {
    uint8 public immutable decimals;
    int public immutable latestAnswer;

    constructor(uint8 decimals_, int latestAnswer_) {
        decimals = decimals_;
        latestAnswer = latestAnswer_;
    }

    function latestTimestamp() external pure returns (uint) {
        return 1736037010;
    }

    // add this to be excluded from coverage report
    function test() public {}
}
