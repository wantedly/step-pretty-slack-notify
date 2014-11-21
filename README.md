# Slack Notify Step
Posts wercker build/deploy status to a [Slack Channel](https://slack.com/).

![screenshot](https://raw.githubusercontent.com/wantedly/step-pretty-slack-notify/master/screenshot.png)

## REQUIREMENTS

* `webhook_url` - Your Slack webhook URL.

Options

* `username` - The name of your bot. (default `Wercker`)

## EXAMPLE USAGE

```yml
build:
    after-steps:
        - wantedly/pretty-slack-notify:
            webhook_url: $SLACK_WEBHOOK_URL
            username: cibot
```

```yml
deploy:
    after-steps:
        - wantedly/pretty-slack-notify:
            webhook_url: $SLACK_WEBHOOK_URL
            username: cibot
```

