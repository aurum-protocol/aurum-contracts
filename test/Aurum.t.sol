// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Test, console} from "forge-std/Test.sol";
import {Aurum} from "../src/Aurum.sol";

contract AurumTest is Test {
    Aurum public token;
    address public constant MSIG = address(10);

    function test_transfer() public {
        token = new Aurum(MSIG);
        vm.expectRevert();
        token.transferFrom(MSIG, address(this), 10 ** 18);
        vm.prank(MSIG);
        token.approve(address(this), 10 ** 18);
        token.transferFrom(MSIG, address(this), 10 ** 18);
    }
}
