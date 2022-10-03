// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Script.sol";
import "../src/Privacy.sol";

contract PrivacyHack is Script {
    Privacy public privacy;
    bytes32[3] data;

    function run() public {
        data[0] = keccak256(abi.encodePacked(tx.origin, "0"));
        data[1] = keccak256(abi.encodePacked(tx.origin, "1"));
        data[2] = keccak256(abi.encodePacked(tx.origin, "2"));
        privacy = new Privacy(data);

        /*
         * Storage in Privacy contract
         * locked: slot 0,
         * ID: slot 1,
         * flattening, denomination, awkwardness: slot 2,
         * data[0]: slot 3,
         * data[1]: slot 4,
         * data[2]: slot 5
         */
        bytes32 key = vm.load(address(privacy), bytes32(uint256(5)));
        privacy.unlock(bytes16(key));
        console.log(privacy.locked());
    }
}
