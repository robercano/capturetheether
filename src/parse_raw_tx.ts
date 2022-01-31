const ethers = require("ethers");

async function main() {
    const raw =
        "0xf87080843b9aca0083015f90946b477781b0e68031109f21887e6b5afeaaeb002b808c5468616e6b732c206d616e2129a0a5522718c0f95dde27f0827f55de836342ceda594d20458523dd71a539d52ad7a05710e64311d481764b5ae8ca691b05d14054782c7d489f3511a7abf2f5078962";

    const tx = ethers.utils.parseTransaction(raw);
    const txData = {
        gasPrice: tx.gasPrice,
        gasLimit: tx.gasLimit,
        value: tx.value,
        nonce: tx.nonce,
        data: tx.data,
        chainId: tx.chainId,
        to: tx.to, // you might need to include this if it's a regular tx and not simply a contract deployment
    };
    const expandedSig = {
        r: tx.r,
        s: tx.s,
        v: tx.v,
    };

    const rsTx = await ethers.utils.resolveProperties(txData);
    const raw2 = ethers.utils.serializeTransaction(rsTx);

    const signature = ethers.utils.joinSignature(expandedSig);
    const txHash = ethers.utils.keccak256(raw2);

    const publicKey = ethers.utils.recoverPublicKey(txHash, signature);
    const addressCompute = ethers.utils.computeAddress(publicKey);
    const addressRecover = ethers.utils.recoverAddress(txHash, signature);

    console.log("addressCompute:", addressCompute);
    console.log("addressRecover:", addressRecover);
    console.log("publicKey:", publicKey);
    console.log(typeof publicKey);

    console.log(`Manual Address Compute: ${ethers.utils.keccak256("0x" + publicKey.slice(4))}`);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
