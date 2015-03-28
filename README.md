# Slack Notify Step [![Docker Repository on Quay.io](https://quay.io/repository/wantedly/pretty-slack-notify/status "Docker Repository on Quay.io")](https://quay.io/repository/wantedly/pretty-slack-notify)
Posts wercker build/deploy status to a [Slack Channel](https://slack.com/).

![screenshot](https://raw.githubusercontent.com/wantedly/step-pretty-slack-notify/master/screenshot.png)

## REQUIREMENTS

* `webhook_url` - Your Slack webhook URL.

Options

* `channel`  - The Slack channel to override the default channel. (without #).
* `username` - The name of your bot. (default `Wercker`)
* `branches` - Specific branches to notify. (regular expression)

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

notify on specific branches only

```yml
build:
    after-steps:
        - wantedly/pretty-slack-notify:
            webhook_url: $SLACK_WEBHOOK_URL
            branches: ^master$
```

## CHANGELOG
See [CHANGELOG](CHANGELOG.md)
