#!/bin/bash

# If step using system ruby, it should install gem as root.
# If step using rvm/rbenv ruby, it shouldn't install gem as root.
# See https://github.com/wantedly/step-pretty-slack-notify/issues/1

if which ruby > /dev/null 2>&1 ; then
  CURRENT_USER=$(whoami)
  RUBY_PATH=$(which ruby)
  RUBY_OWNER=$(ls -l "${RUBY_PATH}" | tr -s ' ' | cut -d ' ' -f 3)

  echo "Ruby Version: $(ruby -v)"
  echo "Ruby Path: ${RUBY_PATH}"
  echo "Install User: ${CURRENT_USER}"
  echo ""


  if [ "${CURRENT_USER}" = "${RUBY_OWNER}" ]; then
    echo "Installing slack-notifier..."
         gem install slack-notifier -v 1.0.0 --no-ri --no-rdoc
  else
    echo "Installing slack-notifier as root..."
    sudo gem install slack-notifier -v 1.0.0 --no-ri --no-rdoc
  fi

  $WERCKER_STEP_ROOT/run.rb
else
  # Support Docker Box
  if which docker > /dev/null 2>&1 ; then
    echo "Docker Version: $(docker -v)"
    echo ""

    script/run
  # No ruby, no docker case
  else
    echo "You need to use a box that installed ruby."
    exit 1
  fi
fi
