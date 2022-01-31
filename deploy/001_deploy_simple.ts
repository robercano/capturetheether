import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";

/**
 * Deploy SimpleContract
 */

const deployStep: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
    const { deployer } = await hre.getNamedAccounts();
    const { deploy } = hre.deployments;

    console.log("[Deploy Simple Contract]");
    await deploy("SimpleContract", {
        from: deployer,
        log: true,
    });
};

deployStep.tags = ["SimpleContract", "AntBond", "AntShare"];

export default deployStep;
