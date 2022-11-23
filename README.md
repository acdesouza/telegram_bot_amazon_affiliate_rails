[![Build Status](https://app.travis-ci.com/acdesouza/telegram_bot_amazon_affiliate_rails.svg?branch=main)](https://app.travis-ci.com/acdesouza/telegram_bot_amazon_affiliate_rails)


# Introduction

Telegram Bot to answer messages with Amazon links with your affiliate link.


# Deploy

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/acdesouza/telegram_bot_amazon_affiliate_rails)

The easier way to deploy this code is to use Heroku's services and the Deploy button, on the top of this page.

After deploy the application you'll need to register the bot on Telegram

```
TELEGRAM_BOT_TOKEN="TOKEN_FROM_BOT_FATHER" HEROKU_APP_NAME="appname.herokuapp.com" rake telegram:webhooks:register
```

The Heroku Deploy button will attempt to do it.

## Config

The bot IS YOURS. Not mine ;)

This means you need to create a Telegram bot. [Ask for one to @BotFather](https://core.telegram.org/bots#how-do-i-create-a-bot).
You'll also need to config your Amazon affiliate information.

To make this config you need to add these environment variables to the server you deploy this code:

```
AMAZON_AFFILIATE_CODE
AMAZON_LINK_CODE
TELEGRAM_BOT_TOKEN
HEROKU_APP_NAME
```


# How it works

This is a RailsAPI aplication

The `Telegram::WebhookController` receives the Telegram request and asks `Telegram::Bot` to reply to it.

The `Telegram::Bot` checks if the the message has an Amazon link. And reply to it with an affiliate link.


# Telegram API docs

- [Core API](https://core.telegram.org/api)
- [Telegram Webhooks](https://core.telegram.org/bots/webhooks)
- [Telegram Bot samples](https://core.telegram.org/bots/samples)