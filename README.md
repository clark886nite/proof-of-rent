 Proof of Rent - Clarity Smart Contract

 Overview
`Proof of Rent` is a Clarity smart contract designed to provide transparent, on-chain proof of rental payments between tenants and landlords on the Stacks blockchain. This contract enables users to submit, verify, and retrieve immutable records of rent transactions, aiding in trustless rental agreements and dispute resolution.

 Features
- **Submit Rent Proof:** Tenants can submit proof of rental payments, including details such as landlord, rental period, and amount paid.
- **Verify Rent Proof:** Publicly verify if a proof of rent exists for a tenant and rental period.
- **Retrieve Proof Details:** Retrieve full details of any submitted rent proof for auditing or record-keeping.

 Smart Contract Functions

 Public Functions
- `submit-rent-proof (tenant principal) (landlord principal) (rental-period (buff 32)) (amount uint)`
  - Records a rent payment proof with all necessary details.
- `verify-rent-proof (tenant principal) (rental-period (buff 32))`
  - Returns `true` if a proof of rent exists for the given tenant and rental period.
  
Read-Only Functions
- `get-rent-proof-details (tenant principal) (rental-period (buff 32))`
  - Retrieves the full record of a rent proof, including tenant, landlord, amount, rental period, and timestamp.

 Use Cases
- Transparent rent tracking for tenants and landlords.
- Verifiable rental payment history for credit checks or rental applications.
- On-chain evidence in case of disputes between tenants and landlords.

 Deployment
Deploy the contract on the Stacks blockchain using the Clarity smart contract deployment tools such as:
- [Clarinet](https://docs.hiro.so/clarinet/overview) for local development and testing.
- Stacks mainnet or testnet for production or test deployments.

## License
MIT License

---


