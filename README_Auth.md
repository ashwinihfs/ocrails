# Set Up Authorization #


In order to set up the authorization system you will need to create a token at each external service you
wish to support

Initially we support

* Twitter [Set Up](https://dev.twitter.com)
* Facebook [Set Up](https://developer.facebook.com)
* Local Identity (E-Mail/Password)


# Application Setup #

Once you have your (external) Provider Key, and Secret, you need to add these to a file at the root of the project
called .env (if you want separate ones for your development / test environment, create .env.development, or .env.test)

The current keys (devined in config/initializers/omniauth.rb) are:-

* OC_TWITTER_KEY (Put your TWITTER Application Key
* OC_TWITTER_SECRET
* OC_FACEBOOK_KEY
* OC_FACEBOOK_SECRET

If you are deploying to HEROKU, you use the HEROKU config:set applications, as [described on this page](https://devcenter.heroku.com/articles/config-vars)
