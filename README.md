# Slack Notify Step
Posts wercker build/deploy status to a [Slack Channel](https://slack.com/).

![screenshot](https://raw.githubusercontent.com/wantedly/step-pretty-slack-notify/master/screenshot.png)

## REQUIREMENTS

* `team` - Your Slack team subdomain.
* `token` - Your Slack integration token.
* `channel` - The Slack channel you want to send message for. (without #).

Options

* `username` - The name of your bot. (default `Wercker`)

## EXAMPLE USAGE

```yml
build:
    after-steps:
        - wantedly/pretty-slack-notify:
            team: mycompany
            token: $SLACK_API_TOKEN
            channel: dev
            username: cibot
```

