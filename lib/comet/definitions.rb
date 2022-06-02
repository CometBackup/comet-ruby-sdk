#!/usr/bin/env ruby --enable-frozen-string-literal
#
# Copyright (c) 2020-2022 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT
#
# frozen_string_literal: true

module Comet

  # AutoRetentionLevel: The system will automatically choose how often to run an automatic Retention Pass after each backup job.
  BACKUPJOBAUTORETENTION_AUTOMATIC = 0

  # AutoRetentionLevel: The system will run a Retention Pass after every single backup job. This is more system-intensive, but is the most responsive at freeing storage space.
  BACKUPJOBAUTORETENTION_IMMEDIATE = 1

  # AutoRetentionLevel: The system will follow the automatic ruleset for a 'High Power' device.
  BACKUPJOBAUTORETENTION_MORE_OFTEN = 2

  # AutoRetentionLevel: The system will follow the automatic ruleset for a 'Low Power' device.
  BACKUPJOBAUTORETENTION_LESS_OFTEN = 3

  # JobClassification:
  JOB_CLASSIFICATION__MIN = 4000

  # JobClassification:
  JOB_CLASSIFICATION_UNKNOWN = 4000

  # JobClassification:
  JOB_CLASSIFICATION_BACKUP = 4001

  # JobClassification:
  JOB_CLASSIFICATION_RESTORE = 4002

  # JobClassification: Automatic or manual retention cleaning pass.
  JOB_CLASSIFICATION_RETENTION = 4003

  # JobClassification: Another process needed exclusive Vault access (e.g. for retention) but the process died. This task cleans up exclusive lockfiles.
  JOB_CLASSIFICATION_UNLOCK = 4004

  # JobClassification: A specific snapshot has been deleted via the Restore wizard.
  JOB_CLASSIFICATION_DELETE_CUSTOM = 4005

  # JobClassification: Explicitly re-measuring the size of a Vault (right-click > Advanced menu).
  JOB_CLASSIFICATION_REMEASURE = 4006

  # JobClassification: Software update
  JOB_CLASSIFICATION_UPDATE = 4007

  # JobClassification:
  JOB_CLASSIFICATION_IMPORT = 4008

  # JobClassification: Repair indexes
  JOB_CLASSIFICATION_REINDEX = 4009

  # JobClassification:
  JOB_CLASSIFICATION_DEEPVERIFY = 4010

  # JobClassification: Software uninstall
  JOB_CLASSIFICATION_UNINSTALL = 4011

  # JobClassification:
  JOB_CLASSIFICATION__MAX = 4999

  # JobStatus:
  JOB_STATUS_STOP_SUCCESS__MIN = 5000

  # JobStatus:
  JOB_STATUS_STOP_SUCCESS = 5000

  # JobStatus:
  JOB_STATUS_STOP_SUCCESS__MAX = 5999

  # JobStatus:
  JOB_STATUS_RUNNING__MIN = 6000

  # JobStatus: Unused
  JOB_STATUS_RUNNING_INDETERMINATE = 6000

  # JobStatus:
  JOB_STATUS_RUNNING_ACTIVE = 6001

  # JobStatus: A backup job that was marked as stopped or abandoned, but has somehow continued to run
  JOB_STATUS_RUNNING_REVIVED = 6002

  # JobStatus:
  JOB_STATUS_RUNNING__MAX = 6999

  # JobStatus:
  JOB_STATUS_FAILED__MIN = 7000

  # JobStatus:
  JOB_STATUS_FAILED_TIMEOUT = 7000

  # JobStatus:
  JOB_STATUS_FAILED_WARNING = 7001

  # JobStatus:
  JOB_STATUS_FAILED_ERROR = 7002

  # JobStatus:
  JOB_STATUS_FAILED_QUOTA = 7003

  # JobStatus:
  JOB_STATUS_FAILED_SCHEDULEMISSED = 7004

  # JobStatus:
  JOB_STATUS_FAILED_CANCELLED = 7005

  # JobStatus:
  JOB_STATUS_FAILED_SKIPALREADYRUNNING = 7006

  # JobStatus:
  JOB_STATUS_FAILED_ABANDONED = 7007

  # JobStatus:
  JOB_STATUS_FAILED__MAX = 7999

  DESTINATIONTYPE___INVALID = 0

  DESTINATIONTYPE_S3 = 1000

  DESTINATIONTYPE_SFTP = 1001

  DESTINATIONTYPE_LOCALCOPY = 1002

  DESTINATIONTYPE_COMET = 1003

  DESTINATIONTYPE_FTP = 1004

  DESTINATIONTYPE_AZUREBLOB = 1005

  DESTINATIONTYPE_SPANNED = 1006

  DESTINATIONTYPE_SWIFT = 1007

  DESTINATIONTYPE_B2 = 1008

  DESTINATIONTYPE_LATEST = 1100

  DESTINATIONTYPE_ALL = 1101

  # EmailReportType:
  EMAILREPORTTYPE_IMMEDIATE = 0

  # EmailReportType:
  EMAILREPORTTYPE_SUMMARY = 1

  # FtpsModeType:
  FTPS_MODE_PLAINTEXT = 0

  # FtpsModeType:
  FTPS_MODE_IMPLICIT = 1

  # FtpsModeType:
  FTPS_MODE_EXPLICIT = 2

  INSTALLER_METADATA_FILE = 'installer.json'

  # Severity:
  SEVERITY_INFO = 'I'

  # Severity:
  SEVERITY_WARNING = 'W'

  # Severity:
  SEVERITY_ERROR = 'E'

  MONGODB_DEFAULT_PORT = 27_017

  SERVICE_CALENDAR = 1

  SERVICE_CONTACT = 2

  SERVICE_MAIL = 4

  SERVICE_SHAREPOINT = 8

  SERVICE_ONEDRIVE = 16

  MIXED_VIRTUAL_ACCOUNT_TYPE_USER = 1

  MIXED_VIRTUAL_ACCOUNT_TYPE_GROUP = 2

  MIXED_VIRTUAL_ACCOUNT_TYPE_TEAM_GROUP = 3

  MIXED_VIRTUAL_ACCOUNT_TYPE_SHAREPOINT_ONLY = 4

  # RestoreType:
  RESTORETYPE_INVALID = -1

  # RestoreType:
  RESTORETYPE_FILE = 0

  # RestoreType:
  RESTORETYPE_NULL = 1

  # RestoreType:
  RESTORETYPE_PROCESS_PERFILE = 2

  # RestoreType:
  RESTORETYPE_PROCESS_ARCHIVE = 3

  # RestoreType:
  RESTORETYPE_WINDISK = 4

  # RestoreType:
  RESTORETYPE_FILE_ARCHIVE = 5

  # RestoreType:
  RESTORETYPE_OFFICE365_CLOUD = 6

  # RestoreType:
  RESTORETYPE_VMDK_FILE = 7

  # RestoreType:
  RESTORETYPE_VMDK_FILE_NULL = 8

  # RestoreType:
  RESTORETYPE_VMDK_FILE_ARCHIVE = 9

  # RestoreType: RESTORETYPE_PROCESS_ARCHIVE
  RESTORETYPE_PROCESS_TARBALL = 3

  # RestoreArchiveFormat:
  RESTOREARCHIVEFORMAT_TAR = 0

  # RestoreArchiveFormat:
  RESTOREARCHIVEFORMAT_TARGZ = 1

  # RestoreArchiveFormat:
  RESTOREARCHIVEFORMAT_ZIP = 2

  # RestoreArchiveFormat: SquashFS container
  RESTOREARCHIVEFORMAT_SQFS = 3

  # RestoreArchiveFormat:
  RESTOREARCHIVEFORMAT_TARZSTD = 4

  # RetentionMode: If this mode is set in a RetentionPolicy, then RetentionPolicy.Ranges should be ignored.
  RETENTIONMODE_KEEP_EVERYTHING = 801

  # RetentionMode: Delete everything except for jobs matching the ranges in RetentionPolicy.Ranges.
  RETENTIONMODE_DELETE_EXCEPT = 802

  # RetentionRangeType:
  RETENTIONRANGE__LOWEST = 900

  # RetentionRangeType: Uses Jobs
  RETENTIONRANGE_MOST_RECENT_X_JOBS = 900

  # RetentionRangeType: Uses Timestamp
  RETENTIONRANGE_NEWER_THAN_X = 901

  # RetentionRangeType: Uses Days, Weeks, Months
  RETENTIONRANGE_JOBS_SINCE = 902

  # RetentionRangeType: Uses Days
  RETENTIONRANGE_FIRST_JOB_FOR_EACH_LAST_X_DAYS = 903

  # RetentionRangeType: Removed
  RETENTIONRANGE__RESERVED904 = 904

  # RetentionRangeType: Uses Months, MonthOffset
  RETENTIONRANGE_FIRST_JOB_FOR_LAST_X_MONTHS = 905

  # RetentionRangeType: Uses Weeks, WeekOffset
  RETENTIONRANGE_FIRST_JOB_FOR_LAST_X_WEEKS = 906

  # RetentionRangeType: Uses Jobs
  RETENTIONRANGE_LAST_X_BACKUPS_ONE_FOR_EACH_DAY = 907

  # RetentionRangeType: Uses Jobs
  RETENTIONRANGE_LAST_X_BACKUPS_ONE_FOR_EACH_WEEK = 908

  # RetentionRangeType: Uses Jobs
  RETENTIONRANGE_LAST_X_BACKUPS_ONE_FOR_EACH_MONTH = 909

  # RetentionRangeType:
  RETENTIONRANGE__HIGHEST = 909

  RETENTIONRANGE_MAXINT = 1_125_899_906_842_624

  # SftpAuthMode:
  DESTINATION_SFTP_AUTHMODE_NATIVE = 0

  # SftpAuthMode:
  DESTINATION_SFTP_AUTHMODE_PASSWORD = 1

  # SftpAuthMode:
  DESTINATION_SFTP_AUTHMODE_PRIVATEKEY = 2

  # SSHAuthMode:
  SSHCONNECTION_AUTHMODE__INVALID = 0

  # SSHAuthMode:
  SSHCONNECTION_AUTHMODE_PASSWORD = 1

  # SSHAuthMode: n.b. change values
  SSHCONNECTION_AUTHMODE_PRIVATEKEY = 2

  SCHEDULE_FREQUENCY_LOWEST = 8010

  # epoch time
  SCHEDULE_FREQUENCY_ONCEONLY = 8010

  # seconds past 00:00 local time
  SCHEDULE_FREQUENCY_DAILY = 8011

  # seconds past *:00 local time
  SCHEDULE_FREQUENCY_HOURLY = 8012

  # seconds past 00:00 Sunday, local time
  SCHEDULE_FREQUENCY_WEEKLY = 8013

  # seconds past 00:00 1st, local time
  SCHEDULE_FREQUENCY_MONTHLY = 8014

  # SecondsPast: number of seconds per period. Offset: Shunt seconds after unix epoch
  SCHEDULE_FREQUENCY_PERIODIC = 8015

  SCHEDULE_FREQUENCY_HIGHEST = 8015

  # 2^50 (1 << 50)
  SCHEDULE_MAXINT = 1_125_899_906_842_624

  ENGINE_BUILTIN_FILE = 'engine1/file'

  ENGINE_BUILTIN_STDOUT = 'engine1/stdout'

  ENGINE_BUILTIN_MYSQL = 'engine1/mysql'

  ENGINE_BUILTIN_SYSTEMSTATE = 'engine1/systemstate'

  ENGINE_BUILTIN_MSSQL = 'engine1/mssql'

  ENGINE_BUILTIN_WINDOWSSYSTEM = 'engine1/windowssystem'

  ENGINE_BUILTIN_EXCHANGEEDB = 'engine1/exchangeedb'

  ENGINE_BUILTIN_VSSWRITER = 'engine1/vsswriter'

  ENGINE_BUILTIN_HYPERV = 'engine1/hyperv'

  ENGINE_BUILTIN_WINDISK = 'engine1/windisk'

  ENGINE_BUILTIN_MONGODB = 'engine1/mongodb'

  ENGINE_BUILTIN_MSOFFICE = 'engine1/winmsofficemail'

  # MSSQLAuthMode:
  MSSQL_AUTH_WINDOWS = 'windows'

  # MSSQLAuthMode:
  MSSQL_AUTH_NATIVE = 'native'

  # MSSQLMethod:
  MSSQL_METHOD_OLEDB_NATIVE = 'OLEDB_NATIVE'

  # MSSQLMethod:
  MSSQL_METHOD_OLEDB_32 = 'OLEDB_32'

  # StoredObjectType:
  STOREDOBJECTTYPE_FILE = 'file'

  # StoredObjectType:
  STOREDOBJECTTYPE_DIRECTORY = 'dir'

  # StoredObjectType:
  STOREDOBJECTTYPE_SYMLINK = 'symlink'

  # StoredObjectType:
  STOREDOBJECTTYPE_UNIXBLOCKDEVICE = 'dev'

  # StoredObjectType:
  STOREDOBJECTTYPE_UNIXCHARDEVICE = 'chardev'

  # StoredObjectType:
  STOREDOBJECTTYPE_UNIXFIFO = 'fifo'

  # StoredObjectType:
  STOREDOBJECTTYPE_UNIXSOCKET = 'socket'

  # StoredObjectType:
  STOREDOBJECTTYPE_WINEFS = 'winefs'

  # StoredObjectType: "file"
  STOREDOBJECTTYPE_EMAILMESSAGE = 'emailmessage'

  # StoredObjectType: "dir"
  STOREDOBJECTTYPE_EMAILFOLDER = 'mailfolder'

  # StoredObjectType: "file"
  STOREDOBJECTTYPE_OFFICECONTACT = 'contact'

  # StoredObjectType: "dir"
  STOREDOBJECTTYPE_OFFICECONTACTFOLDER = 'contactfolder'

  # StoredObjectType: "file"
  STOREDOBJECTTYPE_OFFICECALENDAREVENT = 'calendarevent'

  # StoredObjectType: "dir"
  STOREDOBJECTTYPE_OFFICECALENDAR = 'calendar'

  # StoredObjectType:
  STOREDOBJECTTYPE_MSSITE = 'mssite'

  # StoredObjectType:
  STOREDOBJECTTYPE_MSSITE_TEAM = 'mssiteteam'

  # StoredObjectType:
  STOREDOBJECTTYPE_MSSITELISTENTITY = 'mssitelistentity'

  # StoredObjectType:
  STOREDOBJECTTYPE_MSSITEITEMENTITY = 'mssiteitementity'

  # StoredObjectType:
  STOREDOBJECTTYPE_MSSITELISTDRIVEENTITY = 'mssitelistdriveentity'

  # StoredObjectType:
  STOREDOBJECTTYPE_VMDK_FILE = 'vmdkfile'

  # StoredObjectType:
  STOREDOBJECTTYPE_VMDK_DIRECTORY = 'vmdkdir'

  # StoredObjectType:
  STOREDOBJECTTYPE_VMDK_WINEFS = 'vmdkwinefs'

  # StoredObjectType:
  STOREDOBJECTTYPE_VMDK_SYMLINK = 'vmdksymlink'

  # ExtraFileExclusionOSRestriction:
  OS_ANY = 0

  # ExtraFileExclusionOSRestriction:
  OS_ONLY_WINDOWS = 1

  # ExtraFileExclusionOSRestriction:
  OS_ONLY_WINDOWS_X8632 = 2

  # ExtraFileExclusionOSRestriction:
  OS_ONLY_WINDOWS_X8664 = 3

  # ExtraFileExclusionOSRestriction:
  OS_ONLY_MACOS = 4

  # ExtraFileExclusionOSRestriction:
  OS_ONLY_LINUX = 5

  # DefaultSettingMode:
  SETTING_SYSTEM_DEFAULT = 0

  # DefaultSettingMode:
  SETTING_OPTIONAL_DEFAULT_ON = 1

  # DefaultSettingMode:
  SETTING_OPTIONAL_DEFAULT_OFF = 2

  # DefaultSettingMode:
  SETTING_ENFORCED_ON = 3

  # DefaultSettingMode:
  SETTING_ENFORCED_OFF = 4

  # LanguageCode:
  DEFAULT_LANGUAGE = 'en_US'

  DEFAULT_TIMEZONE = 'UTC'

  APPLICATION_VERSION = '22.3.5'

  APPLICATION_VERSION_MAJOR = 22

  APPLICATION_VERSION_MINOR = 3

  APPLICATION_VERSION_REVISION = 5

  RELEASE_CODENAME = 'Voyager'

  ENCRYPTIONMETHOD_UNCONFIGURED = 0

  PASSWORD_FORMAT_PLAINTEXT = 0

  UNKNOWN_DEVICE_ERROR = 'ERR_UNKNOWN_DEVICE'

  TOTPREQUIRED_ERROR = 'ERR_TOTP_REQUIRED'

  UNSUPPORT_VMDK_FILE_SYSTEM = 'ERR_UNSUPPORT_VMDK_FILE_SYSTEM'

  EMAIL_WORKER_STATE_NOT_STARTED = 0

  EMAIL_WORKER_STATE_STARTED = 1

  EMAIL_WORKER_STATE_CALCULATING = 2

  EMAIL_WORKER_STATE_WAITING = 3

  EMAIL_WORKER_STATE_SENDING = 4

  # WebAuthnDeviceType:
  WEBAUTHN_DEVICE_TYPE__UNKNOWN = 0

  # WebAuthnDeviceType:
  WEBAUTHN_DEVICE_TYPE__HARDWARE_TOKEN = 1

  # WebAuthnDeviceType:
  WEBAUTHN_DEVICE_TYPE__ANDROID = 2

  # WebAuthnDeviceType:
  WEBAUTHN_DEVICE_TYPE__APPLE = 3

  # WebAuthnDeviceType:
  WEBAUTHN_DEVICE_TYPE__TPM_GENERIC = 4

  # WebAuthnDeviceType:
  WEBAUTHN_DEVICE_TYPE__TPM_WINDOWS = 5

  # WebAuthnDeviceType:
  WEBAUTHN_DEVICE_TYPE__TPM_LINUX = 6

  # UpdateStatus:
  UPDATESTATUS_NOT_SEEN = 0

  # UpdateStatus:
  UPDATESTATUS_INELIGIBLE = 1

  # UpdateStatus:
  UPDATESTATUS_PENDING = 2

  # UpdateStatus:
  UPDATESTATUS_REQUEST_MADE = 3

  # UpdateStatus: Device reconnected with bad version
  UPDATESTATUS_UPDATE_FAILED = 4

  # UpdateStatus:
  UPDATESTATUS_UPDATE_CONFIRMED = 5

  # ReplicatorState:
  REPLICATOR_STATE_NONE = 0

  # ReplicatorState:
  REPLICATOR_STATE_FILE_LIST_WORKER_STARTED = 1

  # ReplicatorState:
  REPLICATOR_STATE_FILE_LIST_SYNC_RUNNING = 2

  # ReplicatorState:
  REPLICATOR_STATE_FILE_LIST_SYNC_FINISHED = 4

  # ReplicatorState:
  REPLICATOR_STATE_WORKERS_STARTED = 8

  # ReplicatorDisplayClass:
  REPLICATOR_DISPLAYCLASS_STORAGE = 100

  # ReplicatorDisplayClass:
  REPLICATOR_DISPLAYCLASS_USER = 101

  # SearchClauseType:
  SEARCHCLAUSE_RULE = ''

  # SearchClauseType:
  SEARCHCLAUSE_AND = 'and'

  # SearchClauseType:
  SEARCHCLAUSE_OR = 'or'

  # SearchClauseType:
  SEARCHCLAUSE_NOT_AND = 'not_and'

  # SearchClauseType:
  SEARCHCLAUSE_NOT_OR = 'not_or'

  SEARCHOPERATOR_STRING_EQ = 'str_eq'

  SEARCHOPERATOR_STRING_NEQ = 'str_neq'

  SEARCHOPERATOR_STRING_CONTAINS = 'str_contains'

  SEARCHOPERATOR_STRING_NCONTAINS = 'str_ncontains'

  SEARCHOPERATOR_STRING_STARTSWITH = 'str_startswith'

  SEARCHOPERATOR_STRING_NSTARTSWITH = 'str_nstartswith'

  SEARCHOPERATOR_STRING_ENDSWITH = 'str_endswith'

  SEARCHOPERATOR_STRING_NENDSWITH = 'str_nendswith'

  SEARCHOPERATOR_STRING_EQ_CI = 'str_eq_ci'

  SEARCHOPERATOR_STRING_NEQ_CI = 'str_neq_ci'

  SEARCHOPERATOR_STRING_CONTAINS_CI = 'str_contains_ci'

  SEARCHOPERATOR_STRING_NCONTAINS_CI = 'str_ncontains_ci'

  SEARCHOPERATOR_STRING_STARTSWITH_CI = 'str_startswith_ci'

  SEARCHOPERATOR_STRING_NSTARTSWITH_CI = 'str_nstartswith_ci'

  SEARCHOPERATOR_STRING_ENDSWITH_CI = 'str_endswith_ci'

  SEARCHOPERATOR_STRING_NENDSWITH_CI = 'str_nendswith_ci'

  SEARCHOPERATOR_STRING_REGEXMATCH = 'str_regexmatch'

  SEARCHOPERATOR_STRING_NREGEXMATCH = 'str_nregexmatch'

  SEARCHOPERATOR_INT_EQ = 'int_eq'

  SEARCHOPERATOR_INT_NEQ = 'int_neq'

  SEARCHOPERATOR_INT_GT = 'int_gt'

  SEARCHOPERATOR_INT_GTE = 'int_gte'

  SEARCHOPERATOR_INT_LT = 'int_lt'

  SEARCHOPERATOR_INT_LTE = 'int_lte'

  SEARCHOPERATOR_BOOL_IS = 'bool_is'

  SEARCHOPERATOR_BOOL_NIS = 'bool_nis'

  # EmailDeliveryType:
  EMAIL_DELIVERY_NONE = ''

  # EmailDeliveryType:
  EMAIL_DELIVERY_MX_DIRECT = 'builtin'

  # EmailDeliveryType:
  EMAIL_DELIVERY_SMTP = 'smtp'

  # EmailDeliveryType:
  EMAIL_DELIVERY_SMTP_SSL = 'smtp-ssl'

  # EmailDeliveryType: Legacy alias
  EMAIL_DELIVERY_BUILTIN = EMAIL_DELIVERY_MX_DIRECT

  # RemoteServerType:
  REMOTESERVER_COMET = 'comet'

  # RemoteServerType:
  REMOTESERVER_LDAP = 'ldap'

  # RemoteServerType:
  REMOTESERVER_B2 = 'b2'

  # RemoteServerType:
  REMOTESERVER_WASABI = 'wasabi'

  # RemoteServerType:
  REMOTESERVER_CUSTOM = 'custom'

  LDAPSECURITYMETHOD_PLAIN = 'plain'

  LDAPSECURITYMETHOD_LDAPS = 'ldaps'

  LDAPSECURITYMETHOD_STARTTLS = 'starttls'

  # MacOSCodesignLevel:
  MACOSCODESIGN_LEVEL_SIGN = 0

  # MacOSCodesignLevel:
  MACOSCODESIGN_LEVEL_SIGN_NOTARISE = 1

  # MacOSCodesignLevel:
  MACOSCODESIGN_LEVEL_SIGN_NOTARISE_STAPLE = 2

  # StreamableEventType:
  SEVT__MIN = 4000

  # StreamableEventType: Event is emitted when the webhook is registered, or when the server starts up. The Data associated is ServerMetaVersionInfo
  SEVT_META_HELLO = 4000

  # StreamableEventType: Data is the profile object
  SEVT_ACCOUNT_NEW = 4100

  # StreamableEventType: Data is the username
  SEVT_ACCOUNT_REMOVED = 4101

  # StreamableEventType: Data is the profile object
  SEVT_ACCOUNT_UPDATED = 4102

  # StreamableEventType:
  SEVT_JOB_NEW = 4200

  # StreamableEventType:
  SEVT_JOB_COMPLETED = 4201

  # StreamableEventType: Data is the string bucket ref
  SEVT_BUCKET_NEW = 4300

  # StreamableEventType:
  SEVT__MAX = 4999

  OFFICE365_REGION_PUBLIC = 'GlobalPublicCloud'

  OFFICE365_REGION_CHINA = 'ChinaCloud'

  OFFICE365_REGION_GERMANY = 'GermanCloud'

  OFFICE365_REGION_US_GOVT = 'USGovtGccCloud'

  OFFICE365_REGION_US_DOD = 'USGovtGccDoDCloud'

end
