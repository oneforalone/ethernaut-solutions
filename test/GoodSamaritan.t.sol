// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Test.sol";
import "../script/GoodSamaritan.s.sol";

contract GoodSamaritanTest is Test {
    GoodSamaritanHack attacker;

    function setUp() public {
        attacker = new GoodSamaritanHack();
        attacker.setUp();
    }

    function testGoodSamaritanHack() public {
        attacker.run();
        require(
            attacker.victim().coin().balances(
                address(attacker.victim().wallet())
            ) == 0,
            "Good Samaritan Hacking Failed"
        );
    }
}
