// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

/** Imports */
import {Script, console} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    function run() external returns (MoodNft) {
        string memory happySvg = vm.readFile("./img/happy.svg");
        string memory sadSvg = vm.readFile("./img/sad.svg");

        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(
            svgToImageUri(happySvg),
            svgToImageUri(sadSvg)
        );
        vm.stopBroadcast();
        return moodNft;
    }

    function svgToImageUri(
        string memory svg
    ) public pure returns (string memory) {
        string memory baseURI = "data:image/svg+xml;base64,";

        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );

        return string(abi.encodePacked(baseURI, svgBase64Encoded));
        // return string.concat(baseURI, svgBase64Encoded);
    }
}
