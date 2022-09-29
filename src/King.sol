// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract King {
    address payable king;
    uint256 public prize;
    address payable public owner;

    // remove visibility warning
    constructor() payable {
        // TypeError: address must be payable
        owner = payable(msg.sender);
        king = payable(msg.sender);
        prize = msg.value;
    }

    receive() external payable {
        require(msg.value >= prize || msg.sender == owner);
        king.transfer(msg.value);
        // TypeError: address must be payable
        king = payable(msg.sender);
        prize = msg.value;
    }

    function _king() public view returns (address payable) {
        return king;
    }
}
