# Slice 1 — Issuer Registration (`IssuerRegistry.sol`)

> Owner: member1 · Branch: `feature/issuer-module` · Scenario: Tamper-evident land title registry: deeds are anchored on-chain, ownership transfers transparently on sale, and titles can be revoked on dispute.

## What it does
The single source of truth for **who may issue a TitleDeed** and who the registrar is.

## Functions
- `registerNotary(address)` — registrar grants the issuer role to a Land Registry Office.
- `deregisterNotary(address)` — registrar revokes it.
- `transferRegistrar(address)` — hand the registrar key to a multisig.
- `isNotary(address)` / `registrar()` — reads used by the other three slices.

## Tests (`test/IssuerRegistry.t.sol`)
- registrar is the deployer · register+revoke · non-registrar reverts · zero-address reverts.

## TODO checklist
- [ ] `TODO(slice-1)` two-step registrar handover
- [ ] event-driven issuer list in the frontend
- [ ] Extension: swap to OpenZeppelin `AccessControl`, note gas delta

## Demo evidence
Screenshot: registering a Land Registry Office and the `NotaryRegistered` event in the trace.
