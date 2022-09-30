// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Test.sol";
import "../script/Telephone.s.sol";

contract TelephoneTest is Test {
    TelephoneHack public telephoneHack;

    function setUp() public {
        telephoneHack = new TelephoneHack();
    }

    function testTelephoneHack() public {
        telephoneHack.run();
        require(
            telephoneHack.eoa() == telephoneHack.telephone().owner(),
            "Telephone Hacking Failed."
        );
    }
}
