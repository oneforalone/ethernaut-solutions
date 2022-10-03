// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Test.sol";
import "../script/Elevator.s.sol";

contract ElevatorTest is Test {
    ElevatorHack public elevatorHack;

    function setUp() public {
        elevatorHack = new ElevatorHack();
    }

    function testElevatorHack() public {
        elevatorHack.run();
        require(elevatorHack.elevator().top(), "Elevator Hacking Failed");
    }
}
