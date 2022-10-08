// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Test.sol";
import "../script/Shop.s.sol";

contract ShopTest is Test {
    ShopHack attacker;

    function setUp() public {
        attacker = new ShopHack();
    }

    function testShopHack() public {
        attacker.run();
        require(attacker.shop().isSold() == true, "Shop Hacking Failed");
    }
}
