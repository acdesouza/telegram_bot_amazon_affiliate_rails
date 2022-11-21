# README

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/acdesouza/telegram_bot_amazon_affiliate_rails)

Telegram Bot to answer messages with Amazon links with your affiliate link.


After deply the application you'll need to register the bot on Telegram

```
TELEGRAM_BOT_TOKEN="TOKEN_FROM_BOT_FATHER" HEROKU_APP_NAME="appname.herokuapp.com" rake telegram:webhooks:register
```

The Heroku Deploy button will attempt to do it.