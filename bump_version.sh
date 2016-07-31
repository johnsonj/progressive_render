#!/bin/bash

VERSION='patch'

gem install gem-release
gem bump --version $VERSION
cd spec/dummy
bundle install
cd ../../
appraisal install
git add spec/dummy/Gemfile.lock
git add gemfiles/*.lock
git commit -am "Bumping collateral for new gem version"
gem release --tag