// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Test.sol";
import "../script/NaughtCoin.s.sol";

contract NaughtCoinTest is Test {
    NaughtCoinHack public attacker;

    function setUp() public {
        attacker = new NaughtCoinHack();
    }

    function testNaughtCoinHack() public {
        attacker.run();
        require(
            attacker.coin().balanceOf(attacker.eoa()) == 0,
            "NaughtCoin Hacking Failed"
        );
    }
}
