// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract Aurum is ERC20, ERC20Permit {
    constructor(address treasury) ERC20("Aurum", "AUR") ERC20Permit("Aurum") {
        _mint(treasury, 20_000_000 * 10 ** decimals());
    }
}
