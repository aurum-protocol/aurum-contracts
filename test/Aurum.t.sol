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

    function test_mint() public {
        token = new Aurum(MSIG);
        assertEq(token.balanceOf(MSIG), 3_000_000 * 10 ** 18);
        vm.expectRevert();
        token.mint(address(this), 1);
        vm.startPrank(MSIG);
        token.mint(address(this), 1);
        assertEq(token.balanceOf(address(this)), 1);
        vm.expectRevert();
        token.mint(address(this), 17_000_000 * 10 ** 18);
        token.mint(address(this), 17_000_000 * 10 ** 18 - 1);
        vm.expectRevert();
        token.mint(address(this), 1);
        vm.stopPrank();
    }
}
