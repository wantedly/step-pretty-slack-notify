#!/bin/bash

ruby -v
gem list
bundle install
$WERCKER_STEP_ROOT/run.rb
