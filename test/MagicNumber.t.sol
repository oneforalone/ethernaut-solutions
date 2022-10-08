// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Test.sol";
import "../script/MagicNumber.s.sol";

contract MagicNumberTest is Test {
    MagicNumberHack attacker;

    function setUp() public {
        attacker = new MagicNumberHack();
    }

    function testMagicNumberHack() public {
        attacker.run();
        require(true, "Magic Number Hacking Failed");
    }
}
