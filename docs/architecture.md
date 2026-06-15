# Architecture — Enigma-RealEstate-Title-Registry

> Scenario: Tamper-evident land title registry: deeds are anchored on-chain, ownership transfers transparently on sale, and titles can be revoked on dispute.

## Roles
- **Issuer** — Land Registry Office (holds the issuer role; creates/updates/revokes TitleDeed records)
- **Owner** — Property Owner (controls transfer of their own record)
- **Verifier** — Bank/Buyer/Title Insurer (read-only authenticity check)
- **Admin** — deploys, manages issuer roles, links the controller

## System diagram
```
            ┌──────────────────┐
registrar ─────▶│  IssuerRegistry  │◀──── isNotary()/registrar() reads
            └──────────────────┘
                     ▲ role check
  issuer ──create──▶ │
            ┌──────────────────┐  controller-only   ┌──────────────┐
            │  RecordRegistry  │◀──────────────────│  AuditTrail  │◀── owner/issuer
            └──────────────────┘  transfer/revoke   └──────────────┘
                     ▲ view
            ┌──────────────────┐
verifier ─▶│   Verification   │
            └──────────────────┘
```

## Workflow (per action)
1. **Register issuer** — registrar → `IssuerRegistry.registerNotary(Land Registry Office)`
2. **Create TitleDeed** — issuer → `RecordRegistry.registerTitle(id, hash, cid, owner, metaURI)` → emits `TitleRegistered`
3. **Verify** — verifier → `Verification.verifyTitle(id, candidateHash)` → `(valid, status, owner, issuer)`
4. **Transfer** — owner → `AuditTrail.transferTitle(id, newOwner)` → emits `TitleTransferred`
5. **Revoke / update** — issuer/registrar → `AuditTrail.revoke|updateEncumbrance(...)`

## On-chain vs off-chain
| On-chain (lean, permanent) | Off-chain (large, private) |
|----------------------------|----------------------------|
| `keccak256(artifact)` hash | the TitleDeed file itself (IPFS) |
| IPFS CID + metadataURI     | the human-readable record.json |
| issuer/owner addresses     | any PII (never on-chain) |
| `issuedAt`, `status`, events | |

## Why blockchain here (and where a DB is fine)
- **Blockchain wins:** tamper-evidence, no single trusted server, public verifiability, issuer can revoke.
- **DB still better for:** search/discovery by name, private lookups, high-frequency mutable data.
> Fill this in with your scenario's concrete argument — it's worth 10 pts (Problem definition).
