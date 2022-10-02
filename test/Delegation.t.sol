// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Test.sol";
import "../script/Delegation.s.sol";

contract DelegationTest is Test {
    DelegationHack public delegationHack;

    function setUp() public {
        delegationHack = new DelegationHack();
    }

    function testDelegationHack() public {
        delegationHack.run();
        require(
            delegationHack.delegation().owner() == delegationHack.eoa(),
            "Delegation Hacking Failed"
        );
    }
}
