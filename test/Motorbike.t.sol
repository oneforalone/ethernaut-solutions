// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Test.sol";
import "../script/Motorbike.s.sol";

contract MotorbikeTest is Test {
    MotorbikeHack attacker;

    function setUp() public {
        attacker = new MotorbikeHack();
        attacker.setUp();
    }

    function testMotorbikeHack() public {
        /*
         * Because of the way foundry test work it is very hard to verify this * test was successful
         * Selfdestruct is a substate (see pg 8 https://ethereum.github.io/yellowpaper/paper.pdf)
         * This means it gets executed at the end of a transaction, a single
         * test is a single transaction. This means we can call selfdestruct on
         * the engine contract at the start of the test but we will continue to
         * be allowed to call all other contract function for the duration of
         * that transaction (test), since the selfdestruct execution only happy
         * at the end
         */
        vm.expectRevert("Call failed");
        attacker.run();
    }
}
