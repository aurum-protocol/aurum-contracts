// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Test, console} from "forge-std/Test.sol";
import {IPool} from "../src/aave-interfaces/IPool.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IPoolConfigurator} from "../src/aave-interfaces/IPoolConfigurator.sol";

contract RepairTest is Test {
    address public constant MULTISIG = 0x1dF49E1211c2fd664b3D7A7480230E36f157e328;
    address public constant TOKEN_USDC = 0x29219dd400f2Bf60E5a23d13Be72B486D4038894;
    address public constant TOKEN_scUSD = 0xd3DCe716f3eF535C5Ff8d041c1A41C3bd89b97aE;
    address public constant ATTACKER = 0x56b22355b8115EE3411735DD2d745f645eE5Ed63;

    IPool public pool;
    IPoolConfigurator public poolConfigurator;

    constructor() {
        vm.selectFork(vm.createFork(vm.envString("SONIC_RPC_URL")));
        vm.rollFork(5133676); // Jan-23-2025 02:38:41 PM +UTC
        pool = IPool(0x69f196a108002FD75d4B0a1118Ee04C065a63dE9);
        poolConfigurator = IPoolConfigurator(0x1EAd8D9f5ACb2f32F32a21Cee1Dfc43430284a97);

        deal(TOKEN_USDC, address(this), 100e6);
        IERC20(TOKEN_USDC).approve(address(pool), 100e6);
        deal(TOKEN_scUSD, address(this), 100e6);
        IERC20(TOKEN_scUSD).approve(address(pool), 100e6);

    }

    function test_some() public {
//        pool.supply(TOKEN_USDC, 10e6, address(this), 0);
//        pool.supply(TOKEN_scUSD, 10e6, address(this), 0);

        vm.startPrank(MULTISIG);
//        poolConfigurator.setReservePause(TOKEN_scUSD, true);
        poolConfigurator.setReserveFreeze(TOKEN_scUSD, true);
        poolConfigurator.configureReserveAsCollateral(TOKEN_scUSD, 1, 100, 11000);
        vm.stopPrank();

        vm.startPrank(ATTACKER);
        pool.borrow(TOKEN_USDC, 1e5, 2, 0, ATTACKER);
        vm.stopPrank();
//        assertEq(uint(0),0);
    }

}
