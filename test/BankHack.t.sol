// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import { Test, console } from "forge-std/Test.sol";
import { Bank } from "../src/BankHack.sol";
import { BankHack } from "../src/BankHack.sol";

contract BankHackTest is Test {
    address public user;
    Bank public bank;
    BankHack public bankHack;

    function setUp() public {
        user = vm.addr(0x1234);
        bank = new Bank();
        bankHack = new BankHack(address(bank));
        vm.deal(bank, 100 ether);
        vm.deal(user,1 ether);
    }

    function test_withdraw() public {
        vm.startPrank(user);
        bank.deposit{value: 1 ether}();
        assertEq(address(bank).balance, 0);
    }
}