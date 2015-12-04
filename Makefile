.PHONY: setup

setup:
	gem install bundler
	bundle install

serve:
	bundle exec unicorn -c unicorn.rb -D

stop:
	if [ -f "pids/unicorn.pid" ];then kill -9 $(shell cat "pids/unicorn.pid"); fi
	-rm "pids/unicorn.pid"

image:
	docker build -t popdict .
