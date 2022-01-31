# Hardhat template

Sample template with hardhat configuration and several networks deployment.

# Networks

-   Ethereum: Goerli, Kovan, Ropsten, Rinkeby,
-   Arbitrum: Rinkeby

# Configuration of required keys

The configuration of the required keys is done by create a _.env_ file at the root of the project. The format of this file is:

`KEY=VALUE`

An template is provided in _dotenv-template_, please fill the values in and rename it to _.env_. The _.env_ file is ignored by _.gitignore_ and never commited to the repository.

# Local fork

The package provides the ability to fork existing networks locally through:

`$ npm run ganache:$(network)`

Where network can be one of the supported networks mentioned above

# Author

My name is Roberto Cano and you can find me at https://github.com/robercano and https://github.com/The-Solid-Chain
