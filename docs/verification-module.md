# Slice 3 — Verification (`Verification.sol`)

> Owner: member3 · Branch: `feature/verification-module` · Scenario: Tamper-evident land title registry: deeds are anchored on-chain, ownership transfers transparently on sale, and titles can be revoked on dispute.

## What it does
The zero-gas read path a Bank/Buyer/Title Insurer uses to confirm a TitleDeed is authentic, active, and who owns it.

## Functions
- `verifyTitle(id, candidateHash)` → `(valid, status, owner, issuer)`
- `verifyTitleHash` · `statusOf` · `ownerOf`

## Demo script
1. Issue a TitleDeed (Slice 2).
2. Re-hash the same artifact in the Verification page → ✅ VALID.
3. Revoke it (Slice 4) → re-verify → status `Revoked`, valid=false.

## Tests (`test/Verification.t.sol`)
- hash match · wrong hash fails · verifyTitle active.

## TODO checklist
- [ ] `TODO(slice-3)` assert valid=false after revoke
- [ ] in-browser IPFS fetch + re-hash
