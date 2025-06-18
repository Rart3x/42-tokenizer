require("dotenv").config();
const { ethers } = require("hardhat");

async function main() {
  const K42Token = await ethers.deployContract("K42Token");
  await K42Token.waitForDeployment();

  console.log(`✅ K42Token deployed at: ${K42Token.target}`);
}

main().catch((error) => {
  console.error("❌ Deployment failed:", error);
  process.exit(1);
});

