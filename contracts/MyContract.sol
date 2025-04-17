// SPDX license identifier: MIT

// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract MyContract {

// Define the state variable and modify it from within a function using the keyword `state`
     bool public myBool;

    function setMyBool(bool _myBool) public {
        myBool = _myBool;
    }
}