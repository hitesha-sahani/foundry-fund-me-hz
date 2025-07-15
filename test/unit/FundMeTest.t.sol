// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;
    address USER = makeAddr("user");
    uint256 constant STARTING_BALANCE = 10 ether;

    //setUp is a special function in Foundry that runs before each test function.
    // It is used to set up the initial state for the tests.
    function setUp() public {
        //fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE); // This will set the balance of the USER address to 10 ether.
        // This will set the owner to the address that deploys the contract.
        // In this case, it will be the address of the test contract.
        // The address of the test contract is the address that runs the tests.
    }

    function testMinimumUsd() public view {
        uint256 minimumUsd = fundMe.MINIMUM_USD();
        assertEq(minimumUsd, 5 * 10 ** 18);
        //console.log will print the value to the console during test execution.
        console.log("Minimum USD is right");
    }

    //assertEq checks if the two values are equal, and if not, it will revert the test with a message.
    function testOwner() public view {
        address owner = fundMe.getOwner();
        assertEq(owner, msg.sender);
    }

    function testPriceFeedVersion() public view {
        uint256 version = fundMe.getVersion();
        // The version should be greater than 0, as the price feed is expected to be deployed and functional.
        assertGt(version, 0);
        console.log(version);
    }

    function testFundFailsWithoutEnoughEth() public {
        fundMe.fund{value: 1e18}(); // This should revert when value is less than minimum USD e.g.1e15}
    }

    function testFundUpdatesFundedDataStruture() public {
        vm.prank(USER); //vm.prank allows us to simulate a transaction from a different address.
        //next transaction will be sent from USER address
        uint256 value = 10 * 10 ** 18; // 10 ETH
        fundMe.fund{value: value}();
        uint256 amountFunded = fundMe.getAddressToAmountFunded(USER);
        assertEq(amountFunded, value);
    }

    function testAddsFunderToArray() public {
        vm.prank(USER);
        uint256 value = 0.1 * 10 ** 18; // 10 ETH
        fundMe.fund{value: value}();
        address funder = fundMe.getFunder(0); // Get the first funder
        assertEq(funder, USER);
    }

    modifier funded() {
        // This modifier will fund the contract before running the test
        vm.prank(USER);
        fundMe.fund{value: 1e18}(); // Fund the contract with 1 ETH
        _;
    }

    //modifier is a way to reuse code in multiple functions.

    function testOnlyOwnerCanWithdraw() public funded {
        vm.prank(USER); // Change the sender to USER
        vm.expectRevert("NotOwner()");
        fundMe.cheaperWithdraw();
    }

    function testWithdrawWithSingleFunder() public funded {
        //Arrange
        uint256 startingOwnerBalance = fundMe.getOwner().balance;
        uint256 startingFundMeBalance = address(fundMe).balance;

        //Act
        vm.prank(fundMe.getOwner()); // Change the sender to the owner
        fundMe.cheaperWithdraw(); // Withdraw the funds

        //Assert
        // Check the balances after withdrawal
        uint256 endingOwnerBalance = fundMe.getOwner().balance;
        uint256 endingFundMeBalance = address(fundMe).balance;

        assertEq(endingFundMeBalance, 0);
        assertEq(
            endingOwnerBalance,
            startingOwnerBalance + startingFundMeBalance
        );
    }

    function testWithdrawWithMultipleFundersCheaper() public funded {
        // Arrange
        uint160 numberOfFunders = 10;
        uint160 startingFunderIndex = 1;

        // Fund multiple users
        for (uint160 i = startingFunderIndex; i < numberOfFunders; i++) {
            hoax(address(i), 10e18); //hoax combines vm.prank and vm.deal
            fundMe.fund{value: 10e18}(); // Each funder sends 10 ETH
        }
        uint256 startingOwnerBalance = fundMe.getOwner().balance;
        uint256 startingFundMeBalance = address(fundMe).balance;
        // Act
        vm.startPrank(fundMe.getOwner());
        fundMe.cheaperWithdraw();
        vm.stopPrank();

        // Assert
        uint256 endingOwnerBalance = fundMe.getOwner().balance;
        uint256 endingFundMeBalance = address(fundMe).balance;

        assertEq(endingFundMeBalance, 0);
        assertEq(
            endingOwnerBalance,
            startingOwnerBalance + startingFundMeBalance
        );
    }
}
