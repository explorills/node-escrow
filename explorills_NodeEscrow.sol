    // SPDX-License-Identifier: BSD-3-Clause
    pragma solidity ^0.8.0;

    /**
     * ORIGINAL AUTHOR INFORMATION:
     * 
     * @author explorills community 2025
     * @custom:web https://explorills.com
     * @custom:contact info@explorills.com
     * @custom:security-contact info@explorills.ai
     * @custom:repository https://github.com/explorills/node-escrow
     * @title explorills_NodeEscrow
     * @dev Non-custodial ERC721 escrow contract for explorills_Nodes tokens storage that opens pulling window through main contract after initial 10,800 mints, 
     * with read-only functionality and exclusive main contract interaction for token pulling.
     * 
     * Contract redistribution or modification:
     * 
     * 1. Any names or terms related to "explorills," "EXPL_NODE," or their variations, cannot be used in any modified version's contract names, variables, or promotional materials without permission.
     * 2. The original author information (see above) must remain intact in all versions.
     * 3. In case of redistribution/modification, new author details must be added in the section below:
     * 
     * REDISTRIBUTED/MODIFIED BY:
     * 
     * /// @custom:redistributed-by <name or entity>
     * /// @custom:website <website of the redistributor>
     * /// @custom:contact <contact email or info of the redistributor>
     * 
     * Redistribution and use in source and binary forms, with or without modification, are permitted under the 3-Clause BSD License. 
     * This license allows for broad usage and modification, provided the original copyright notice and disclaimer are retained.
     * The software is provided "as-is," without any warranties, and the original authors are not liable for any issues arising from its use.
     */

    /// @author explorills community 2025
    /// @custom:web https://explorills.com
    /// @custom:contact info@explorills.com
    /// @custom:security-contact info@explorills.ai
    /// @custom:repository https://github.com/explorills/node-escrow
    contract explorills_NodeEscrow {
        // Contract identity
        bool public IS_NONCUSTODIAL_ESCROW = true;
        string public constant ESCROW_TYPE = "ERC721 Non-Custodial Escrow";
        address public NODE_MAIN_CONTRACT = address(0x468F1F91fc674e0161533363B13c2ccBE3769981);
        
        uint256 private constant TIER3_END = 10800;
        uint256 private constant MAX_SUPPLY = 12000;

        // receiver 
        function onERC721Received(
            address /* operator */,
            address /* from */,
            uint256 /* tokenId */,
            bytes calldata /* data */
        ) external view returns (bytes4) {
            require(msg.sender == NODE_MAIN_CONTRACT, "Only explorills_Nodes MAIN CONTRACT can interact with explorills_NodeEscrow");
            return 0x150b7a02;
        }

        // view only functions
        function a1AddressEscrowHoldings(address addr) external view returns (
            address queryAddress,
            string memory queryAddressStatus,
            address relatedAddress1,
            string memory relatedAddress1Status,
            address relatedAddress2,
            string memory relatedAddress2Status,
            uint256 totalQty,
            uint256[] memory nodeIds,
            bool isPulled
        ) {
            (bool success, bytes memory data) = NODE_MAIN_CONTRACT.staticcall(
                abi.encodeWithSignature("a6AddressEscrowHoldings(address)", addr)
            );
            require(success, "Call failed");
            
            return abi.decode(data, (address, string, address, string, address, string, uint256, uint256[], bool));
        }

        function a3CurrentChainEscrowTotalHoldings() external view returns (uint256) {
            (bool success, bytes memory data) = NODE_MAIN_CONTRACT.staticcall(
                abi.encodeWithSignature("balanceOf(address)", address(this))
            );
            require(success, "Call failed");
            return abi.decode(data, (uint256));
        }

        function a4RemainingNodesToReleaseEscrow() external view returns (uint256) {
            (bool success1, bytes memory data1) = NODE_MAIN_CONTRACT.staticcall(
                abi.encodeWithSignature("isWhitelistNetwork()")
            );
            require(success1, "Call failed");
            bool isWhitelistNetwork = abi.decode(data1, (bool));

            (bool success2, bytes memory data2) = NODE_MAIN_CONTRACT.staticcall(
                abi.encodeWithSignature("a3GetTotalCurrentSupply()")
            );
            require(success2, "Call failed");
            uint256 totalSupply = abi.decode(data2, (uint256));

            if (isWhitelistNetwork) {
                (bool success3, bytes memory data3) = NODE_MAIN_CONTRACT.staticcall(
                    abi.encodeWithSignature("whitelistMintedCount()")
                );
                require(success3, "Call failed");
                uint256 whitelistMinted = abi.decode(data3, (uint256));
                
                return (totalSupply - whitelistMinted >= TIER3_END) ? 0 : TIER3_END - (totalSupply - whitelistMinted);
            } else {
                return (totalSupply >= MAX_SUPPLY) ? 0 : MAX_SUPPLY - totalSupply;
            }
        }

        function a2EscrowStatus() public view returns (string memory) {
            uint256 remainingNodes = this.a4RemainingNodesToReleaseEscrow();

            (bool success2, bytes memory data2) = NODE_MAIN_CONTRACT.staticcall(
                abi.encodeWithSignature("balanceOf(address)", address(this))
            );
            require(success2, "Call failed");
            uint256 currentBalance = abi.decode(data2, (uint256));

            if (remainingNodes > 0) {
                return "not released yet";
            } else if (currentBalance > 0) {
                return "pulling window is open";
            } else {
                return "all nodes are already pulled";
            }
        }

    }
