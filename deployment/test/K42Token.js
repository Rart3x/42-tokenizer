const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("K42Token Multisig Tests", function () {

    let K42, k42;
    let owner, owner2, owner3, user;

    before(async () => {
        // Retrieve test accounts
        [owner, owner2, owner3, user] = await ethers.getSigners();

        // Deploy the K42Token contract
        K42 = await ethers.getContractFactory("K42Token");
        k42 = await K42.deploy(owner.address);
        await k42.waitForDeployment();
    });

    it("1️⃣ - Constructor assigns the initial owner", async () => {
        expect(await k42.isOwner(owner.address)).to.equal(true);
    });

    it("2️⃣ - An owner can create a mint request", async () => {
        const tx = await k42.connect(owner).createMintRequest(
            user.address,
            ethers.parseEther("100")
        );
        await tx.wait();

        const req = await k42.mintRequests(0);
        expect(req.to).to.equal(user.address);
        expect(req.amount).to.equal(ethers.parseEther("100"));
        expect(req.executed).to.equal(false);
    });

    it("3️⃣ - A second owner can be added", async () => {
        const tx = await k42.connect(owner).addOwner(owner2.address);
        await tx.wait();
        expect(await k42.isOwner(owner2.address)).to.equal(true);
    });

    it("4️⃣ - A mint request can be confirmed and executed", async () => {
        // Set the number of required confirmations to 2
        await k42.connect(owner).setRequiredConfirmations(2);

        // Create a new mint request
        await k42.connect(owner).createMintRequest(
            user.address,
            ethers.parseEther("50")
        );

        // Second owner confirms the request
        await k42.connect(owner2).confirmMintRequest(1);

        // Check that the request is now executed
        const reqAfter = await k42.mintRequests(1);
        expect(reqAfter.executed).to.equal(true);

        // Check that the user received the tokens
        const balance = await k42.balanceOf(user.address);
        expect(balance).to.equal(ethers.parseEther("50"));
    });

    it("5️⃣ - An owner cannot confirm the same request twice", async () => {
        await expect(
            k42.connect(owner2).confirmMintRequest(1)
        ).to.be.revertedWith("Already executed");
    });

});