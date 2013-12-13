# ocrails.com #


Group page for the Orange County Ruby on Rails meetup.


## Mission ##

* Bring together local Rails developers
* Share information worldwide with other developers
* Create a framework that other developer groups can reuse for their own purposes


## Configuration ##

There are configuration files you need to look at before trying to run this

1. Create a `config/application.yml` file (do not check in to version control), you can use the `config/application_example.yml` file as an example.

   This file contains the environment variables you need (that keep secret data out of the repositories)


## Deployment Configuration ##


### Heroku ###


On Heroku, you need to replace the configuration that would normally be placed in `config/application.yml` by a series of
config:set commands

Example:

*Enable Twitter Login*

    heroku config:set OC_TWITTER_ENABLE: true
    heroku config:set OC_TWITTER_KEY: Twitter_Key_Goes_Here
    heroku config:set OC_TWITTER_SECRET: Twitter_Secret_Goes_Here

You can also push the current contects of your `config/application.yml` to heroku by using the `rake figaro:heroku` task

When using the `config:set` option, Heroku will automatically restart your application.

### Other VPS / Physical Providers ###


Create a file called `config/application.yml` (you can use the contents of `config/application_example.yml`), this is a standard
YAML file, so to enable the twitter login example on Heroky, your application.yml would contain the following:-


    OC_TWITTER_ENABLE: true
    OC_TWITTER_KEY: Twitter_Key_Goes_Here
    OC_TWITTER_SECRET: Twitter_Secret_Goes_Here

Please make sure you restart the server / application after making any changes to `config/application.yml`

# Contributors #


* Juan Gallardo
    * [GitHub](https://github.com/JGallardo)
    * [Twitter](https://twitter.com/JGallardo2600)

* Harssh S Shrivastava
    * [GitHub](https://github.com/harsshhfs)
    * [Twitter](https://twitter.com/harssh219)

* Mike Simkins
    * [GitHub](https://github.com/msimkins)
    * [Twitter](https://twitter.com/g7obs)

# License #

MIT Open Source License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
