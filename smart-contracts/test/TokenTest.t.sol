// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "forge-std/Test.sol";
import "../src/SecureToken.sol";
import "../src/VulnerableToken.sol";

contract TokenTest is Test {
    SecureToken secure;
    VulnerableToken vuln;

    function setUp() public {
        secure = new SecureToken();
        vuln = new VulnerableToken();
    }

    // Test 1 : mint sécurisé fonctionne pour le owner
    function testSecureMintByOwner() public {
        secure.mint(address(this), 1000);
        assertEq(secure.balanceOf(address(this)), 1_000_000 * 10**18 + 1000);
    }

    // Test 2 : mint bloqué pour un non-owner
    function testSecureMintRevertIfNotOwner() public {
        vm.prank(address(0xBEEF));
        vm.expectRevert();
        secure.mint(address(0xBEEF), 1000);
    }

    // Test 3 : dépôt sur le contrat vulnérable
    function testVulnDeposit() public {
        vuln.deposit{value: 1 ether}();
        assertEq(vuln.balances(address(this)), 1 ether);
    }
}
