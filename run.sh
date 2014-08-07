#!/bin/bash

ruby -v
gem install slack-notifier -v 0.5.0
$WERCKER_STEP_ROOT/run.rb
