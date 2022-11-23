[![Build Status](https://app.travis-ci.com/acdesouza/telegram_bot_amazon_affiliate_rails.svg?branch=main)](https://app.travis-ci.com/acdesouza/telegram_bot_amazon_affiliate_rails)

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/acdesouza/telegram_bot_amazon_affiliate_rails)


# Introduction

Telegram Bot to answer messages with Amazon links with your affiliate link.


# Deploy

After deploy the application you'll need to register the bot on Telegram

```
TELEGRAM_BOT_TOKEN="TOKEN_FROM_BOT_FATHER" HEROKU_APP_NAME="appname.herokuapp.com" rake telegram:webhooks:register
```

The Heroku Deploy button will attempt to do it.


# How it works

The `Telegram::WebhookController` receives the Telegram request and asks `Telegram::Bot` to reply to it.


# Telegram API docs

- [Core API](https://core.telegram.org/api)
- [Telegram Webhooks](https://core.telegram.org/bots/webhooks)
- [Telegram Bot samples](https://core.telegram.org/bots/samples)