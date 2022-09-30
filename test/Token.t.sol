// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "../script/Token.s.sol";

contract TokenTest is Test {
    TokenHack public tokenHack;

    function setUp() public {
        tokenHack = new TokenHack();
    }

    function testTokenHack() public {
        tokenHack.run();
        require(
            tokenHack.token().balanceOf(tokenHack.eoa()) > 20,
            "Token Hack Failed"
        );
    }
}
