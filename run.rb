#!/usr/bin/env ruby

require "slack-notifier"

# Using dotenv for debug in local
#require "dotenv"
#Dotenv.load

webhook_url = ENV["WERCKER_PRETTY_SLACK_NOTIFY_WEBHOOK"]
channel     = ENV["WERCKER_PRETTY_SLACK_NOTIFY_CHANNEL"]
username    = ENV["WERCKER_PRETTY_SLACK_NOTIFY_USERNAME"]

abort "Please specify your slack webhook URL" unless webhook
abort "Please specify your slack channel"     unless channel
username = "Wercker"                          unless username

# See for more details about environment variables that we can use in our steps
# http://devcenter.wercker.com/articles/steps/variables.html
git_owner  = ENV["WERCKER_GIT_OWNER"]
git_repo   = ENV["WERCKER_GIT_REPOSITORY"]
app_name   = "#{git_owner}/#{git_repo}"
app_url    = ENV["WERCKER_APPLICATION_URL"]
build_url  = ENV["WERCKER_BUILD_URL"]
git_commit = ENV["WERCKER_GIT_COMMIT"]
git_branch = ENV["WERCKER_GIT_BRANCH"]
started_by = ENV["WERCKER_STARTED_BY"]

deploy_url = ENV["WERCKER_DEPLOY_URL"]
deploytarget_name = ENV["WERCKER_DEPLOYTARGET_NAME"]
def deploy?
  ENV["DEPLOY"] == "true"
end

def build_message(app_name, app_url, build_url, git_commit, git_branch, started_by, status)
  "[[#{app_name}](#{app_url})] [build(#{git_commit[0,8]})](#{build_url}) of #{git_branch} by #{started_by} #{status}"
end

def deploy_message(app_name, app_url, deploy_url, deploytarget_name, git_commit, git_branch, started_by, status)
  "[[#{app_name}](#{app_url})] [deploy(#{git_commit[0,8]})](#{deploy_url}) of #{git_branch} to #{deploytarget_name} by #{started_by} #{status}"
end

def icon_url(status)
  "https://raw.githubusercontent.com/wantedly/step-pretty-slack-notify/master/icons/#{status}.jpg"
end

def username_with_status(username, status)
  "#{username} #{status.capitalize}"
end

notifier = Slack::Notifier.new(
  webhook_url
  channel: "##{channel}",
)

message = deploy? ?
  deploy_message(app_name, app_url, deploy_url, deploytarget_name, git_commit, git_branch, started_by, ENV["WERCKER_RESULT"]) :
  build_message(app_name, app_url, build_url, git_commit, git_branch, started_by, ENV["WERCKER_RESULT"])

res = notifier.ping(
  message,
  icon_url: icon_url(ENV["WERCKER_RESULT"]),
  username: username_with_status(username, ENV["WERCKER_RESULT"]),
)

case res.code
when "404" then abort "Webhook url not found."
when "500" then abort res.read_body
else puts "Notified to Slack ##{channel}"
end
