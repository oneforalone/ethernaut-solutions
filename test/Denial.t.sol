// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Test.sol";
import "../script/Denial.s.sol";

contract DenialTest is Test {
    DenialHack attacker;

    function setUp() public {
        attacker = new DenialHack();
    }

    function testDenialHack() public {
        attacker.run();
        require(
            (attacker.result() == false) &&
                (attacker.denial().contractBalance() < 1_000 ether),
            "Denial Hacking Failed"
        );
    }
}
