# CHANGELOG

## 2025-02-17 v2.41.0
Update to 24.12.5

- Based on Comet 24.12.5

## 2025-01-29 v2.40.0

- Based on Comet 24.12.4

## 2025-01-22 v2.39.0

- Based on Comet 24.12.3
- Additional properties for BrandingOptions, BrandingProperties and ServerMetaBrandingProperties

## 2025-01-15 v2.38.0

- Based on Comet 24.12.2
- Support new Login Protection feature
- Support requiring password changes for admin accounts
- Support new user grouping functionality
- Support creating a first admin account on empty servers
- Support vault-device associations and automatic vault creation

## 2024-10-29 v2.37.0

- Based on Comet 24.9.6
- New API AdminDispatcherTestSmbAuth to instruct a device to test Windows SMB credentials
- New RESTORETYPE_WINDISK_VHDX to restore Disk Image backup as Hyper-V VHDX format
- BackupJobDetail supports ConflictingJobID field to indicate conflicting job if a lock error occurred
- BackupJobProgress can report the total number of items for progress visualization
- DiskDrive adds information about parent disks on Linux

## 2024-09-17 v2.36.0

- Based on Comet 24.9.1
- Added Hyper-V Guest limits per user
- Added VMware Guest limits per user
- Added protected item type (engine) to protected item class
- Added Force Overwrite Restore permissions

## 2024-08-01 v2.35.0

- Based on Comet 24.6.6
- Add new AdminConvertStorageRole API
- Update data types for new job retry feature (BackupJobDetail, BackupRuleEventTriggers, and new JOB_STATUS_RUNNING_TRYAGAIN)
- Add support for custom Prefix in S3GenericVirtualStorageRole

## 2024-07-16 v2.34.0

- Based on Comet 24.6.4
- Added Server Device and Booster Limits
- Added API to count devices registered on a Server
- Added Software Build Role configuration per tenant

## 2024-06-11 v2.33.0

- Based on Comet 24.6.0
- Added custom HELO/EHLO STMP support
- Added support to set if disabled Office 365 accounts should be backed up
- Added EngineType as a property of VaultSnapshots

## 2024-05-31 v2.32.0

- Based on Comet 24.5.0
- Added support for matching Microsoft Office 365 users and groups by Drive ID
- Added support for configuring Object Lock on a Impossible Cloud Partner API Storage Template
- Added support for Custom Body Date when using a Custom Remote Bucket Storage Template

## 2024-05-24 v2.31.0

- Based on Comet 24.3.9

## 2024-05-17 v2.30.0

- Based on Comet 24.3.8
- Added support for configuring Software Build Role builder count
- Added LastStartTime field to job statistics

## 2024-05-14 v2.29.0

- Based on Comet 24.3.7
- Added support for configuring concurrency in Microsoft 365 Protected Items

## 2024-05-02 v2.28.0

- Based on Comet 24.3.6
- Testing new release process

## 2024-04-12 v2.27.0

- Based on Comet 24.3.5

## 2024-01-23 v2.26.0

- Based on Comet 23.12.3

## 2024-01-17 v2.25.0

- Based on Comet 23.12.3

## 2023-12-21 v2.24.0

- Based on Comet 23.12.1

## 2023-12-20 v2.23.0

- Based on Comet 23.11.2

## 2023-11-21 v2.22.0

- Based on Comet 23.9.11

## 2023-11-06 v2.20.0

- Based on Comet 23.9.9
- Add Syncro support

## 2023-11-03 v2.20.0

- (This release is identical to the v2.19.0 release version.)

## 2023-11-03 v2.19.0

- Based on Comet 23.9.8

## 2023-10-25 v2.18.0

- Based on Comet 23.9.7
- Add VMware support

## 2023-10-18 v2.16.0

- Based on Comet 23.9.6
- Added Comet Storage Remote Server Type

## 2023-10-12 v2.15.0

- Based on Comet 23.9.5
- Add new field `LogLevel` to control job log verbosity
- Add new `RESTORETYPE_WINDISK_ESXI` for restoring to VMware-compatible
virtual disks

## 2023-09-19 v2.14.0

- Based on Comet 23.9.2
- 'UseObjectLock' for S3 compatible storage settings deprecated. Replaced by 'ObjectLockMode'
- New Streamable event SEVT_DEVICE_LOBBY_CONNECT and SEVT_DEVICE_LOBBY_DISCONNECT
- Added 'TOTPCode' to 'InstallCreds' used for device registration.
- 'GroupedBy' added to 'PSAConfig' for grouping statistics.
- New APIs
	- AdminInstallationDispatchDropConnection
	- AdminInstallationDispatchRegisterDevice
	- AdminInstallationListActive
	- AdminJobAbandon

## 2023-08-29 v2.13.0

- Based on Comet 23.8.0
- Improve documentation of JobStatus constants

## 2023-08-09 v2.12.0

- Based on Comet 23.6.9
- Added WebDAV `DestinationLocation`

## 2023-08-02 v2.11.0

- Based on Comet 23.6.9
- Support new API endpoints for managing external admin authentication sources
- Support Object Lock policy option
- Update docstrings for various types and fields

## 2023-07-11 v2.10.0

