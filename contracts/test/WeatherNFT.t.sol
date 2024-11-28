// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/WeatherNFT.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

// Mock receiver contract for testing ERC721 compatibility
contract MockReceiver is IERC721Receiver {
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external pure override returns (bytes4) {
        return this.onERC721Received.selector;
    }
}

contract WeatherNFTTest is Test {
    WeatherNFT nft;
    MockReceiver receiver;

    function setUp() public {
        nft = new WeatherNFT();
        receiver = new MockReceiver();
    }

    function testMintWeatherNFT() public {
        address receiverAddress = address(receiver);

        // Simulate minting a token
        vm.prank(receiverAddress); // Simulates the receiver minting the token
        uint256 tokenId = nft.mintWeatherNFT();

        assertEq(tokenId, 0);
        assertEq(nft.ownerOf(0), receiverAddress);
    }

    function testUpdateWeatherMetadata() public {
        address receiverAddress = address(receiver);

        // Mint a token to the receiver address
        vm.prank(receiverAddress);
        uint256 tokenId = nft.mintWeatherNFT();

        // Update metadata for the token
        nft.updateWeatherMetadata(tokenId, 25, 80, 10, "sunny.png");

        // Verify the metadata
        (int256 temp, uint256 hum, uint256 wind, , uint256 timestamp) = nft
            .weatherData(tokenId);
        assertEq(temp, 25);
        assertEq(hum, 80);
        assertEq(wind, 10);
        assertTrue(timestamp > 0);
    }
}
