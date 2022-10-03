// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Test.sol";
import "../script/Privacy.s.sol";

contract PrivacyTest is Test {
    PrivacyHack public privacyHack;

    function setUp() public {
        privacyHack = new PrivacyHack();
    }

    function testPrivacyHack() public {
        privacyHack.run();
        require(
            privacyHack.privacy().locked() == false,
            "Privacy Hacking Failed"
        );
    }
}
