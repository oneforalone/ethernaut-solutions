// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Test.sol";
import "../script/GatekeeperOne.s.sol";

contract GatekeeperTest is Test {
    GatekeeperOneHack public attacker;

    function setUp() public {
        attacker = new GatekeeperOneHack();
    }

    function testGatekeeperOneHack() public {
        attacker.run();
        require(
            attacker.gatekeeper().entrant() == tx.origin,
            "GatekeeperOne Hacking Failed"
        );
    }
}
