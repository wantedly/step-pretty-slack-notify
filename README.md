# Slack Notify Step
Posts wercker build/deploy status to a [Slack Channel](https://slack.com/).

![screenshot](https://raw.githubusercontent.com/wantedly/step-pretty-slack-notify/master/screenshot.png)

## REQUIREMENTS

* `webhook` - Your custom Slack webhook URL.
* `channel` - The Slack channel you want to send message for. (without #).

Options

* `username` - The name of your bot. (default `Wercker`)

## EXAMPLE USAGE

```yml
build:
    after-steps:
        - wantedly/pretty-slack-notify:
            webhook: $SLACK_WEBHOOK_URL
            channel: dev
            username: cibot
```
```yml
deploy:
    after-steps:
        - wantedly/pretty-slack-notify:
            webhook: $SLACK_WEBHOOK_URL
            channel: dev
            username: cibot
```

