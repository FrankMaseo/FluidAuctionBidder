// SPDX-License-Identifier: GNU General Public License v3.0
pragma solidity ^0.8.12;

//import fluid auction interface
import "fluiddao/contracts/interfaces/IAuctionHouse.sol";
import "fluiddao/contracts/AuctionHouse.sol";

//ERC721 receiver
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

contract AuctionBidder {
	
	address immutable owner;
	AuctionHouse immutable auctionHouse;

	constructor(address auctionHouseAddress) {
		owner = msg.sender;
		auctionHouse = AuctionHouse(auctionHouseAddress);
	}

	function onERC721Received(address, address, uint256, bytes calldata) external pure returns (bytes4) {
        return IERC721Receiver.onERC721Received.selector;
    }
	/*
	function topUp() public payable{
		
	}
	*/
	
	function withdraw(uint256 _amount, address payable recipient) public {
		require(msg.sender == owner, "Not the owner");
		require(address(this).balance >= _amount, "Not enough funds");
		recipient.transfer(_amount);
	}

	function withdrawAll(address payable recipient) public {
		withdraw(address(this).balance, recipient);
	}

	

	//returns the price in ETH of a FLUID token
	function getFluidPrice() public view returns (uint256 price){
		price = 2 * 10 ** 15 ; //hardcoded to 0.002 ETH
	}

	function getFluidClaim() public view returns (
		uint256 claim
	){
		claim = auctionHouse.rewardAmount(); //returns the current reward amount with a 18 decimals
	}

	function checkUpkeep() public view {
		//checkUpkeep returns true if
		// 1. auction is expired and needs to be settled
		// 2. Or new auction has been created and current bid price is lower than reserve price
		
	}

	function performUpkeep() public {
		(
			uint256 _FLUIDnftId,
			uint256 _amount,
			uint256 _startTime,
			uint256 _endTime,
			address payable _bidder,
			bool _settled
		) = auctionHouse.auction();
		
		if(
			_startTime != 0
			&& !_settled
			&& block.timestamp >= _endTime
		){
			settleCurrent();
			//update auction parameters after settling and creating new
			(
				_FLUIDnftId,
				_amount,
				_startTime,
				_endTime,
				_bidder,
				_settled
			) = auctionHouse.auction();
		}

		bidFloor(_FLUIDnftId, _amount);
	}

	function bidFloor(uint256 FLUIDnftId, uint256 currentBid) private{
		//compute bid floor price
		uint256 fluidClaim = getFluidClaim();
		uint256 currentFluidPrice = getFluidPrice();
		uint256 bidValue = currentFluidPrice * fluidClaim;
		//place bid

		//need to check if (1) possible to bid lower than current highest and (2) possible to remove bid
		//To prevent the program from not bidding because current bid is higher -> current bid gets removed -> malicious user profits
		require(currentBid < bidValue, "revert: bid already higher than reserve price");
		auctionHouse.createBid{value: bidValue}(FLUIDnftId);
	}

	function settleCurrent() private {
		auctionHouse.settleCurrentAndCreateNewAuction();
	}
	
	
	/*as a reminder
	function getCurrentAuction() public{
		return auctionHouse.auction();
	}*/


	receive() external payable {
    }

}