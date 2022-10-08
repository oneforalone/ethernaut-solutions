// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Test.sol";
import "../script/AlienCodex.s.sol";

contract AlienCodexTest is Test {
    AlienCodexHack attacker;

    function setUp() public {
        attacker = new AlienCodexHack();
    }

    function testAlienCodexHack() public {
        attacker.run();
        require(
            attacker.owner() == attacker.eoa(),
            "Alien Codex Hacking Failed"
        );
    }
}
