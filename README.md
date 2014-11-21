# Slack Notify Step
Posts wercker build/deploy status to a [Slack Channel](https://slack.com/).

![screenshot](https://raw.githubusercontent.com/wantedly/step-pretty-slack-notify/master/screenshot.png)

## REQUIREMENTS

* `webhook_url` - Your Slack webhook URL.

Options

* `channel`  - The Slack channel to override the channel webhook has. (without #).
* `username` - The name of your bot. (default `Wercker`)

## EXAMPLE USAGE
posts build notification

```yml
build:
    after-steps:
        - wantedly/pretty-slack-notify:
            webhook_url: $SLACK_WEBHOOK_URL
```

posts deploy notification

```yml
deploy:
    after-steps:
        - wantedly/pretty-slack-notify:
            webhook_url: $SLACK_WEBHOOK_URL
```

override channel and/or username

```yml
build:
    after-steps:
        - wantedly/pretty-slack-notify:
            webhook_url: $SLACK_WEBHOOK_URL
            channel: dev
            username: cibot
```

