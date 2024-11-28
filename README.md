# WeatherNFT

A **dynamic NFT project** for tracking and displaying weather conditions using smart contracts. The project leverages Foundry for smart contract development and deployment, along with a frontend for user interaction.

---

## Features

- **Mint Weather NFTs**: Each NFT represents dynamic weather data.
- **Update Weather Data**: Temperature, humidity, wind speed, and an image representing current weather conditions.
- **Query Weather Information**: Retrieve weather data for a specific token ID.
- **Technologies Used**:
  - **Foundry**: Development and testing of smart contracts.
  - **Solidity**: Smart contract programming language.
  - **Next.js**: Frontend framework for the user interface.

---

## Prerequisites

1. **Node.js**: Install the latest LTS version from [Node.js official site](https://nodejs.org/).
2. **Foundry**: Install Foundry by running:
   ```bash
   curl -L https://foundry.paradigm.xyz | bash
   foundryup
   ```
---

## Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/0xNaxzerrr/WeatherNFT.git
   cd WeatherNFT
   ```

2. **Install Dependencies**:
   ```bash
   forge install
   ```

3. **Set up Environment Variables**:
   Create a `.env` file in the root directory and add:
   ```bash
   PRIVATE_KEY=<your-private-key>
   RPC_URL=https://api.avax-test.network/ext/bc/C/rpc
   ```

---

## Smart Contract Development

### Compile the Contracts

To compile the smart contracts, run:
```bash
forge build
```

### Run Tests

Run the tests to ensure everything is functioning correctly:
```bash
forge test
```

### Deploy to Testnet

1. Deploy the contract to the Avalanche Fuji Testnet:
   ```bash
   forge script script/DeployWeatherNFT.s.sol:DeployWeatherNFT --rpc-url $RPC_URL --private-key $PRIVATE_KEY --broadcast
   ```

2. Copy the deployed contract address from the output logs.

---

## Usage

1. **Mint an NFT**:
   - Use the following command to mint an NFT :
     ```bash
     cast send <contract-address> "mintWeatherNFT()" --rpc-url $RPC_URL --private-key $PRIVATE_KEY
     ```
   - replace `<contract-address>` with the deployed contract address.

2. **Update Weather Data**:
   - Update the weather data for a specific NFT using the following command :
     ```bash
     cast send <contract-address> "updateWeatherMetadata(uint256,int256,uint256,uint256,string)" <tokenId> <temperature> <humidity> <windSpeed> <weatherImage> --rpc-url $RPC_URL --private-key $PRIVATE_KEY
     ```
   - Exemple :
     ```bash
     cast send <contract-address> "updateWeatherMetadata(uint256,int256,uint256,uint256,string)" 1 25 60 15 "sunny.png" --rpc-url $RPC_URL --private-key $PRIVATE_KEY
     ```
   - Replace <tokenId> with the ID of the NFT you want to update.

3. **Retrieve Weather Data**:
   - Retrieve the weather data for a specific NFT using the following command :
     ```bash
     cast call <contract-address> "getWeatherData(uint256)((int256,uint256,uint256,string,uint256))" <tokenId> --rpc-url $RPC_URL
     ```
   - Exemple :
     ```bash
     cast call <contract-address> "getWeatherData(uint256)((int256,uint256,uint256,string,uint256))" 1 --rpc-url $RPC_URL
     ```
   - This command will return the temperature, humidity, wind speed, weather image, and the timestamp.

---

## Contributing

Contributions are welcome! Please follow the steps below to contribute:

1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Commit your changes and submit a pull request.

---


## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
