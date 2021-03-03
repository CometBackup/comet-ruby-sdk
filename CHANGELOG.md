# CHANGELOG

## 2021-03-03 v1.4.0
- Based on Comet 21.2.1
- Support restoring files to original paths
- Support the new "Custom" requestable Storage Vault provider type and its `CustomRemoteBucketSettings` structure
- Support new `SpanUseStaticSlots` attribute
- Fix missing fields in `ExternalLDAPAuthenticationSourceSettings` structure
- Fix broken `AdminDispatcherRequestFilesystemObjects` that was parsing into the wrong response type

## 2020-11-24 v1.3.0
- Based on Comet 20.11.0
- Support new `AdminDispatcherDeleteSnapshots` API for deleting multiple snapshots in a single step
- Support `AdminMetaResourceNew` API using multipart request
- Fix an issue with properly raising `TypeError` for invalid parameters

## 2020-11-05 v1.2.0
- Based on Comet 20.9.10
- Support new `ThawExec` feature

## 2020-10-08 v1.1.0
- Based on Comet 20.9.6
- Support new `AdminStorageBucketProperties` API
- Allow passing in nil or no value for `AdminStorageFreeSpace` parameter
- Fix an issue with automatic SelfAddress parameters not containing a trailing slash

## 2020-09-16 v1.0.0
- Tag a v1.0.0 release as the SDK design has stabilized. Future v1.x.x SDK releases will remain compatible with code written against v1.0.0, according to [Semantic Versioning](https://semver.org/).
- Support new Organization feature
- Support new `AdminCreateInstallTokenRequest` API
- Support new Admin user management APIs
- Support new `RebrandStorage` property on Storage Vaults and on Requestable destination targets
- Update descriptions for `SEVT_META_HELLO` and `AdminMetaWebhookOptionsSet`

## 2020-08-28 v0.4.0
- Feature: Add definitions B2 and Wasabi `VirtualStorageRole` classes
- Feature: Add definitions for remote LDAP authentication data sources
- Fix an issue with floating point constant initializers

## 2020-08-24 v0.3.1
- Fix an issue with version number in gem packaging
- Fix an issue with `.clear` initializers for numeric types
- Fix an issue with extra whitespace affecting the RuboCop linter

## 2020-08-24 v0.3.0
- Based on Comet 20.8.0
- Feature: Support new `AdminGetJobLogEntries` endpoint
- Enhancement: Support new `.clear` method to reset a model class to its zero-initialized value
- Enhancement: Include the parameter name and expected type in all raised `TypeError` exception messages
- Enhancement: Zero-initialize all model class members on construction
- Enhancement: Raise `TypeError` for malformed numeric (int/float) type parameters (the Comet Server would already prevent these server-side)

## 2020-08-04 v0.2.0
- Based on Comet 20.6.8-rc
- Initial public release

## 2020-07-31 v0.1.0
- Gem packaging

## 2020-07-31 v0.0.0
- Initial private release
