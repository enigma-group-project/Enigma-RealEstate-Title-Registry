// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

/// @title IssuerRegistry — Slice 1 (Notary Registration)  [STUDENT TEMPLATE]
/// @notice Implement every TODO(member1). Behavior is described in docs/issuer-module.md and
///         locked by test/IssuerRegistry.t.sol — run `forge test` until it is green.
contract IssuerRegistry {
    address public registrar;
    mapping(address => bool) public isNotary;

    event RegistrarTransferred(address indexed from, address indexed to);
    event NotaryRegistered(address indexed issuer, address indexed by);
    event NotaryDeregistered(address indexed issuer, address indexed by);

    error NotRegistrar();
    error ZeroAddress();

    modifier onlyRegistrar() {
        if (msg.sender != registrar) revert NotRegistrar();
        _;
    }

    constructor() {
        registrar = msg.sender;
        emit RegistrarTransferred(address(0), msg.sender);
    }

    /// @notice Grant the issuer role. Admin-only; reject zero address; emit NotaryRegistered.
    function registerNotary(address account) external onlyRegistrar {
        // TODO(member1): if account == address(0) revert ZeroAddress();
        //               isNotary[account] = true; emit NotaryRegistered(account, msg.sender);
        revert("TODO(member1): implement registerNotary");
    }

    /// @notice Revoke the issuer role. Admin-only; emit NotaryDeregistered.
    function deregisterNotary(address account) external onlyRegistrar {
        // TODO(member1): isNotary[account] = false; emit NotaryDeregistered(account, msg.sender);
        revert("TODO(member1): implement deregisterNotary");
    }

    /// @notice Transfer the registrar key. Admin-only; reject zero address; emit RegistrarTransferred.
    function transferRegistrar(address newAdmin) external onlyRegistrar {
        // TODO(member1): validate newAdmin, emit RegistrarTransferred(registrar, newAdmin), then registrar = newAdmin;
        revert("TODO(member1): implement transferRegistrar");
    }
}
