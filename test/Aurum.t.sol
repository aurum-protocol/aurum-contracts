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

    function test_burn() public {
        token = new Aurum(MSIG);
        vm.startPrank(MSIG);
        uint256 initialBalance = token.balanceOf(MSIG);
        uint256 burnAmount = 1000 * 10 ** 18;
        token.burn(burnAmount);
        assertEq(token.balanceOf(MSIG), initialBalance - burnAmount);
        vm.stopPrank();
    }

    function test_burnFrom() public {
        token = new Aurum(MSIG);
        vm.prank(MSIG);
        token.approve(address(this), 1000 * 10 ** 18);
        token.burnFrom(MSIG, 1000 * 10 ** 18);
        assertEq(token.allowance(MSIG, address(this)), 0);
    }

    function test_ownership() public {
        token = new Aurum(MSIG);
        vm.prank(MSIG);
        token.transferOwnership(address(1));
        assertEq(token.owner(), address(1));
        
        vm.expectRevert();
        token.mint(address(this), 1); // Should revert as called from non-owner
        
        vm.prank(address(1));
        token.mint(address(this), 1); // Should succeed as called from new owner
    }

    function test_permit() public {
        token = new Aurum(MSIG);
        uint256 privateKey = 0xBEEF;
        address owner = vm.addr(privateKey);
        
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            privateKey,
            keccak256(
                abi.encodePacked(
                    "\x19\x01",
                    token.DOMAIN_SEPARATOR(),
                    keccak256(
                        abi.encode(
                            keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"),
                            owner,
                            address(this),
                            1e18,
                            0,
                            block.timestamp
                        )
                    )
                )
            )
        );

        token.permit(owner, address(this), 1e18, block.timestamp, v, r, s);
        assertEq(token.allowance(owner, address(this)), 1e18);
    }
}
