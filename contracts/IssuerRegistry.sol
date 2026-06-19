// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
/// @title IssuerRegistry — Slice 1 (Notary Registration)  [STUDENT TEMPLATE]
contract IssuerRegistry is Ownable {
    mapping(address => bool) public isNotary;
    event RegistrarTransferred(address indexed from, address indexed to);
    event NotaryRegistered(address indexed notary, address indexed by);
    event NotaryDeregistered(address indexed notary, address indexed by);
    error NotRegistrar(); error ZeroAddress();
    modifier onlyRegistrar() { if (msg.sender != owner()) revert NotRegistrar(); _; }
    constructor() Ownable(msg.sender) { emit RegistrarTransferred(address(0), msg.sender); }
    function registrar() external view returns (address) { return owner(); }
    function registerNotary(address account) external onlyRegistrar { revert("TODO(member1): implement registerNotary"); }
    function deregisterNotary(address account) external onlyRegistrar { revert("TODO(member1): implement deregisterNotary"); }
    function transferRegistrar(address newAdmin) external onlyRegistrar { revert("TODO(member1): implement transferRegistrar"); }
}
