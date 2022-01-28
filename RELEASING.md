# Procedure for releasing gem package updates

0. As a cygwin user, with docker installed; `docker run -it -v "$(cygpath -w "$PWD"):/app" -w /app ruby:2.7 bash` will get you with a suitable ruby environment for testing/building and releasing this package9.
1. All tests passing
2. Update changelog in `CHANGELOG.md`
3. Update version number in `comet_backup_ruby_sdk.gemspec`
4. `bundle install`
	- Should update our internal version in Gemfile.lock
5. `gem build comet_backup_ruby_sdk.gemspec`
	- Should be warning-free
6. Git tag
	- Respect semver
7. `gem push comet_backup_ruby_sdk-1.x.x.gem`
