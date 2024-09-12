// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Test, console } from "forge-std/Test.sol";
import { Bank } from "../src/Bank.sol";

contract BankTest is Test {
    Bank public bank;
    address public user;

    function setUp() public {
        bank = new Bank();
        user = vm.addr(0x1234);
        vm.deal(address(bank), 100 ether);
        vm.deal(user, 1 ether);
    }

    function test_deposit() public {
        vm.startPrank(user);
        bank.deposit{value: 1 ether}();
        bank.withdraw(1 ether);
        assertEq(bank.getBalance(), 1 ether);
        assertEq(bank.balanceOf(user), 0);
        assertEq(bank.balances(user), 0);
    }

    function test_withdraw() public {
        vm.startPrank(user);
        bank.deposit{value: 1 ether}();
        bank.withdraw(1 ether);
        assertEq(bank.getBalance(), 0);
        assertEq(bank.balanceOf(user), 0);
        assertEq(bank.balances(user), 0);
        assertEq(user.balance, 1 ether);
    }

    function test_withdraw_negative() public {
        vm.startPrank(user);
        bank.deposit{value: 0}();
        vm.expectRevert();
        bank.withdraw(address(bank).balance);

        assertEq(address(bank).balance, 100 ether);
        assertEq(user.balance, 1 ether);
    }
    



}
