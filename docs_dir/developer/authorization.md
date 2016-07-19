# Authorization

Coral currently uses the [Anvil.io](http://www.anvil.io) system for authentication and authorization.

Anvil Connect is an authentication server. It acts as a database of users and permissions, and provides authentication and authorization as a service to other apps.

You can use Anvil Connect to create JSON Web Tokens. These are identity and access tokens that can be used to authorize an API request.


If you intend to hit endpoints through a browser, install an Addon/plugin/extension that will allow you to add headers to your requests

Currently, Anvil is used to

"The Anvil.io system is used for authentication and authorization. This requires the creation of a user against the Anvil system.”

JSON Web Tokens

Anvil Connect issues identity and access tokens as digitally signed JSON Web Tokens. Signatures provide an exceptionally trustworthy mechanism for verifying authenticity. And with their object payload, JWTs can carry everything needed to authorize an API request.

I’m not super familiar with auth systems generally, but it sounds like this is basically just taking the responsibility for faffing around with authorization stuff out of the hands of our own app and handing it off to another party

that's right, it's useful when you have more than one app for the same users

that's right, it's useful when you have more than one app for the same users

[3:51]  
or when you want to enable third party apps to sign in with Xenia, for example

[3:51]  
also for protecting APIs, and that sort of thing


Ah, ok. So if you have something like Postman (I think it’s Postman) installed in Chrome, you can pass it through that way

christiansmith [3:53 PM]  
sure

[3:53]  
exactly

[3:53]  
These are sometimes called "Bearer" tokens

[3:51]  
or when you want to enable third party apps to sign in with Xenia, for example

[3:51]  
also for protecting APIs, and that sort of thing

Anvil Connect is an "auth server".

[3:44]  
It acts like a database of users and permissions.

[3:44]  
It also provides authentication and authorization as a service to other apps

[3:45]  
Those apps could live on another server, right in the web browser, on a mobile device, etc

[3:45]  
The way Anvil delivers authentication to an app is using something called an "auth flow"

[3:46]  
These are defined by standards like OAuth 2.0 and OpenID Connect

[3:47]  
A user visiting an app that requires sign in will typically be redirected to Anvil (the auth server), which performs some authentication (like email+password, or sign in with Facebook), and then redirects the user back to the original app

[3:47]  
The result of a successful auth flow is a set of tokens

[3:47]  
There are different kinds of tokens, like access token, refresh token, and id token

[3:48]  
apps can use access tokens for authenticating API requests (an AJAX request in the browser, for example)
