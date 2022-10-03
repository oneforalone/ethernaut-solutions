// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Test.sol";
import "../script/GatekeeperTwo.s.sol";

contract GatekeeperTwoTest is Test {
    GatekeeperTwoHack public attacker;

    function setUp() public {
        attacker = new GatekeeperTwoHack();
    }

    function testGatekeeperTwoHackTest() public {
        attacker.run();
        require(
            attacker.gatekeeper().entrant() == tx.origin,
            "Gatekeeper Two Hacking Failed"
        );
    }
}
