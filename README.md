
# Foundry Fund Me Project

This project is a simulation of a decentralized funding smart contract using [Foundry](https://book.getfoundry.sh/), a blazing fast and modular Ethereum development toolkit written in Rust.

It is designed to **test, simulate, and understand smart contract development, testing, deployment, and price feed interactions** (like with Chainlink oracles) in a local development environment.

---

## 🛠️ Foundry Toolkit Overview

Foundry includes the following tools:

- **Forge** – A fast, flexible Ethereum testing framework  
- **Cast** – A CLI for interacting with contracts and sending transactions  
- **Anvil** – A local Ethereum node for testing (Ganache alternative)  
- **Chisel** – Solidity REPL (interactive prompt for Solidity code)

---

## 📁 What's Inside This Project?

- ✅ Core smart contracts (`src/`)
- ✅ Scripts for deployment and automation (`script/`)
- ✅ Unit and integration tests using Forge (`test/`)
- ✅ Mock contracts for simulating real-world data feeds (Chainlink)
- ✅ Local blockchain setup using Anvil
- ✅ Testing gas consumption and behavior
- ✅ Structured and modular layout for clarity

---

## 📦 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/hitesha-sahani/foundry-fund-me-hz
cd foundry-fund-me-hz
```

### 2. Install Foundry

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

### 3. Install Dependencies and Build

```bash
forge install
forge build
```

### 4. Run Tests

```bash
forge test
```

### 5. Run a Local Node

```bash
anvil
```

### 6. Deploy Script (Optional)

```bash
forge script script/FundMe.s.sol:FundMeScript --rpc-url <YOUR_RPC_URL> --private-key <YOUR_PRIVATE_KEY>
```

> Replace `<YOUR_RPC_URL>` and `<YOUR_PRIVATE_KEY>` with your environment variables or real values.

---

## 🔌 Frontend Integration

The frontend integration is available in a separate repository:

👉 [html-fund-me-hz](https://github.com/hitesha-sahani/html-fund-me-hz)

This repository provides:
- Basic wallet connection (e.g., MetaMask)
- HTML/CSS/JS interface for user interactions
- Connects directly to the deployed smart contract

---

## 🧪 Highlights

- ✅ Complete test suite with mocks for Chainlink price feeds
- ✅ Simulated deployments and interaction with smart contracts
- ✅ Tracks gas usage and compares different patterns
- ✅ Fully offline development and testing environment
- ✅ Works across testnets (Goerli, Sepolia) or local node, just add your desired chainid in HelperConfig

---

## 🧠 Summary

This project helps you learn:
- Writing secure smart contracts
- Using mocks to simulate live data (like ETH/USD price)
- Deploying and scripting smart contract behavior
- Testing edge cases and failures with Forge
- Interacting with blockchain locally via Anvil
- Building frontend integrations for smart contracts

Even without deploying to a real network, you can test everything using **mock price feeds** and **Anvil simulation**.

---

## 📚 Resources

- [Foundry Book](https://book.getfoundry.sh/)
- [Solidity Docs](https://docs.soliditylang.org/)
- [Chainlink Docs](https://docs.chain.link/)

---

## 🤝 Contributions

Feel free to fork, improve, or raise issues. This project is intended for learning, experimenting, and showcasing Solidity & Foundry development.
