# CHANGELOG

## 2022-05-25 v1.14.0
- Based on 22.3.7
- Add new `REMOTESERVER_S3_GENERIC` `RemoteServerType`
- add new `S3GenericVirtualStorageRole` support to the `RemoteServerAddress`

## 2022-05-10 v1.13.0
- Based on 22.3.5
- Add new `RestrictRuntime`, `FromTime`, `ToTime`, `RestrictDays`, `DaysSelect` types to ScheduleConfig to add time and day restrictions in a hourly schedule.
- Add new `TotalVmCount` to `BackupJobDetail` API.
- Add new fields to `MacOSCodeSignProperties` to support code signing.
- Add new `ForceUpgradeRunning`, `ApplyDeviceFilter`, and `DeviceFilter` fields to `UpdateCampaign` types to support sending a bulk upgrade to a custom query of users
- Add new `AdminBrandingGenerateClientSpkDsm6` and `AdminBrandingGenerateClientSpkDsm7` APIs and associated types for generating and downloading Synology SPKs
- Add new `PathAppIconImage` field to branding options types to support branding of the app icon when installed in Synology's Package Center (and other software managers)
- Add new constants for VMDK single file restore

## 2022-01-28 v1.12.0
- Based on 21.12.4
- Add `AdminStoragePingDestination` API to perform a server-side Test Connections action when configuring Storage Role
- Add `DestinationSize*` on `BackupJobDetail` struct, to track Storage Vault size measurements taken as part of jobs
- Add `HasLicense` on `Office365MixedVirtualAccount` struct, and add `TotalLicensedMailsCount` and `TotalUnlicensedMailsCount` on `BackupJobDetail` struct, to track Office 365 license usage
- Add `AdminWebAuthnRegistration` new `Type` field and `WEBAUTHN_DEVICE_TYPE` constants, to determine the type of hardware WebAuthn device
- Add deprecation comments to U2F types (use WebAuthn instead), to `B2DestinationLocation.MaxConnections`, and to `Office365CustomSetting` (use Office365CustomSettingV2 instead)
- Fix an issue with wrong array types in `WebAuthnPublicKeyCredentialCreationOptions` and `WebAuthnPublicKeyCredentialRequestOptions`
- Fix an issue with wrong values for some `STOREDOBJECTTYPE_` constants related to Office 365
- Fix an issue with executable permissions on some files

## 2021-12-22 v1.11.0
- Based on 21.12.1
- Add `AdminAccountWebauthnRegistration` endpoint for new WebAuthn support.
- Deprecate `AdminAccountU2fSubmitChallenge` as U2F is ending browser support in February 2022.

## 2021-11-24 v1.10.0
- Based on 21.9.12
- Add support for Thai and Danish localizations
- Add From and To fields to the EmailReportGenerated API
- Add `AdminDispatcherEmailPreview` api method for requesting the HTML content of an email
- Add `ImageEtag` field to the response of the ServerMetaBrandingProperties endpoint.
- Add support for new engine properties on the Office365 backup type.
- Add `AdminDispatcherOffice365ListVirtualAccounts` api method for requesting Objects that Office365 is capable of backing up.

## 2021-10-21 1.9.0
- Based on 21.9.7
- Add Support for `HideFiles` parameter in B2 Destination Locations
- Add support for `RegistrationTime` to `DeviceConfig`
- Upgrade MYSQL to support new TLS connection options
- Add support for new API: `AdminMetaReadAllLogsRequest` and `AdminDispatcherRequestWindiskSnapshot`

## 2021-09-14 1.8.0
- Based on Comet 21.9.2
- Support new `custom_headers` field on the `WebhookOption` class for specifying custom HTTP headers
  to be sent in webhook POST requests from Comet Server

## 2021-09-08 v1.7.0
- Based on Comet 21.9.1
- Support new `device_timezone` field on the `DeviceConfig` class. 
- Add `admin_dispatcher_ping_destination` api method
- Add support for new retention range type constants: `RETENTIONRANGE_LAST_X_BACKUPS_ONE_FOR_EACH_DAY`
- Add support for new retention range type constants: `RETENTIONRANGE_LAST_X_BACKUPS_ONE_FOR_EACH_WEEK`
- Add support for new retention range type constants: `RETENTIONRANGE_LAST_X_BACKUPS_ONE_FOR_EACH_MONTH`
- Add support for Microsoft Office 365 Sharepoiint constant `STOREDOBJECTTYPE_MSSITELISTDRIVEENTITY`
- Add Microsoft Office 365 Region cloud region constants `OFFICE_365_REGION_PUBLIC`
- Add Microsoft Office 365 Region cloud region constants `OFFICE_365_REGION_CHINA`
- Add Microsoft Office 365 Region cloud region constants `OFFICE_365_REGION_GERMANY`
- Add Microsoft Office 365 Region cloud region constants `OFFICE_365_REGION_US_GOVT`
- Add Microsoft Office 365 Region cloud region constants `OFFICE_365_REGION_US_DOD`

## 2021-07-01 v1.6.0
- Based on Comet 21.6.6
- Support new `DefaultSourceWithOSRestriction` and `LastSuccessfulBackupJob` fields
- Support custom credentials when performing a cloud Office 365 restore job
- Support identifying Microsoft Teams folders inside a Sharepoint backup job
- Document the `SourceIncludePattern` structure used for `PINCLUDE`/`RINCLUDE` rules in a File-type `EngineProps` array
- Document existing `BrandingProps` endpoint

## 2021-05-25 v1.5.0
- Based on Comet 21.6.1
- Add new APIs to remotely browse MySQL, MongoDB, MSSQL database servers
- Add Microsoft Office 365 properties on BackupJobDetail and on StoredObject
- Add Microsoft Office 365 browsing APIs
- Add Microsoft Office 365 Engine definition (`ENGINE_BUILTIN_MSOFFICE`) and associated `EngineProp` data structure definitions
- Add `AdminDispatcherRegisterOfficeApplication` APIs
- Add `RESTORETYPE_OFFICE365_CLOUD` constant
- Support suspending organizations
- Support reading the Server Self-Backup status
- Support new `PathMenuBarIcnsFile` branding option for Comet Backup on macOS
- Add more detailed description for `AdminDispatcherRequestStoredObjects`

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
