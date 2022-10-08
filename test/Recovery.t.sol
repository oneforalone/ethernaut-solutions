// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Test.sol";
import "../script/Recovery.s.sol";

contract RecoveryTest is Test {
    RecoveryHack attacker;

    function setUp() public {
        attacker = new RecoveryHack();
    }

    function testRecoveryHack() public {
        attacker.run();
        require(attacker.tokenAddr().balance == 0, "Recovery Hacking Failed");
    }
}
