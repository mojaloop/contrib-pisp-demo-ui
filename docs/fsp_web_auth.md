# Instructions for FSP Web Auth

The FSP must ensure that when creating their web login, the web login redirects the user to a URI that is recognizable by the app so that the auth token may be extracted.

The URI that the login page must redirect the user to upon successful login is of the format:

pisp://...?token={auth_token}

The important thing is that:

1. The scheme must be 'pisp'
2. There must be a query parameter labelled 'token'

**NOTE:** The absence of the parameter 'token' or an empty token indicates to the app that the login was unsuccessful.

As long as those two conditions are met, the app will be able to successfully retrieve the auth token from the login.

Please see the web_auth_example to see an example of a barebones working login page.
