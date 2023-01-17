# Metacrafters - Solidity Challenge.

This is a solution for Metacrafters - Solidity Challenge:

```
Your contract(s) should be written such that:

1. Funds take the form of a custom ERC20 token
2. Crowdfunded projects have a funding goal
3. When a funding goal is not met, customers are be able to get a refund
   of their pledged funds
4. dApps using the contract can observe state changes in transaction logs
5. Optional bonus: contract is upgradeable
```

<br>

Task complete using [Forge](https://book.getfoundry.sh/). Typical forge project structure:

- `/src`    - Contains `.sol` contracts files;
- `/test`   - Contains `.t.sol` test suites;
- `/script` - Contains `.s.sol` scripts (deployment);

<br>
<br>

## Local deployment in 1 min.

<br>

> Prerequisites: [Docker](https://docs.docker.com/engine/install/), [docker compose](https://docs.docker.com/compose/install/).

<br>
<br>

After repository is downloaded, to test contracts run the following command  
(it's not a typo, it is `forge forge`):

```
docker compose run forge "forge test"
```

![image](https://user-images.githubusercontent.com/62797411/212988333-5ca00164-6f78-4528-8b26-acfce36cf549.png)


<br>
<br>

To run a local blockchain instance at `http://localhost:8545` use:

```
docker compose up
```

![image](https://user-images.githubusercontent.com/62797411/212989528-0f2436a2-d6f0-4056-ade0-31442968a2b8.png)

<br>
<br>

To deploy contracts to the local network after network is setup use:

```
docker compose exec forge \
  /bin/sh -c "forge script Deploy --rpc-url http:127.0.0.1:8545 --broadcast"
```

![image](https://user-images.githubusercontent.com/62797411/212990150-f4cd7595-a64e-49ca-bb1f-99270599fb7b.png)

<br>
<br>
<br>
<br>