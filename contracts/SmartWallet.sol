// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

import "./2_Owner.sol";

contract SmartWallet is Owner {
    address public owner;
    uint256 private _balance = 0;
    mapping(address => bool) public guardiansAddressApprovalMap;
    address[5] public guardians;

    constructor(address[5] memory _guardians) {
        owner = msg.sender;
        guardians = _guardians;
        for (uint8 i = 0; i < guardians.length ;i++ ){
            guardiansAddressApprovalMap[guardians[i]] = false; 
        }
    }

    modifier isGuardian() {
        require(guardiansAddressApprovalMap[msg.sender] == false);
        _;
    }

    function guardianApproveOwnerChange() external isGuardian {
        guardiansAddressApprovalMap[msg.sender] = true;
    }

    function getTotalApproved() internal view returns (uint8) {
        uint8 approvalCount;
        for (uint8 i = 0; i < guardians.length ;i++ ){
            if(guardiansAddressApprovalMap[guardians[i]])
                approvalCount++; 
        }
        return approvalCount;
    }

    receive() external payable { 
        _balance += msg.value;
    }

    function spend(uint _value, address _to) public isOwner {
        require(_value <= _balance);
        uint value = _balance - _value;
        payable(_to).transfer(_value);
        _balance = value;
    }

    function updateOwner(address _newOwner) public isOwner {
        require (_newOwner != owner, "can not be the same address");
        require(getTotalApproved() >= 3, "approval count less than 3");
        owner = _newOwner;
    }
}
