// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Test.sol";
import "../script/Preservation.s.sol";

contract PreservationTest is Test {
    PreservationHack public attacker;

    function setUp() public {
        attacker = new PreservationHack();
    }

    function testPreservationHack() public {
        attacker.run();
        require(
            attacker.preservation().owner() == attacker.eoa(),
            "Preservation Hacking Failed"
        );
    }
}
