// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Bank {
    mapping (address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 _amount) public {
        require(balances[msg.sender] >= _amount);
        payable(msg.sender).call{value: _amount}("");        
        unchecked {
             {
                balances[msg.sender] -= _amount;
             }
        }
    }

    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    function balanceOf(address _address) public view returns (uint) {
        return balances[_address];
    }
}

