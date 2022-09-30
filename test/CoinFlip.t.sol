// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Test.sol";
import "../script/CoinFlip.s.sol";

contract CoinFlipTest is Test {
    CoinFlipHack public coinFlipHack;

    function setUp() public {
        coinFlipHack = new CoinFlipHack();
    }

    function testCoinFlipHack() public {
        coinFlipHack.run();
        require(coinFlipHack.flipCounts() == 10, "CoinFlip Hacking Failed");
    }
}
