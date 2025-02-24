// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {IAggregatorInterfaceMinimal} from "./interfaces/IAggregatorInterfaceMinimal.sol";

contract AggregatorUsdStub is IAggregatorInterfaceMinimal {
    uint8 internal constant _DECIMALS = 8;

    /// @inheritdoc IAggregatorInterfaceMinimal
    function decimals() external pure returns (uint8) {
        return _DECIMALS;
    }

    /// @inheritdoc IAggregatorInterfaceMinimal
    function latestAnswer() external pure returns (int) {
        return 1e8;
    }

    /// @inheritdoc IAggregatorInterfaceMinimal
    function latestTimestamp() external view returns (uint) {
        return block.timestamp;
    }
}
