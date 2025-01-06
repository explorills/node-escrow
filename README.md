# explorills_NodeEscrow Contract

Non-custodial ERC721 escrow contract for explorills_Nodes tokens storage, with auto-release functionality

## General Functionality

1. Stores ERC721 tokens securely until pulling conditions are met
2. Provides read-only access to escrow data
3. Enables automatic pulling window after 10,800 regular mints
4. Exclusive interaction with main explorills_Nodes contract
5. Non-custodial design for enhanced security

## View Functions

* `a1AddressEscrowHoldings`: Query detailed escrow holdings for a specific address
* `a2EscrowStatus`: Check current escrow release status
* `a3CurrentChainEscrowTotalHoldings`: Get total tokens held in escrow
* `a4RemainingNodesToReleaseEscrow`: Calculate remaining nodes before release

## Escrow Release Conditions

* Release triggers after first 10,800 Nodes are minted (by regular mint)
* Pulling window opens automatically upon reaching threshold
* Status transitions:
  - "not released yet": Before reaching threshold
  - "pulling window is open": After threshold, tokens available
  - "all nodes are already pulled": No tokens remaining in escrow
 
## Build and Deployment Settings
* Contract Name: explorills_NodeEscrow
* Compiler Version: v0.8.24
* EVM Version: London
* Optimization: Enabled (200 runs)
* Networks: [Ethereum](https://ethereum.org/en/); [Flare](https://flare.network/)

## Contract Architecture
```
explorills_NodeEscrow
├── View Functions
│   ├── Address Holdings
│   │   └── a1AddressEscrowHoldings
│   ├── Escrow Status
│   │   └── a2EscrowStatus
│   ├── Total Holdings
│   │   └── a3CurrentChainEscrowTotalHoldings
│   └── Release Information
│       └── a4RemainingNodesToReleaseEscrow
└── Storage
    ├── Constants
    │   ├── TIER3_END
    │   └── MAX_SUPPLY
    └── Contract References
        └── NODE_MAIN_CONTRACT
```
## License

BSD-3-Clause License

## Contact

- main: [explorills.com](https://explorills.com)
- mint: [mint.explorills.com](https://mint.explorills.com)
- contact: info@explorills.com
- security contact: info@explorills.ai

## Contract Address
- 0x9eAEc5DB08E0D243d07A82b8DD54Cc70E745f8b4
### find at
- [Etherscan.io](https://etherscan.io/address/0x9eAEc5DB08E0D243d07A82b8DD54Cc70E745f8b4#code)
- [Flare-explorer](https://flare-explorer.flare.network/address/0x9eAEc5DB08E0D243d07A82b8DD54Cc70E745f8b4?tab=contract)

## Main Contract Integration

- 0x468F1F91fc674e0161533363B13c2ccBE3769981
* Github: [explorills/nodes](https://github.com/explorills/nodes) 

---
explorills community 2025
