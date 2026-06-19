// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
import {IAttestationRegistry} from "./interfaces/IAttestationRegistry.sol";
import {IssuerRegistry} from "./IssuerRegistry.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import {Pausable} from "@openzeppelin/contracts/utils/Pausable.sol";
/// @title RecordRegistry — Slice 2 (Title registration)  [STUDENT TEMPLATE]
contract RecordRegistry is IAttestationRegistry, ReentrancyGuard, Pausable {
    IssuerRegistry public immutable issuers; address public controller;
    mapping(bytes32 => Attestation) internal records;
    error NotNotary(); error NotRegistrar(); error NotController(); error AlreadyExists(); error Missing(); error ControllerSet();
    modifier onlyNotary() { if (!issuers.isNotary(msg.sender)) revert NotNotary(); _; }
    modifier onlyRegistrar() { if (msg.sender != issuers.registrar()) revert NotRegistrar(); _; }
    modifier onlyController() { if (msg.sender != controller) revert NotController(); _; }
    constructor(address issuerRegistry) { issuers = IssuerRegistry(issuerRegistry); }
    function setController(address controller_) external onlyRegistrar { if (controller!=address(0)) revert ControllerSet(); controller=controller_; }
    function pause() external onlyRegistrar { _pause(); }
    function unpause() external onlyRegistrar { _unpause(); }
    function registerTitle(bytes32 id, bytes32 dataHash, string calldata cid, address owner_, string calldata metadataURI) external onlyNotary whenNotPaused nonReentrant {
        // TODO(member2): AlreadyExists check; store Attestation (Active); emit TitleRegistered.
        revert("TODO(member2): implement registerTitle");
    }
    function controllerTransfer(bytes32 id, address newOwner) external onlyController { Attestation storage a=records[id]; if (a.status==Status.None) revert Missing(); address f=a.owner; a.owner=newOwner; emit OwnerTransferred(id,f,newOwner); }
    function controllerRevoke(bytes32 id, address by) external onlyController { Attestation storage a=records[id]; if (a.status==Status.None) revert Missing(); a.status=Status.Revoked; emit RecordRevoked(id,by); }
    function controllerUpdate(bytes32 id, bytes32 newHash, string calldata newCid) external onlyController { Attestation storage a=records[id]; if (a.status==Status.None) revert Missing(); a.dataHash=newHash; a.cid=newCid; a.status=Status.Superseded; emit RecordUpdated(id,newHash,newCid); }
    function getRecord(bytes32 id) external view returns (Attestation memory) { return records[id]; }
    function exists(bytes32 id) external view returns (bool) { return records[id].status != Status.None; }
}
