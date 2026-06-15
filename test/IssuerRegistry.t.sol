// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {IssuerRegistry} from "../contracts/IssuerRegistry.sol";

/// @notice Slice 1 tests — Issuer Registration.
contract IssuerRegistryTest is Test {
    IssuerRegistry issuers;
    address alice = address(0xA11CE);

    function setUp() public {
        issuers = new IssuerRegistry();
    }

    function test_AdminIsDeployer() public view {
        assertEq(issuers.registrar(), address(this));
    }

    function test_RegisterAndRevokeIssuer() public {
        issuers.registerNotary(alice);
        assertTrue(issuers.isNotary(alice));
        issuers.deregisterNotary(alice);
        assertFalse(issuers.isNotary(alice));
    }

    function test_RevertWhen_NonAdminRegisters() public {
        vm.prank(alice);
        vm.expectRevert(IssuerRegistry.NotRegistrar.selector);
        issuers.registerNotary(alice);
    }

    function test_RevertWhen_RegisterZeroAddress() public {
        vm.expectRevert(IssuerRegistry.ZeroAddress.selector);
        issuers.registerNotary(address(0));
    }
    // TODO(slice-1): add registrar-handover test (transferRegistrar).
}
