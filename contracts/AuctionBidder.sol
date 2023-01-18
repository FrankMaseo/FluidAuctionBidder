// SPDX-License-Identifier: GNU General Public License v3.0
pragma solidity 0.8.6;

//import fluid auction interface
import "@FLUIDDAO/fluid-dao-nft/contracts/interfaces/IAuctionHouse.sol";

//ERC721 receiver
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

//Fluid price feed from sushi pool


contract AuctionBidder {
	
	address immutable owner;
	IAuctionHouse immutable auctionHouse;

	constructor() {
		owner = msg.sender;
	}

	function topUp() public payable{
		
	}

	function withdraw(uint256 _amount) public {
		require(msg.sender == owner, "Not the owner");
		require(address(this).balance >= _amount, "Not enough funds");
		owner.transfer(_amount);
	}

	function withdrawAll() public {
		withdraw(address(this).balance);
	}

	function bidFloor() public{
		//compute bid floor price
		uint256 currentPrice = getFluidPrice();
		uint256 fluidClaim = getFluidClaim();

		//place bid
	}

	//returns the price in ETH of a FLUID token
	function getFluidPrice() public returns (uint256 price){
		return 2 finney; //0.002 ETH
	}

	function getFluidClaim()
	receive() external payable {
        topUp();
    }

}