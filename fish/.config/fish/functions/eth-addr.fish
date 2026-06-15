function eth-addr --description "<private key>"
  set private_key $argv[1]

  env PRIVATE_KEY=$private_key node -e "console.log(new (require('ethers').Wallet)(process.env.PRIVATE_KEY).address)"
end
