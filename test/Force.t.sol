// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Test.sol";
import "../script/Force.s.sol";

contract ForceTest is Test {
    ForceHack public forceHack;

    function setUp() public {
        forceHack = new ForceHack();
    }

    function testForceHack() public {
        forceHack.run();
        require(address(forceHack.force()).balance > 0, "Force Hacking Failed");
    }
}