- Based on Comet 23.6.5
- Support `DeviceConfig->ClientVersion`
- Support new `OSInfo` and `RestoreJobAdvancedOptions` fields
- Support new `SourceConfig` fields for tracking policy-enforced Protected Items
- Support new optional parameters in `AdminDispatcherRunRestoreCustom` API
- Add many more documentation comments, including behaviour of base64 byte arrays

## 2023-06-01 v2.9.0

- Based on Comet 23.5.0
- Add new `StreamableEventType` constants (`SEVT_*`) used for tracking Comet Server config changes
- Add new `StreamerType` constants (`STREAMER_TYPE_*`)
- Add new `FileOptions` type for configuring the Comet Server to log live events to a file
- Add new field `AuditFileOptions` to the `Organization` type for configuring per-tenant audit log options
- Add `Actor` (authenticated user), `ResourceID`, `Timestamp` and `TypeString` fields to the `StreamableEvent` type
- Deprecate the `UserProfileFragment` type
- Add extra comments to many types

## 2023-05-05 v2.8.0

- Based on Comet 23.3.7
- No functional changes
- Add significantly many more comments to constants, fields and types

## 2023-04-24 v2.7.0

- Based on Comet 23.3.5
- Support new `AdminDispatcherSearchSnapshots` API to remotely search for files in a Storage Vault
- Support new `AdminMetaRemoteStorageVaultTest` API to test connections for a Storage Template
- Support new `AccentColor` and `BrandingStyleType` branding options for the Comet Server web interface
- New Self-Backup option to include server logs
- Track creation and modification timestamps for `GroupPolicy` objects

## 2023-03-23 v2.6.0

- Based on Comet 23.3.1
- Support filter parameters on `AdminGetJobLogEntries`
- Support S3 Object Lock
- Support Azure Key Vault codesigning

## 2023-02-15 v2.5.0
- Based on 22.12.8
- Add `TimeSpan` option to `EmailReportOptions`
- Add `AlertsDisabled` (default: false) toggle for `PSAConfig` objects
- Add `LastSuspended` for tracking `UserProfileConfig` suspensions
- Improve documentation

## 2023-01-11 v2.4.0
- Based on 22.12.2
- Add new `AdminCountJobsForCustomSearchRequest` API to count total number of jobs for a given search query
- Add new `AdminMetaEmailOptionsGetRequest` / `AdminMetaEmailOptionsSetRequest` / `AdminMetaSendTestReportRequest` APIs for managing tenant email settings
- Add new O365 Protected Accounts quota option in the `UserProfileConfig`
- Add new tenant admin permission `AllowEditEmailOptions`

## 2022-12-09 v2.3.0
- Based on 22.11.1
- Support getCode() on exceptions to retrieve internal error code
- New features for PSAs, remote URLs and MS SQL Server restores.
- New features for exporting a self backup for single tenant.

## 2022-09-08 v2.2.0
- Based on 22.9.0
- Add Storj.io support as a Storage Vault Location and Storage Template provider
- Add Constellation role support for Tenants
- Add Webhook edit option for Tenant admins
- Add MySQL direct RestoreType
- Improve Office365 credentials handling

## 2022-07-27 v2.1.0
- Based on 22.6.7
- Add support enforcing the `RandomDelaySecs` for both whole-server and in policies
- Add support for username filter parameter in `AdminDispatcherListActive`
- Add custom region parameters for S3-compatible storage
- Add IDrive e2 as a Storage Template provider and in Constellation, including access-key cleanup
- Add `OverwriteIfNewer` to `RestoreJobAdvancedOptions`
- Add Office365 User Principal names

## 2022-06-28 v2.0.0
- Based on 22.6.2
- **BREAKING:** The `Organization.Email` class member is now declared as `EmailOptions` type instead of `AdminEmailOptions`. This change is fully backward-compatible on the HTTP/JSON level, but may cause issues if your application code checked this type explicitly
- **BREAKING:** The `AdminOrganizationDeleteRequest` API's response type has changed to be `APIResponseMessage`, not `OrganizationResponse`. The Comet Server API had only ever filled in the `APIResponseMessage`-compatible fields of the `OrganizationResponse` structure, so the HTTP/JSON response is unchanged, but this may cause issues if your application code checked this type explicitly
- Move `frozen_string_literal` declaration to the top line of all `*.rb` files
- "Requestable" Storage Vaults have been renamed to "Storage Templates". The API endpoint is unchanged, so this is backward-compatible with older Comet Server instances
- Document all `ServerConfigOptions` types for the `AdminMetaServerConfigSet` and `AdminMetaServerConfigGet` APIs
- Add new `FallbackServers` option for LDAP external authentication sources
- Add new `RandomDelaySecs` option for job schedules

## 2022-06-03 v1.15.0
- Based on 22.5.0
- Add `COMPRESS_*` compression settings for Self-Backups
- Add `RESTOREARCHIVEFORMAT_TARZSTD` for using the tar.zst archive restore format
- Add `target_organization` parameter to support cross-tenant operations in some API methods

## 2022-05-25 v1.14.0
- Based on 22.3.7
- Add new `REMOTESERVER_S3_GENERIC` `RemoteServerType`
- Add new `S3GenericVirtualStorageRole` support to the `RemoteServerAddress`

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
