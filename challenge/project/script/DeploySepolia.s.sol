// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

import "src/Split.sol";
import "src/Challenge.sol";

contract DeploySepolia is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);
        
        console.log("Deploying from address:", deployer);
        console.log("Account balance:", deployer.balance);
        
        vm.startBroadcast(deployerPrivateKey);

        console.log("Deploying Split contract...");
        Split split = new Split();
        console.log("Split deployed at:", address(split));

        console.log("Creating split with 0.01 ETH...");
        address[] memory addrs = new address[](2);
        addrs[0] = address(0x000000000000000000000000000000000000dEaD);
        addrs[1] = address(0x000000000000000000000000000000000000bEEF);
        uint32[] memory percents = new uint32[](2);
        percents[0] = 5e5; // 50%
        percents[1] = 5e5; // 50%

        uint256 id = split.createSplit(addrs, percents, 0);
        console.log("Split created with ID:", id);

        Split.SplitData memory splitData = split.splitsById(id);
        console.log("SplitWallet deployed at:", address(splitData.wallet));
        
        // Deposit 0.01 ETH into the split wallet (for testing)
        console.log("Depositing 0.01 ETH into split wallet...");
        splitData.wallet.deposit{value: 0.01 ether}();
        console.log("0.01 ETH deposited successfully");

        console.log("Deploying Challenge contract...");
        Challenge challenge = new Challenge(split);
        console.log("Challenge deployed at:", address(challenge));

        vm.stopBroadcast();
        
        console.log("\n=== DEPLOYMENT SUMMARY ===");
        console.log("Split contract:", address(split));
        console.log("Challenge contract:", address(challenge));
        console.log("SplitWallet:", address(splitData.wallet));
        console.log("Split ID:", id);
        console.log("0.01 ETH locked in split wallet");
        console.log("Deployer:", deployer);
        console.log("===========================");
    }
}
