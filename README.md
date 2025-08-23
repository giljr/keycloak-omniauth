
#  Keycloak + OmniAuth in Rails 8

A minimal example of integrating [Keycloak](https://www.keycloak.org/) authentication into a Ruby on Rails 8 application using the [OmniAuth](https://github.com/ccrockett/omniauth-keycloak) gem.

---

## Clone this Repository

```bash
git clone https://github.com/giljr/keycloak-omniauth.git
cd keycloak-omniauth
```
## Setup Instructions
### 1. Install Ruby and Bundler

Make sure you have Ruby 3.4+ installed.
Then install Bundler:

    gem install bundler

### 2. Install Dependencies

    bundle install

### 3. Configure Keycloak
Remove any broken files (if needed)
```
rm config/credentials.yml.enc
rm config/master.key
```
Create a new client in your Keycloak realm (e.g., quickstart).

Set the Client ID and Client Secret in your Rails app Rails Credential file:

`EDITOR="code --wait" rails credentials:edit`

Paste:
```
keycloak:
  client_id: your-client-id
  client_secret: your-client-secret-id
  host: http://localhost
  port: 8080
  realm: your-realm
  redirect_uri: http://localhost:3000/auth/keycloak/callback


secret_key_base: c06b40... c568bf649c87ea10 (Do not edit)
```
### 4.Configure in Keycloak:

```yml
Client ID: test-cli

Client type: OpenID Connect

Root URL: http://localhost:3000

Valid redirect URIs: http://localhost:3000/auth/keycloak/callback
                     http://localhost:3000/auth/keycloak_openid/callback

Valid post logout redirect URIs: http://localhost:3000/logout_success/*

Web origins: http://localhost:3000

Admin URL: http://localhost:3000

Capability config

Client authentication: on

Authentication flow

Standard flow: on
Direct access grants: on

Logout settings

Front channel logout: on

Front-channel logout session required: on
```
### 5. Run the Rails App

    bin/dev

Your app should now be available at http://localhost:3000.

Login Flow

    Click the Login with Keycloak button.

    Authenticate via Keycloak.

    You’ll be redirected back to Rails with a valid session.

Notes

    Turbo is disabled on the login button to avoid issues with OmniAuth redirects.

    Tested on Rails 8.0.2 and Ruby 3.4.4.
## Acknowledgements

 - [Omniauth::Keycloak](https://github.com/ccrockett/omniauth-keycloak)
 - [Jeovan Farias](https://www.linkedin.com/in/jeovan-f-6283b8145/)
 - [Keycloak For beginers](https://medium.com/jungletronics/keycloak-identity-provider-192ffd9a00ae)


## License

[MIT](https://choosealicense.com/licenses/mit/)

