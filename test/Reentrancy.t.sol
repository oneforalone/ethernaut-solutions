// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Test.sol";
import "../script/Reentrancy.s.sol";

contract ReentrancyTest is Test {
    ReentrancyHack public reentrancyHack;

    function setUp() public {
        reentrancyHack = new ReentrancyHack();
    }

    function testReentrancyHack() public {
        reentrancyHack.run();
        require(
            address(reentrancyHack.reentrancy()).balance == 0,
            "Reentrancy Hacking Failed"
        );
    }
}
