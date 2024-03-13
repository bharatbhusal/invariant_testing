// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.23;

import {WETH9} from "../../src/WETH9.sol";
import {CommonBase} from "forge-std/Base.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {StdUtils} from "forge-std/StdUtils.sol";

import "forge-std/console2.sol";

contract Handler is CommonBase, StdCheats, StdUtils {
    WETH9 public weth;
    uint256 public constant ETH_SUPPLY = 120_500_000 ether;

    constructor(WETH9 _weth) {
        weth = _weth;
        deal(address(this), ETH_SUPPLY);
    }

    function deposit(uint256 amount) public {
        // amount = bound(amount, 0, 10);
        amount = bound(amount, 0, address(this).balance);
        weth.deposit{value: amount}();
    }

    function withdraw(uint256 amount) public {
        // bound(amount, 0, 10);
        console2.log(amount);
        amount = bound(amount, 0, weth.balanceOf(address(this)));
        weth.withdraw(amount);
    }

    receive() external payable {}
}
