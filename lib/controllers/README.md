## Controllers

Controllers maintain the state for our app. All the business logic lies in these classes. When state changes in a controller, the widget which uses this state is notified by Get.

We have two kinds of controllers.

#### App controllers

Controllers which maintain global app state.

- **Auth Controller** - Maintains the current signed in user and their phone number.
- **Account Controller** - Maintains the current signed in user's linked bank accounts.

#### Ephemeral controllers

Controllers which maintain per page state. In most cases we have one controller per page. You should expect to see one ephemeral controller per widget listed in ui/pages .