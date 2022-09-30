// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Test.sol";
import "../script/Fallout.s.sol";

contract FalloutTest is Test {
    FalloutHack public falloutHack;

    function setUp() public {
        falloutHack = new FalloutHack();
    }

    function testFalloutHack() public {
        falloutHack.run();
        require(
            falloutHack.fallout().owner() == falloutHack.eoa(),
            "Fallout Hacking Failed."
        );
    }
}
