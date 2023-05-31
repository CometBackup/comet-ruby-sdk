# frozen_string_literal: true

# Copyright (c) 2020-2023 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require_relative 'comet/api_response_error'
require_relative 'comet/comet_server'
require_relative 'comet/definitions'
require_relative 'comet/models/add_bucket_response_message'
require_relative 'comet/models/admin_account_properties_response'
require_relative 'comet/models/admin_email_options'
require_relative 'comet/models/admin_resource_response'
require_relative 'comet/models/admin_security_options'
require_relative 'comet/models/admin_u2fregistration'
require_relative 'comet/models/admin_user_permissions'
require_relative 'comet/models/admin_web_authn_registration'
require_relative 'comet/models/allowed_admin_user'
require_relative 'comet/models/amazon_awsvirtual_storage_role_settings'
require_relative 'comet/models/authentication_role_options'
require_relative 'comet/models/available_download'
require_relative 'comet/models/azure_destination_location'
require_relative 'comet/models/b2destination_location'
require_relative 'comet/models/b2storage_extra_info'
require_relative 'comet/models/b2transaction_totals'
require_relative 'comet/models/b2virtual_storage_role_settings'
require_relative 'comet/models/backup_job_advanced_options'
require_relative 'comet/models/backup_job_detail'
require_relative 'comet/models/backup_job_progress'
require_relative 'comet/models/backup_rule_config'
require_relative 'comet/models/backup_rule_event_triggers'
require_relative 'comet/models/branding_options'
require_relative 'comet/models/branding_properties'
require_relative 'comet/models/browse_disk_drives_response'
require_relative 'comet/models/browse_edbresponse'
require_relative 'comet/models/browse_hvresponse'
require_relative 'comet/models/browse_office_365list_virtual_accounts_response'
require_relative 'comet/models/browse_office_365objects_response'
require_relative 'comet/models/browse_sqlserver_response'
require_relative 'comet/models/browse_vssresponse'
require_relative 'comet/models/bucket_properties'
require_relative 'comet/models/bucket_usage_info'
require_relative 'comet/models/comet_apiresponse_message'
require_relative 'comet/models/comet_destination_location'
require_relative 'comet/models/constellation_check_report'
require_relative 'comet/models/constellation_role_options'
require_relative 'comet/models/constellation_stats'
require_relative 'comet/models/constellation_status_apiresponse'
require_relative 'comet/models/content_measurement'
require_relative 'comet/models/content_measurement_component'
require_relative 'comet/models/count_jobs_response'
require_relative 'comet/models/create_group_policy_response'
require_relative 'comet/models/custom_remote_bucket_settings'
require_relative 'comet/models/days_of_week_config'
require_relative 'comet/models/default_email_report_policy'
require_relative 'comet/models/default_source_with_osrestriction'
require_relative 'comet/models/destination_config'
require_relative 'comet/models/destination_location'
require_relative 'comet/models/destination_statistics'
require_relative 'comet/models/device_config'
require_relative 'comet/models/disk_drive'
require_relative 'comet/models/dispatcher_admin_sources_response'
require_relative 'comet/models/dispatcher_stored_objects_response'
require_relative 'comet/models/dispatcher_vault_snapshots_response'
require_relative 'comet/models/dispatcher_windisk_snapshot_response'
require_relative 'comet/models/edbfile_info'
require_relative 'comet/models/email_options'
require_relative 'comet/models/email_report_config'
require_relative 'comet/models/email_report_generated_preview'
require_relative 'comet/models/email_reporting_option'
require_relative 'comet/models/external_authentication_source'
require_relative 'comet/models/external_ldapauthentication_source_server'
require_relative 'comet/models/external_ldapauthentication_source_settings'
require_relative 'comet/models/extra_file_exclusion'
require_relative 'comet/models/file_option'
require_relative 'comet/models/ftpdestination_location'
require_relative 'comet/models/get_group_policy_response'
require_relative 'comet/models/get_profile_and_hash_response_message'
require_relative 'comet/models/get_profile_hash_response_message'
require_relative 'comet/models/global_override_options'
require_relative 'comet/models/group_policy'
require_relative 'comet/models/hour_sched_config'
require_relative 'comet/models/httpconnector_options'
require_relative 'comet/models/hyper_vmachine_info'
require_relative 'comet/models/install_creds'
require_relative 'comet/models/install_token'
require_relative 'comet/models/install_token_response'
require_relative 'comet/models/job_entry'
require_relative 'comet/models/license_options'
require_relative 'comet/models/live_user_connection'
require_relative 'comet/models/local_destination_location'
require_relative 'comet/models/local_storage_directory'
require_relative 'comet/models/mac_oscode_sign_properties'
require_relative 'comet/models/mongo_dbconnection'
require_relative 'comet/models/mssqlconnection'
require_relative 'comet/models/mssqllogin_args'
require_relative 'comet/models/my_sqlconnection'
require_relative 'comet/models/new_bucket_detail'
require_relative 'comet/models/news_entry'
require_relative 'comet/models/office_365connection'
require_relative 'comet/models/office_365credential'
require_relative 'comet/models/office_365custom_setting'
require_relative 'comet/models/office_365custom_setting_v2'
require_relative 'comet/models/office_365mixed_virtual_account'
require_relative 'comet/models/office_365object_info'
require_relative 'comet/models/organization'
require_relative 'comet/models/organization_login_urlresponse'
require_relative 'comet/models/organization_response'
require_relative 'comet/models/osinfo'
require_relative 'comet/models/partition'
require_relative 'comet/models/private_branding_properties'
require_relative 'comet/models/protected_item_engine_type_policy'
require_relative 'comet/models/psaconfig'
require_relative 'comet/models/public_branding_properties'
require_relative 'comet/models/ratelimit_options'
require_relative 'comet/models/ratelimit_rule'
require_relative 'comet/models/register_office_application_begin_response'
require_relative 'comet/models/register_office_application_check_response'
require_relative 'comet/models/remote_server_address'
require_relative 'comet/models/remote_storage_option'
require_relative 'comet/models/replica_server'
require_relative 'comet/models/replicator_state_apiresponse'
require_relative 'comet/models/request_storage_vault_response_message'
require_relative 'comet/models/restore_job_advanced_options'
require_relative 'comet/models/retention_policy'
require_relative 'comet/models/retention_range'
require_relative 'comet/models/s3destination_location'
require_relative 'comet/models/s3generic_virtual_storage_role'
require_relative 'comet/models/schedule_config'
require_relative 'comet/models/search_clause'
require_relative 'comet/models/search_result_file_info'
require_relative 'comet/models/search_snapshots_response'
require_relative 'comet/models/self_backup_export_options'
require_relative 'comet/models/self_backup_options'
require_relative 'comet/models/self_backup_statistics'
require_relative 'comet/models/self_backup_target'
require_relative 'comet/models/server_config_options'
require_relative 'comet/models/server_config_options_branding_fragment'
require_relative 'comet/models/server_config_options_software_build_role_fragment'
require_relative 'comet/models/server_meta_branding_properties'
require_relative 'comet/models/server_meta_version_info'
require_relative 'comet/models/session_key_regenerated_response'
require_relative 'comet/models/session_options'
require_relative 'comet/models/sftpdestination_location'
require_relative 'comet/models/single_field_source'
require_relative 'comet/models/size_measurement'
require_relative 'comet/models/software_build_role_options'
require_relative 'comet/models/software_update_news_response'
require_relative 'comet/models/source_basic_info'
require_relative 'comet/models/source_config'
require_relative 'comet/models/source_include_pattern'
require_relative 'comet/models/source_statistics'
require_relative 'comet/models/spanned_destination_location'
require_relative 'comet/models/spanned_storage_extra_info'
require_relative 'comet/models/sshconnection'
require_relative 'comet/models/stat_result'
require_relative 'comet/models/storage_free_space_info'
require_relative 'comet/models/storage_role_options'
require_relative 'comet/models/storage_vault_provider_policy'
require_relative 'comet/models/stored_object'
require_relative 'comet/models/storj_destination_location'
require_relative 'comet/models/storj_virtual_storage_role_setting'
require_relative 'comet/models/streamable_event'
require_relative 'comet/models/swift_destination_location'
require_relative 'comet/models/test_response'
require_relative 'comet/models/time_span'
require_relative 'comet/models/totp_regenerated_response'
require_relative 'comet/models/u2fregister_request'
require_relative 'comet/models/u2fregistered_key'
require_relative 'comet/models/u2fregistration_challenge_response'
require_relative 'comet/models/u2fsign_request'
require_relative 'comet/models/u2fsign_response'
require_relative 'comet/models/uninstall_config'
require_relative 'comet/models/update_campaign_device_status'
require_relative 'comet/models/update_campaign_options'
require_relative 'comet/models/update_campaign_properties'
require_relative 'comet/models/update_campaign_status'
require_relative 'comet/models/update_campaign_status_device_entry'
require_relative 'comet/models/user_custom_email_settings'
require_relative 'comet/models/user_on_server'
require_relative 'comet/models/user_policy'
require_relative 'comet/models/user_profile_config'
require_relative 'comet/models/user_profile_fragment'
require_relative 'comet/models/user_server_config'
require_relative 'comet/models/vault_snapshot'
require_relative 'comet/models/vmdksnapshot_view_options'
require_relative 'comet/models/vsscomponent'
require_relative 'comet/models/vsswriter_info'
require_relative 'comet/models/wasabi_virtual_storage_role_settings'
require_relative 'comet/models/web_authn_authenticator_selection'
require_relative 'comet/models/web_authn_credential'
require_relative 'comet/models/web_authn_credential_assertion'
require_relative 'comet/models/web_authn_credential_descriptor'
require_relative 'comet/models/web_authn_credential_entity'
require_relative 'comet/models/web_authn_credential_parameter'
require_relative 'comet/models/web_authn_public_key_credential_creation_options'
require_relative 'comet/models/web_authn_public_key_credential_request_options'
require_relative 'comet/models/web_authn_registration_challenge_response'
require_relative 'comet/models/web_authn_relying_party_entity'
require_relative 'comet/models/web_authn_sign_request'
require_relative 'comet/models/web_authn_sign_response'
require_relative 'comet/models/web_authn_user_entity'
require_relative 'comet/models/web_interface_branding_properties'
require_relative 'comet/models/webhook_option'
require_relative 'comet/models/win_smbauth'
require_relative 'comet/models/windows_code_sign_properties'
