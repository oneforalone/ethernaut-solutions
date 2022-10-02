// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Test.sol";
import "../script/Vault.s.sol";

contract VaultTest is Test {
    VaultHack public vaultHack;

    function setUp() public {
        vaultHack = new VaultHack();
    }

    function testVaultHack() public {
        vaultHack.run();
        require(vaultHack.vault().locked() == false, "Vault Hacking Failed");
    }
}
