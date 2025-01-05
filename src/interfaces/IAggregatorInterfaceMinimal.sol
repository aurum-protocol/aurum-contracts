// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

interface IAggregatorInterfaceMinimal {
    /// @notice represents the number of decimals the aggregator responses represent
    function decimals() external view returns (uint8);

    /// @notice Reads the current answer from aggregator delegated to
    function latestAnswer() external view returns (int);

    /// @notice Get the latest completed round where the answer was updated
    function latestTimestamp() external view returns (uint);
}
