var auction = artifacts.require("./union.sol");

	module.exports = function(deployer) {
		var prop = new Array(2.5, 3.5, 4.5, 5.5);
		deployer.deploy(auction, prop);
	}