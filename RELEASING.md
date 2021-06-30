# Procedure for releasing gem package updates

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
