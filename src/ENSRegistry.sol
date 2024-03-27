// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ENSRegistry {
    struct User {
        string ensName;
        string image;
        address userAddress;
    }

    mapping(string => User) public ensUsers;

    event UserRegistered(string ensName, string image, address userAddress);

    function registerUser(string memory ensName, string memory image) public {
        require(bytes(ensName).length > 0, "ENS name cannot be empty");
        require(bytes(image).length > 0, "Image cannot be empty");
        require(
            ensUsers[ensName].userAddress == address(0),
            "ENS name already taken"
        );

        User memory newUser = User({
            ensName: ensName,
            image: image,
            userAddress: msg.sender
        });

        ensUsers[ensName] = newUser;

        emit UserRegistered(ensName, image, msg.sender);
    }

    function getUserInfo(
        string memory ensName
    ) public view returns (string memory, string memory, address) {
        require(ensUsers[ensName].userAddress != address(0), "User not found");

        return (
            ensUsers[ensName].ensName,
            ensUsers[ensName].image,
            ensUsers[ensName].userAddress
        );
    }
}
