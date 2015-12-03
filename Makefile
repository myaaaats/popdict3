.PHONY: setup

setup:
	gem install bundler
	bundle install

serve:
	bundle exec unicorn