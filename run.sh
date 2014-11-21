#!/bin/bash

# If step using system ruby, it should install gem as root.
# If step using rvm/rbenv ruby, it shouldn't install gem as root.
# See https://github.com/wantedly/step-pretty-slack-notify/issues/1
if [ `which ruby` = "/usr/bin/ruby" ]; then
  ruby -v
  sudo gem install slack-notifier -v 1.0.0 --no-ri --no-rdoc
elif which ruby ; then
  ruby -v
       gem install slack-notifier -v 1.0.0 --no-ri --no-rdoc
else
  echo "You need to use a box that installed ruby."
fi
$WERCKER_STEP_ROOT/run.rb
