// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract Aurum is ERC20, ERC20Burnable, Ownable, ERC20Permit {
    constructor(address initialOwner) ERC20("Aurum", "AUR") Ownable(initialOwner) ERC20Permit("Aurum") {
        _mint(initialOwner, 3_000_000 * 10 ** decimals());
    }

    function mint(address to, uint amount) public onlyOwner {
        require(totalSupply() + amount <= 20_000_000 * 10 ** decimals(), "Max supply");
        _mint(to, amount);
    }
}
