// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Test.sol";
import "../script/King.s.sol";

contract KingTest is Test {
    KingHack public kingHack;

    function setUp() public {
        kingHack = new KingHack();
    }

    function testKingHack() public {
        kingHack.run();
        require(
            kingHack.king()._king() == address(kingHack),
            "King Hacking Failed"
        );
    }
}
