const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  console.log("Deploying with address:", deployer.address);

  const K42Token = await hre.ethers.getContractFactory("K42Token");
  const k42 = await K42Token.deploy(deployer.address);

  await k42.waitForDeployment();

  console.log("✅ K42Token deployed to:", await k42.getAddress());
}

main().catch((error) => {
  console.error("❌ Deployment failed:", error);
  process.exitCode = 1;
});

