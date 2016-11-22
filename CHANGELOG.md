## 0.3.0 (2016-11-22)
New Features:

* Support to define additional message [#36](https://github.com/wantedly/step-pretty-slack-notify/pull/36)

Changes:

* Use latest icon [#36](https://github.com/wantedly/step-pretty-slack-notify/pull/36)
* Change default message [#36](https://github.com/wantedly/step-pretty-slack-notify/pull/36)

## 0.2.14 (2015-12-07)
Bugs Fixed:

* Use empty string for default value of environment variables [#26](https://github.com/wantedly/step-pretty-slack-notify/pull/26)
* Skip notifying if notify_on condition does not match [#25](https://github.com/wantedly/step-pretty-slack-notify/pull/25)

## 0.2.13 (2015-12-03)
Bugs Fixed:

* Modify environment variable of notify_on correctly [#23](https://github.com/wantedly/step-pretty-slack-notify/pull/23)

## 0.2.12 (2015-12-03)
Bugs Fixed:

* `notify_on` was not working correctly [#22](https://github.com/wantedly/step-pretty-slack-notify/pull/22)

## 0.2.11 (2015-09-17)
New Features:

* Add A flag `notify_on` that allows you to specify whether to notify on failures only [#17](https://github.com/wantedly/step-pretty-slack-notify/issues/17)

## 0.2.10 (2015-06-20)
Changes:

* Updated slack-notifier to 1.2.1 [#16](https://github.com/wantedly/step-pretty-slack-notify/pull/16)

## 0.2.9 (2015-06-07)
New Features:

* Lightweight docker image (803.4MB -> 151.6MB)

Changes:

* Use ruby2.1.5

## 0.2.8 (2015-03-30)

New Features:

* Supports notify on specific branch #14

## 0.2.7 (2015-02-02)

Bugs Fixed

* `no such file or directory` error on wercker-labs/docker box #12

## 0.2.5 (2015-02-02)

New Features:

* Supports Docker Box #11
* Add test scripts to help developing the step: `script/test-for-ruby-box` and `script/test-for-docker-box`

Changes:

* Start to write CHANGELOG
