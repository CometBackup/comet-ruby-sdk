# Procedure for releasing gem package updates

1. All tests passing
2. Update changelog in `CHANGELOG.md`
3. Update version number in `gemspec`
4. `gem build`
	- Should be warning-free
5. Git tag
	- Respect semver
6. `gem push comet_backup_ruby_sdk-0.x.x.gem`
