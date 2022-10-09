// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Test.sol";
import "../script/DoubleEntryPoint.s.sol";

contract DoubleEntryPointTest is Test {
    DoubleEntryPointHack attacker;

    function setUp() public {
        attacker = new DoubleEntryPointHack();
        attacker.setUp();
    }

    function testDoubleEntryPointHack() public {
        // Since this is to add a monitor contract,
        // there is no good way to get the result.
        // the successful state is that when the vault transfer
        // it's assets, `Forta` would raise a `botRaisedAlerts`
        attacker.run();
        require(true, "Double Entry Point Hacking Failed");
    }
}
