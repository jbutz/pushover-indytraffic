# Pushover Indy Traffic

This is a small application that will, in the future, be absorbed into a larger project I am working on. I am publishing this portion early so that others may take advantage of it.

## What it does

This bit of code pulls down any current traffic alerts from INDOT's website and sends a pushover notification for them. The messages are stored in a database so that you don't get duplicates for things like construction that might stay on their page for weeks or months at a time. These stored messages expire after a week, so you will be reminded of the construction.

## What do I need to use this?

You will need somewhere to run it, [Heroku](https://www.heroku.com) works well. You need a [Pushover](https://pushover.net/) account so you can get your user Token and create an application. A basic knowledge of the command line interface is also good

## Setup

I am going to assume you have a Heroku account, a pushover account, and have created a pushover application.

1. Clone this repo
2. Change to the new directory
3. Run `heroku apps:create`
4. Add you user token to the application by running `heroku config:add USER_TOKEN=******`, make sure to replace `******` with your user token from Pushover
5. Add you app token to the application by running `heroku config:add APP_TOKEN=******`, make sure to replace `******` with your app token from Pushover
6. Set the enviroment manually by running `heroku config:add RACK_ENV=production`
7. Add the MongoHQ addon by running `heroku addons:add mongohq:sandbox`
8. Push to Heroku by running `git push heroku master`
9. Run `heroku ps:scale clock=1` to start the app

That's it! If there are any alerts out there now, like construction, you should get them once the app starts.

## But I don't have Pushover and I don't want it!

Then fork the repo and change it to send e-mails or something. You won't have to change much.

## You're doing it wrong!

I know I shouldn't be using Rake tasks, but it really isn't a performance hit here. Be glad I'm not shelling out. When this is absorbed into the larger app I will probably fix this. If you want to fix it here then give me a pull request. It will be appreciated.
