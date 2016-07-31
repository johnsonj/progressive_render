#!/bin/bash

#
# Bump the gem version
# Pass in 'patch, minor, major' to specify what to update. Default is patch.
#
# This is needed to ensure all the Gemfile.locks are up to date with the
# new version. Otherwise any CI builds will fail.
#

gem install gem-release
gem bump --version ${1:-patch}
cd spec/dummy
bundle install
cd ../../
appraisal install
git add spec/dummy/Gemfile.lock
git add gemfiles/*.lock
git commit -am "Bumping collateral for new gem version"
gem release --tag