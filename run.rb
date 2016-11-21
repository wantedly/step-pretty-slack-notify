#!/usr/bin/env ruby

require "slack-notifier"

class Build
  def initialize()
    # See below docs for more details about wercker's environment variables:
    # http://devcenter.wercker.com/docs/environment-variables/available-env-vars
    @app_url           = ENV["WERCKER_APPLICATION_URL"]   || ""
    @build_url         = ENV["WERCKER_BUILD_URL"]         || ""
    @run_url           = ENV["WERCKER_RUN_URL"]           || ""
    @git_owner         = ENV["WERCKER_GIT_OWNER"]         || ""
    @git_repo          = ENV["WERCKER_GIT_REPOSITORY"]    || ""
    @git_commit        = ENV["WERCKER_GIT_COMMIT"]        || ""
    @git_branch        = ENV["WERCKER_GIT_BRANCH"]        || ""
    @git_domain        = ENV["WERCKER_GIT_DOMAIN"]        || ""
    @started_by        = ENV["WERCKER_STARTED_BY"]        || ""
    @result            = ENV["WERCKER_RESULT"]            || ""
    @deploy_url        = ENV["WERCKER_DEPLOY_URL"]        || ""
    @deploytarget_name = ENV["WERCKER_DEPLOYTARGET_NAME"] || ""

    # Wercker's new stack uses WERCKER_RUN_URL instead of WERCKER_BUILD_URL
    if @build_url.empty? && !@run_url.empty?
      @build_url = @run_url
    end
  end

  attr_reader :app_url,
    :build_url,
    :run_url,
    :git_owner,
    :git_repo,
    :git_commit,
    :git_branch,
    :git_domain,
    :started_by,
    :result,
    :deploy_url,
    :deploytarget_name

  def git_commit_url
    case @git_domain
    when "github.com" then
      "https://#{@git_domain}/#{@git_owner}/#{@git_repo}/commit/#{@git_commit}"
    when "bitbucket.org" then
      "https://#{@git_domain}/#{@git_owner}/#{@git_repo}/commit/#{@git_commit}"
    else
      nil
    end
  end

  def is_deploy?
    ENV["DEPLOY"] == "true"
  end

  def has_passed?
    @result == "passed"
  end

  def has_failed?
    @result == "failed"
  end
end

class Message
  def initialize(build)
    @build = build
  end

  def text
    message = "[build](#{@build.build_url})"
    message = "[deploy](#{@build.deploy_url}) to #{@build.deploytarget_name}" if @build.is_deploy?
    message += " for [#{@build.git_owner}/#{@build.git_repo}](#{@build.app_url})"
    message += " by #{@build.started_by} has #{@build.result}"

    if @build.git_commit_url
      message += " on #{@build.git_branch}([#{@build.git_commit[0,8]}](#{@build.git_commit_url}))"
    else
      message += " on #{@build.git_branch}(#{@build.git_commit[0,8]})"
    end
  end

  def fallback
    message = "build"
    message = "deploy to #{@build.deploytarget_name}" if @build.is_deploy?
    message += " for #{@build.git_owner}/#{@build.git_repo}"
    message += " by #{@build.started_by} has #{@build.result}"
    message += " on #{@build.git_branch}(#{@build.git_commit[0,8]})"
  end

  def color
    if @build.has_passed?
      'good'
    else
      'danger'
    end
  end
end

#
# Main
#
# These environment variables are required/optional for pretty-slack-notify step.
webhook_url = ENV["WERCKER_PRETTY_SLACK_NOTIFY_WEBHOOK_URL"] || ""
channel     = ENV["WERCKER_PRETTY_SLACK_NOTIFY_CHANNEL"]     || ""
username    = ENV["WERCKER_PRETTY_SLACK_NOTIFY_USERNAME"]    || "Wercker"
branches    = ENV["WERCKER_PRETTY_SLACK_NOTIFY_BRANCHES"]    || ""
notify_on   = ENV["WERCKER_PRETTY_SLACK_NOTIFY_NOTIFY_ON"]   || ""
icon_url    = "https://secure.gravatar.com/avatar/a08fc43441db4c2df2cef96e0cc8c045?s=140"

abort "Please specify the your slack webhook url" if webhook_url.empty?

build = Build.new

if !branches.empty? && Regexp.new(branches) !~ build.git_branch
  puts "'#{build.git_branch}' branch did not match notify branches /#{branches}/"
  puts "Skipped to notify"
  exit
end

unless notify_on.empty? || notify_on == build.result
  puts "Result '#{build.result}' did not match notify condition '#{notify_on}'"
  puts "Skipped to notify"
  exit
end

notifier = Slack::Notifier.new(webhook_url)
notifier.username = username
notifier.channel  = '#' + channel unless channel.empty?

message = Message.new(build)

response = notifier.ping(
  nil,
  icon_url: icon_url,
  attachments: [{
    fallback: message.fallback,
    text: notifier.escape(message.text),
    color: message.color,
  }]
)

case response.code
when "404" then abort "Webhook url not found."
when "500" then abort response.read_body
else puts "Notified to Slack #{notifier.channel}"
end
