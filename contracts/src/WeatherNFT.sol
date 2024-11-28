// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract WeatherNFT is ERC721, Ownable {
    uint256 public tokenCounter;

    struct WeatherData {
        int256 temperature;
        uint256 humidity;
        uint256 windSpeed;
        string weatherImage;
        uint256 timestamp;
    }

    mapping(uint256 => WeatherData) public weatherData;

    event Minted(uint256 tokenId, address owner);
    event MetadataUpdated(uint256 tokenId, WeatherData data);

    constructor() ERC721("WeatherNFT", "WNFT") Ownable(msg.sender) {
        tokenCounter = 0;
    }

    // Mint a new NFT
    function mintWeatherNFT() external returns (uint256) {
        uint256 newTokenId = tokenCounter;
        _safeMint(msg.sender, newTokenId);

        weatherData[newTokenId] = WeatherData({
            temperature: 0,
            humidity: 0,
            windSpeed: 0,
            weatherImage: "",
            timestamp: block.timestamp
        });

        tokenCounter += 1;

        emit Minted(newTokenId, msg.sender);
        return newTokenId;
    }

    // Update metadata for a specific tokenId
    function updateWeatherMetadata(
        uint256 tokenId,
        int256 temperature,
        uint256 humidity,
        uint256 windSpeed,
        string memory weatherImage
    ) external onlyOwner {
        require(_exists(tokenId), "Token does not exist");

        weatherData[tokenId] = WeatherData({
            temperature: temperature,
            humidity: humidity,
            windSpeed: windSpeed,
            weatherImage: weatherImage,
            timestamp: block.timestamp
        });

        emit MetadataUpdated(tokenId, weatherData[tokenId]);
    }

    // Check if a token exists
    function _exists(uint256 tokenId) internal view returns (bool) {
        return _ownerOf(tokenId) != address(0);
    }

    // Get weather data for a specific tokenId
    function getWeatherData(
        uint256 tokenId
    ) external view returns (WeatherData memory) {
        require(_exists(tokenId), "Token does not exist");
        return weatherData[tokenId];
    }
}
