const AuctionBidder = artifacts.require("AuctionBidder");
const myAddress = "0x78fe389778e5e8be04c4010Ac407b2373B987b62"
const goerliAuctionHouseAddress = "0xc290450311686f9B4d87b579da0b8b83C809517c"
const goerliSushiPoolAddress = "0xd33c0bf246902ff4C87FA52C32F01aB0126Fda15"
const goerliWETH2Address = "0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6"
const goerliFluidTokenAddress = "0xBa01a0552C37036168b120165599193042c93B0E"
const goerliDAOTreasuryAddress = "0xc4339bE0780a5922007919d19d39Cc02234d68Bf"

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
      goerliAuctionHouseAddress,
      goerliSushiPoolAddress,
      goerliWETH2Address,
      goerliFluidTokenAddress,
      goerliDAOTreasuryAddress
    );
  
  };
  