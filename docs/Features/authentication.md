# Authentication

We only have the option to sign in with google on Mojapay. We implement this using firebase's authentication service.

Components of the app this feature depends on:


### Models

1. User: <br />
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;String displayName, <br />
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;String email, <br />
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;String photoUrl, <br />
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;String uid;

We don't need to make this collection in firestore. The authentication service provides it.

### Controllers

1. AuthController
2. SetupController

### Repositories

1. AuthRepository - Exposes methods which enable firebase login with google and signout.

### UI Pages

1. LoginSetup - UI for page which allows google login.
2. PhoneNumberSetup - UI for page which allows users to enter phone numbers.

## Business Logic

The business logic is simple. It follows the general code design [design.md](../design.md)

1. The user triggers events on the ui pages above.
2. The controllers perform validation
3. AuthController tries to log user in on LoginSetup using authRepository.
4. On success, the user model object is returned to the controller and the user is navigated to the dashboard.