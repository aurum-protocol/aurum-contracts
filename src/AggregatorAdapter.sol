// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {IAggregatorInterfaceMinimal} from "./interfaces/IAggregatorInterfaceMinimal.sol";

/// @title Adapter that normalize decimals for Chainlink-compatible aggregators
/// @author Alien Deployer (https://github.com/a17)
contract AggregatorAdapter is IAggregatorInterfaceMinimal {
    uint8 internal constant _DECIMALS = 8;

    address public immutable source;

    uint8 internal immutable sourceDecimals;

    constructor(address source_) {
        source = source_;
        sourceDecimals = IAggregatorInterfaceMinimal(source_).decimals();
    }

    /// @inheritdoc IAggregatorInterfaceMinimal
    function decimals() external pure returns (uint8) {
        return _DECIMALS;
    }

    /// @inheritdoc IAggregatorInterfaceMinimal
    function latestAnswer() external view returns (int) {
        IAggregatorInterfaceMinimal _source = IAggregatorInterfaceMinimal(source);
        // assume that source cant have less decimals than _DECIMALS
        int divider = int(10 ** (sourceDecimals - _DECIMALS));
        return _source.latestAnswer() / divider;
    }

    /// @inheritdoc IAggregatorInterfaceMinimal
    function latestTimestamp() external view returns (uint) {
        return IAggregatorInterfaceMinimal(source).latestTimestamp();
    }
}
