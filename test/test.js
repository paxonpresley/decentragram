const { assert } = require('chai')

const Decentragram = artifacts.require('./Decentragram.sol')

require('chai')
  .use(require('chai-as-promised'))
  .should()

contract('Decentragram', ([deployer, author, tipper]) => {
  let decentragram

  before(async () => {
    decentragram = await Decentragram.deployed()
  })

  describe('deployment', async () => {
    it('deploys successfully', async () => {
      const address = await decentragram.address
      assert.notEqual(address, 0x0)
      assert.notEqual(address, '')
      assert.notEqual(address, null)
      assert.notEqual(address, undefined)
    })

    it('has a name', async () => {
      const name = await decentragram.name()
      assert.equal(name, 'Decentragram')
    })
  })

  describe('images', async () => {
    let result, imageCount;
    const hash = '0x0abcd1234';

    before(async () => {
      result = await decentragram.uploadImage(hash, 'image desc', {from: author});
      imageCount = await decentragram.imageCount();
    })

    it('creates images', async () => {
      // success
      assert.equal(imageCount, 1);
      const event = result.logs[0].args;
      assert.equal(event.id.toNumber(), imageCount.toNumber(), 'id is correct');
      assert.equal(event.hash, hash, 'Hash is correct');
      assert.equal(event.description, 'Image description', 'description is correct');
      assert.equal(event.tipAmount, '0', 'Tip amount is correct');
      assert.equal(event.author, author, 'Author is correct');
    })
  })
})