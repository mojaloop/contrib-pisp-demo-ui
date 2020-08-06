# Account Dashboard

Page to view information about all the accounts the user has linked and the transaction he/she has made from them.

Components of the app this feature depends on:


### Models

1. Account: <br />
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; String userId, consentId, alias, sourceAccountId; <br />
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PartyIdInfo partyInfo; <br />
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FspInfo fspInfo; <br />
2. PartyIdInfo: <br />
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; String fspId, partyIdType, partyIdentifier;
3. FspInfo: <br />
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; String fspId, fspName, fspIconUrl;
   

### Controllers

1. AuthController
2. AccountController
3. AccountDashboardController

### Repositories

1. AccountRepository 
2. TransactionRepository 

### UI Pages

1. AccountDashboard

## Business Logic

1. When the account dashboard is rendered, the ui asks the AccountDashboardController to fetch all linked accounts. 
2. AccountDashboardController asks AccountController to fetch all accounts which inturn uses AccountRepository to get them.
3. Once all the accounts are fetched the first account is displayed by default and it's transactions are fetched using TransactionRepository and displayed on the screen.
4. In case the user switches to a different account, the AccountDashboardController asks TransactionRepository to fetch the transaction for this account and those displayed on the screen.