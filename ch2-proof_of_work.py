# Book Title: Decentralized AI Networks and Blockchain Integration
# This code is provided as a companion reference for the publication above.
# Chapter 2: Proof of work
# A simplified pseudocode is as follows:
# python
def proof_of_work(block, difficulty):
    nonce = 0
    while True:
        block_hash = hash(block + str(nonce))
        if block_hash.startswith('0'*difficulty):
            return nonce, block_hash
        nonce += 1