// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Test, console} from "forge-std/Test.sol";
import {MockAggregator} from "./mocks/MockAggregator.sol";
import {AggregatorAdapter} from "../src/AggregatorAdapter.sol";

contract AggregatorAdapterTest is Test {
    function test_aggregator_18_decimals() public {
        MockAggregator source = new MockAggregator(18, 100029978e10);
        AggregatorAdapter adapter = new AggregatorAdapter(address(source));
        assertEq(adapter.source(), address(source));
        assertEq(adapter.decimals(), 8);
        assertEq(adapter.latestAnswer(), 100029978);
        assertGt(adapter.latestTimestamp(), 0);
    }

    function test_aggregator_8_decimals() public {
        MockAggregator source = new MockAggregator(8, 100029978);
        AggregatorAdapter adapter = new AggregatorAdapter(address(source));
        assertEq(adapter.source(), address(source));
        assertEq(adapter.decimals(), 8);
        assertEq(adapter.latestAnswer(), 100029978);
    }

    function test_aggregator_negative_price() public {
        MockAggregator source = new MockAggregator(18, -100029978e10);
        AggregatorAdapter adapter = new AggregatorAdapter(address(source));
        assertEq(adapter.latestAnswer(), -100029978);
    }

    function test_aggregator_zero_price() public {
        MockAggregator source = new MockAggregator(18, 0);
        AggregatorAdapter adapter = new AggregatorAdapter(address(source));
        assertEq(adapter.latestAnswer(), 0);
    }

    function test_aggregator_timestamp_sync() public {
        MockAggregator source = new MockAggregator(18, 100029978e10);
        AggregatorAdapter adapter = new AggregatorAdapter(address(source));
        assertEq(adapter.latestTimestamp(), source.latestTimestamp());
    }

    function testFail_aggregator_invalid_source() public {
        AggregatorAdapter adapter = new AggregatorAdapter(address(0));
    }
}
