## Personascrypto

Personascrypto is an Ethereum contract that allows people to deposit funds into the contract's address and allows them to withdraw them at a specified time.

# Features

- Add people to the contract: only the contract owner can add people and their data, including their wallet address, name, surname, delivery time, and amount of funds deposited.

- Deposit funds: anyone can deposit funds into the contract's address and their amount will be updated in the people's record.

- Verify if funds can be withdrawn: a person can verify if the current time is greater than the delivery time and if they can withdraw their funds.

- Withdraw funds: a person can withdraw their funds if the current time is greater than the delivery time and if it has been verified that they can withdraw their funds.

- View funds: the total balance of funds in the contract can be viewed.

# Use

1. Deploy the contract on the Ethereum network.

2. The contract owner adds people to the contract using the AddPeople function.

3. People deposit funds into the contract's address using the deposit function.

4. People verify if they can withdraw their funds using the CheckWithdraw function.

5. People withdraw their funds using the Withdraw function.

# Warning

```
This contract has not been licensed and its use is at your own risk. Make sure to understand how the contract works before using it.
```
