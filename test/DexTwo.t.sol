// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Test.sol";
import "../script/DexTwo.s.sol";

contract DexTwoTest is Test {
    DexTwoHack attacker;

    function setUp() public {
        attacker = new DexTwoHack();
    }

    function testDexTwoHack() public {
        attacker.setUp();
        attacker.run();
        require(
            (attacker.token1().balanceOf(address(attacker.dex())) == 0) ||
                (attacker.token2().balanceOf(address(attacker.dex())) == 0),
            "Dex Hacking Failed"
        );
    }
}
