// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Script.sol";
import "../src/MagicNumber.sol";

contract MagicNumberHack is Script {
    MagicNum magicNum;

    function run() public {
        magicNum = new MagicNum();

        // INIT CODE
        // 600a -- push 10 (runtime code size)
        // 600c -- push 12 (runtime code start byte)
        // 6000 -- push 0 (memory address to copy to)
        // 39   -- codecopy
        // 600a -- push amount of bytes to return
        // 6000 -- memory address to start returning from
        // f3   -- return
        // RUNTIME CODE
        // 602a -- push value to return (42 in decimal)
        // 6080 -- push mem address to store
        // 52   -- mstore
        // 6020 -- push number of bytes to return
        // 6080 -- push mem address to return
        // f3   -- return
        bytes
            memory code = "\x60\x0a\x60\x0c\x60\x00\x39\x60\x0a\x60\x00\xf3\x60\x2a\x60\x80\x52\x60\x20\x60\x80\xf3";
        address addr;
        assembly {
            addr := create(0, add(code, 0x20), mload(code))
            if iszero(extcodesize(addr)) {
                revert(0, 0)
            }
        }
        magicNum.setSolver(addr);
        uint256 codeSize;
        address solver = magicNum.solver();
        assembly {
            codeSize := extcodesize(solver)
        }
        assert(codeSize <= 10);
        console.log(codeSize);
    }
}
