// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Test.sol";
import "../script/Fallback.s.sol";

contract FallbackTest is Test {
    FallbackHack fallbackHack;

    function setUp() public {
        fallbackHack = new FallbackHack();
    }

    function testFallbackHack() public {
        fallbackHack.run();
        require(
            fallbackHack.fb().owner() == fallbackHack.eoa(),
            "Fallback Hacking Failed"
        );
    }
}
