// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "contracts/2_Owner.sol";

contract SmartMoney is Owner {
    uint public accBalance;
    uint public contractBalance;

    function deposit() public payable {
        accBalance = msg.sender.balance;
        contractBalance += msg.value;
    }
    
    // Withdrawal method
    function withdraw(address payable _to) external isOwner {
        require(_to != address(0), "Invalid address");
        _to.transfer(contractBalance);
        accBalance = msg.sender.balance;
        contractBalance = address(this).balance;
    }
}
