var wunion = artifacts.require("./union.sol");

contract('wunion', function(accounts) {
	var unionInstance;

	it('sets the profession on which to vote', function() {
		return wunion.deployed().then(function(instance) {
			unionInstance = instance;
			unionInstance.voteforProfession('engineer', {from: accounts[0]});
			return unionInstance.job_detail(accounts[0], 'engineer', {from: accounts[0]});
		}).then(function(bool) {
			assert.equal(bool, true, 'profession has been selected');
			return unionInstance.job_detail(accounts[1], 'engineer');
		}).then(function(bool) {
			assert.equal(bool, false, 'wrong profession has been choosen');
		})
	})

	it('gives people the power of vote', function() {
		return wunion.deployed().then(function(instance) {
			unionInstance = instance;
			return unionInstance.giveRighttoVote(accounts[1], 'engineer', {from: accounts[0]});
		}).then(assert.fail).catch(function(error) {
			assert(error.message.indexOf('revert') >=0, 'error message must contain revert');
			unionInstance.voteforProfession('engineer', {from: accounts[0]});
			//cannot check for nested mappings directly
			//because maping is stored over the entire 256-bit addressable storage
		})
	})

	it('delegates the vote to required member of choice', function() {
		return wunion.deployed().then(function(instance) {
			unionInstance = instance;
			return unionInstance.delegate.call(accounts[1], {from: accounts[0]});
		}).then(function(success) {
			assert.equal(success, true, 'delegation is complete');
		})
	})
})