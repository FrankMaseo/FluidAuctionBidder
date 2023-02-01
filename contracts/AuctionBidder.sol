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

	IAuctionHouse.Auction public auction;

	constructor() {
		owner = msg.sender;
		auctionHouse = IAuctionHouse(0xc290450311686f9b4d87b579da0b8b83c809517c)
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

	

	//returns the price in ETH of a FLUID token
	function getFluidPrice() public returns (uint256 price){
		return 2 finney; //0.002 ETH
	}

	function getFluidClaim(
		uint256 FLUIDnftId
	) public returns (
		uint256 claim
	){
		return 70000000000000000000;
	}

	function checkUpkeep() public{
		//checkUpkeep returns true if
		// 1. auction is expired and needs to be settled
		// 2. Or new auction has been created and current bid price is lower than reserve price
		
	}

	function performUpkeep() public {
		IAuctionHouse.Auction memory _auction = auctionHouse.auction;
		if(
			_auction.startTime != 0
			&& !_auction.settled
			&& block.timestamp >= _auction.endTime
		){
			settleCurrent();
		}

		bidFloor();
	}

	function bidFloor() public{
		//compute bid floor price
		uint256 fluidClaim = getFluidClaim(_auction.FLUIDnftId);
		uint256 currentFluidPrice = getFluidPrice();

		uint256 bidValue = currentPrice * fluidClaim;

		//place bid
		auctionHouse.createBid.value(bidValue)(payId);
	}

		

		auctionHouse.
	function settleCurrent() private {
		auctionHouse.settleCurrentAndCreateNewAuction();
	}
	//as a reminder
	function getCurrentAuction() public{
		return auctionHouse.auction;
	}


	receive() external payable {
        topUp();
    }

}