// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Import des bibliothèques OpenZeppelin
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract SecureToken is ERC20, Ownable, ReentrancyGuard {

    // Constructeur
    constructor() ERC20("SecureToken", "STK") Ownable(msg.sender) {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    // Fonction de mint sécurisée
    function mint(address to, uint256 amount) public onlyOwner nonReentrant {
        _mint(to, amount);
    }

    // Fonction de burn sécurisée
    function burn(uint256 amount) public nonReentrant {
        _burn(msg.sender, amount);
    }
}
