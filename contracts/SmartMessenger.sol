// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "contracts/2_Owner.sol";

contract SmartMessenger is Owner{
    string public message;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function setMessage(string memory _msg) public isOwner{
        message = _msg;
    }
}