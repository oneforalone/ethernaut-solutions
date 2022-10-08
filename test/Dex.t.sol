// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Test.sol";
import "../script/Dex.s.sol";

contract DexTest is Test {
    DexHack attacker;

    function setUp() public {
        attacker = new DexHack();
    }

    function testDexHack() public {
        attacker.run();
        require(
            (attacker.token1().balanceOf(address(attacker.dex())) == 0) ||
                (attacker.token2().balanceOf(address(attacker.dex())) == 0),
            "Dex Hacking Failed"
        );
    }
}
