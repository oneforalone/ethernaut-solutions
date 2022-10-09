// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Test.sol";
import "../script/PuzzleWallet.s.sol";

contract PuzzleWalletTest is Test {
    PuzzleWalletHack attacker;

    function setUp() public {
        attacker = new PuzzleWalletHack();
        attacker.setUp();
    }

    function testPuzzleWalletHack() public {
        attacker.run();
        require(
            attacker.wallet().owner() == attacker.eoa(),
            "Puzzle Wallet Hacking Failed"
        );
    }
}
