const AuctionBidder = artifacts.require("AuctionBidder");
const myAddress = "0x78fe389778e5e8be04c4010Ac407b2373B987b62"
const goerliAHAddress = "0xc290450311686f9B4d87b579da0b8b83C809517c"
module.exports = function(deployer) {
    
    //DevNet deployer
    /*deployer.deploy(
      UniV3TradingPair,
      USDCWETHPool,
      nftManager,
      ganacheOwner, 
      ganacheOwner
    );*/
  
    //Goerli deployer
    deployer.deploy(
      AuctionBidder,
      goerliAHAddress
    );
  
  };
  