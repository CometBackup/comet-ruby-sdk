# Procedure for releasing gem package updates

With docker installed: `docker run -it -v "${PWD}:/app" -w /app ruby:2.7 bash` will get you with a suitable ruby environment for testing, building, and releasing this package (use `-v "$(cygpath -w "$PWD"):/app"` for Cygwin).

1. All tests passing (e.g. COMETSERVER_ADDRESS=http://127.0.0.1:8060 COMETSERVER_ADMINUSER=admin COMETSERVER_ADMINPASS=admin rake)
2. Update changelog in `CHANGELOG.md`
3. Update version number in `comet_backup_ruby_sdk.gemspec`
4. `bundle install`
	- Should update our internal version in Gemfile.lock
5. `gem build comet_backup_ruby_sdk.gemspec`
	- Should be warning-free
6. Git tag
	- Respect semver
7. `gem push comet_backup_ruby_sdk-x.x.x.gem`
