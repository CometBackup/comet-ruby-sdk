# frozen_string_literal: true

# Copyright (c) 2020-2025 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT

require 'net/http'
require 'json'

module Comet

  # The CometServer class enables making network requests to the Comet Server API.
  class CometServer

    # @type [String] The Comet Server URL
    attr_accessor :server_address

    # @type [String] Username to log in to the Comet Server API
    attr_accessor :username

    # @type [String] Password to log in to the Comet Server API
    attr_accessor :password

    # Initialize a new CometServer class instance.
    def initialize(server_address, username, password)
      raise TypeError, "'server_address' expected String, got #{server_address.class}" unless server_address.is_a? String

      raise TypeError, "'username' expected String, got #{username.class}" unless username.is_a? String

      raise TypeError, "'password' expected String, got #{password.class}" unless password.is_a? String

      @server_address = server_address
      @username = username
      @password = password

      # Ensure Comet Server URL has a trailing slash
      @server_address += '/' unless server_address.end_with?('/')
    end

    # AdminAccountProperties
    #
    # Retrieve properties about the current admin account.
    # Some key parameters are obscured, but the obscured values are safely recognised by the corresponding AdminAccountSetProperties API.
    #
    # You must supply administrator authentication credentials to use this API.
    #
    # @return [Comet::AdminAccountPropertiesResponse]
    def admin_account_properties
      body = perform_request('api/v1/admin/account/properties')
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::AdminAccountPropertiesResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminAccountRegenerateTotp
    #
    # Generate a new TOTP secret.
    # The secret is returned as a `data-uri` image of a QR code. The new secret is immediately applied to the current admin account.
    #
    # You must supply administrator authentication credentials to use this API.
    #
    # @return [Comet::TotpRegeneratedResponse]
    def admin_account_regenerate_totp
      body = perform_request('api/v1/admin/account/regenerate-totp')
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::TotpRegeneratedResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminAccountSessionRevoke
    #
    # Revoke a session key (log out).
    #
    # You must supply administrator authentication credentials to use this API.
    #
    # @return [Comet::CometAPIResponseMessage]
    def admin_account_session_revoke
      body = perform_request('api/v1/admin/account/session-revoke')
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminAccountSessionStart
    #
    # Generate a session key (log in).
    #
    # You must supply administrator authentication credentials to use this API.
    #
    # @param [String] self_address (Optional) External URL of this server
    # @return [Comet::SessionKeyRegeneratedResponse]
    def admin_account_session_start(self_address = nil)
      submit_params = {}
      if self_address.nil?
        submit_params['SelfAddress'] = @server_address
      else
        raise TypeError, "'self_address' expected String, got #{self_address.class}" unless self_address.is_a? String

        submit_params['SelfAddress'] = self_address
      end

      body = perform_request('api/v1/admin/account/session-start', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::SessionKeyRegeneratedResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminAccountSessionStartAsUser
    #
    # Generate a session key for an end-user (log in as end-user).
    #
    # You must supply administrator authentication credentials to use this API.
    #
    # @param [String] target_user Target account username
    # @return [Comet::SessionKeyRegeneratedResponse]
    def admin_account_session_start_as_user(target_user)
      submit_params = {}
      raise TypeError, "'target_user' expected String, got #{target_user.class}" unless target_user.is_a? String

      submit_params['TargetUser'] = target_user

      body = perform_request('api/v1/admin/account/session-start-as-user', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::SessionKeyRegeneratedResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminAccountSessionUpgrade
    #
    # Upgrade a session key which is pending an MFA upgrade to a full session key.
    #
    # You must supply administrator authentication credentials to use this API.
    #
    # @param [String] session_key The session key to upgrade
    # @return [Comet::CometAPIResponseMessage]
    def admin_account_session_upgrade(session_key)
      submit_params = {}
      raise TypeError, "'session_key' expected String, got #{session_key.class}" unless session_key.is_a? String

      submit_params['SessionKey'] = session_key

      body = perform_request('api/v1/admin/account/session-upgrade', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminAccountSetProperties
    #
    # Update settings for your own admin account.
    # Updating your account password requires you to supply your current password.
    # To set a new plaintext password, use a password format of 0 (PASSWORD_FORMAT_PLAINTEXT).
    # This API does not currently allow you to modify your TOTP secret.
    # In Comet 24.12.2 and later, this API can change the IPWhitelist field. Prior to this, changes to the IPWhitelist field were ignored.
    #
    # You must supply administrator authentication credentials to use this API.
    #
    # @param [Comet::AdminSecurityOptions] security Updated account properties
    # @return [Comet::CometAPIResponseMessage]
    def admin_account_set_properties(security)
      submit_params = {}
      raise TypeError, "'security' expected Comet::AdminSecurityOptions, got #{security.class}" unless security.is_a? Comet::AdminSecurityOptions

      submit_params['Security'] = security.to_json

      body = perform_request('api/v1/admin/account/set-properties', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminAccountU2fRequestRegistrationChallenge
    #
    # Register a new FIDO U2F token.
    # Browser support for U2F is ending in February 2022. WebAuthn is backwards
    # compatible with U2F keys, and Comet will automatically migrate existing U2F keys
    # to allow their use with the WebAuthn endpoints.
    #
    # You must supply administrator authentication credentials to use this API.
    #
    # @param [String] self_address External URL of this server, used as U2F AppID and Facet
    # @return [Comet::U2FRegistrationChallengeResponse]
    def admin_account_u2f_request_registration_challenge(self_address)
      submit_params = {}
      raise TypeError, "'self_address' expected String, got #{self_address.class}" unless self_address.is_a? String

      submit_params['SelfAddress'] = self_address

      body = perform_request('api/v1/admin/account/u2f/request-registration-challenge', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::U2FRegistrationChallengeResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminAccountU2fSubmitChallengeResponse
    #
    # Register a new FIDO U2F token.
    # Browser support for U2F is ending in February 2022. WebAuthn is backwards
    # compatible with U2F keys, and Comet will automatically migrate existing U2F keys
    # to allow their use with the WebAuthn endpoints.
    #
    # You must supply administrator authentication credentials to use this API.
    #
    # @param [String] u2fchallenge_id Associated value from AdminAccountU2fRequestRegistrationChallenge API
    # @param [String] u2fclient_data U2F response data supplied by hardware token
    # @param [String] u2fregistration_data U2F response data supplied by hardware token
    # @param [String] u2fversion U2F response data supplied by hardware token
    # @param [String] description (Optional) Description of the token
    # @return [Comet::CometAPIResponseMessage]
    def admin_account_u2f_submit_challenge_response(u2fchallenge_id, u2fclient_data, u2fregistration_data, u2fversion, description = nil)
      submit_params = {}
      raise TypeError, "'u2fchallenge_id' expected String, got #{u2fchallenge_id.class}" unless u2fchallenge_id.is_a? String

      submit_params['U2FChallengeID'] = u2fchallenge_id
      raise TypeError, "'u2fclient_data' expected String, got #{u2fclient_data.class}" unless u2fclient_data.is_a? String

      submit_params['U2FClientData'] = u2fclient_data
      raise TypeError, "'u2fregistration_data' expected String, got #{u2fregistration_data.class}" unless u2fregistration_data.is_a? String

      submit_params['U2FRegistrationData'] = u2fregistration_data
      raise TypeError, "'u2fversion' expected String, got #{u2fversion.class}" unless u2fversion.is_a? String

      submit_params['U2FVersion'] = u2fversion
      unless description.nil?
        raise TypeError, "'description' expected String, got #{description.class}" unless description.is_a? String

        submit_params['Description'] = description
      end

      body = perform_request('api/v1/admin/account/u2f/submit-challenge-response', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminAccountValidateTotp
    #
    # Validate the TOTP code before turning 2fa(TOTP) on.
    #
    # You must supply administrator authentication credentials to use this API.
    #
    # @param [String] totpcode Six-digit code after scanning barcode image
    # @return [Comet::CometAPIResponseMessage]
    def admin_account_validate_totp(totpcode)
      submit_params = {}
      raise TypeError, "'totpcode' expected String, got #{totpcode.class}" unless totpcode.is_a? String

      submit_params['TOTPCode'] = totpcode

      body = perform_request('api/v1/admin/account/validate-totp', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminAccountWebauthnRequestRegistrationChallenge
    #
    # Register a new FIDO2 WebAuthn token.
    #
    # You must supply administrator authentication credentials to use this API.
    #
    # @param [String] self_address External URL of this server, used as WebAuthn ID
    # @return [Comet::WebAuthnRegistrationChallengeResponse]
    def admin_account_webauthn_request_registration_challenge(self_address)
      submit_params = {}
      raise TypeError, "'self_address' expected String, got #{self_address.class}" unless self_address.is_a? String

      submit_params['SelfAddress'] = self_address

      body = perform_request('api/v1/admin/account/webauthn/request-registration-challenge', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::WebAuthnRegistrationChallengeResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminAccountWebauthnSubmitChallengeResponse
    #
    # Register a new FIDO2 WebAuthn token.
    #
    # You must supply administrator authentication credentials to use this API.
    #
    # @param [String] self_address External URL of this server, used as WebAuthn ID
    # @param [String] challenge_id Associated value from AdminAccountWebAuthnRequestRegistrationChallenge API
    # @param [String] credential JSON-encoded credential
    # @return [Comet::CometAPIResponseMessage]
    def admin_account_webauthn_submit_challenge_response(self_address, challenge_id, credential)
      submit_params = {}
      raise TypeError, "'self_address' expected String, got #{self_address.class}" unless self_address.is_a? String

      submit_params['SelfAddress'] = self_address
      raise TypeError, "'challenge_id' expected String, got #{challenge_id.class}" unless challenge_id.is_a? String

      submit_params['ChallengeID'] = challenge_id
      raise TypeError, "'credential' expected String, got #{credential.class}" unless credential.is_a? String

      submit_params['Credential'] = credential

      body = perform_request('api/v1/admin/account/webauthn/submit-challenge-response', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminAddFirstAdminUser
    #
    # Add first admin user account on new server.
    #
    # @param [String] target_user the username for this new admin
    # @param [String] target_password the password for this new admin user
    # @return [Comet::CometAPIResponseMessage]
    def admin_add_first_admin_user(target_user, target_password)
      submit_params = {}
      raise TypeError, "'target_user' expected String, got #{target_user.class}" unless target_user.is_a? String

      submit_params['TargetUser'] = target_user
      raise TypeError, "'target_password' expected String, got #{target_password.class}" unless target_password.is_a? String

      submit_params['TargetPassword'] = target_password

      body = perform_request('api/v1/admin/add-first-admin-user', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminAddUser
    #
    # Add a new user account.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_user New account username
    # @param [String] target_password New account password
    # @param [Number] store_recovery_code (Optional) If set to 1, store and keep a password recovery code for the generated user (>= 18.3.9)
    # @param [Number] require_password_change (Optional) If set to 1, require to reset password at the first login for the generated user (>= 20.3.4)
    # @param [String] target_organization (Optional) If present, create the user account on behalf of another organization. Only allowed for administrator accounts in the top-level organization. (>= 22.3.7)
    # @return [Comet::CometAPIResponseMessage]
    def admin_add_user(target_user, target_password, store_recovery_code = nil, require_password_change = nil, target_organization = nil)
      submit_params = {}
      raise TypeError, "'target_user' expected String, got #{target_user.class}" unless target_user.is_a? String

      submit_params['TargetUser'] = target_user
      raise TypeError, "'target_password' expected String, got #{target_password.class}" unless target_password.is_a? String

      submit_params['TargetPassword'] = target_password
      unless store_recovery_code.nil?
        raise TypeError, "'store_recovery_code' expected Numeric, got #{store_recovery_code.class}" unless store_recovery_code.is_a? Numeric

        submit_params['StoreRecoveryCode'] = store_recovery_code
      end
      unless require_password_change.nil?
        raise TypeError, "'require_password_change' expected Numeric, got #{require_password_change.class}" unless require_password_change.is_a? Numeric

        submit_params['RequirePasswordChange'] = require_password_change
      end
      unless target_organization.nil?
        raise TypeError, "'target_organization' expected String, got #{target_organization.class}" unless target_organization.is_a? String

        submit_params['TargetOrganization'] = target_organization
      end

      body = perform_request('api/v1/admin/add-user', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminAddUserFromProfile
    #
    # Add a new user account (with all information).
    # This allows you to create a new account and set all its properties at once (e.g. during account replication). Developers creating a signup form may find it simpler to use the AdminAddUser and AdminGetUserProfile / AdminSetUserProfile APIs separately.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_user New account username
    # @param [Comet::UserProfileConfig] profile_data New account profile
    # @param [String] target_organization (Optional) If present, create the user account on behalf of another organization. Only allowed for administrator accounts in the top-level organization. (>= 22.3.7)
    # @return [Comet::CometAPIResponseMessage]
    def admin_add_user_from_profile(target_user, profile_data, target_organization = nil)
      submit_params = {}
      raise TypeError, "'target_user' expected String, got #{target_user.class}" unless target_user.is_a? String

      submit_params['TargetUser'] = target_user
      raise TypeError, "'profile_data' expected Comet::UserProfileConfig, got #{profile_data.class}" unless profile_data.is_a? Comet::UserProfileConfig

      submit_params['ProfileData'] = profile_data.to_json
      unless target_organization.nil?
        raise TypeError, "'target_organization' expected String, got #{target_organization.class}" unless target_organization.is_a? String

        submit_params['TargetOrganization'] = target_organization
      end

      body = perform_request('api/v1/admin/add-user-from-profile', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminAdminUserDelete
    #
    # Delete an administrator.
    #
    # You must supply administrator authentication credentials to use this API.
    # Access to this API may be prevented on a per-administrator basis.
    # This API is only available for top-level administrator accounts, not for Tenant administrator accounts.
    #
    # @param [String] target_user the username of the admin to be deleted
    # @return [Comet::CometAPIResponseMessage]
    def admin_admin_user_delete(target_user)
      submit_params = {}
      raise TypeError, "'target_user' expected String, got #{target_user.class}" unless target_user.is_a? String

      submit_params['TargetUser'] = target_user

      body = perform_request('api/v1/admin/admin-user/delete', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminAdminUserList
    #
    # List administrators.
    #
    # You must supply administrator authentication credentials to use this API.
    # Access to this API may be prevented on a per-administrator basis.
    # This API is only available for top-level administrator accounts, not for Tenant administrator accounts.
    #
    # @return [Array<Comet::AllowedAdminUser>]
    def admin_admin_user_list
      body = perform_request('api/v1/admin/admin-user/list')
      json_body = JSON.parse body
      check_status json_body
      if json_body.nil?
        ret = []
      else
        ret = Array.new(json_body.length)
        json_body.each_with_index do |v, i|
          ret[i] = Comet::AllowedAdminUser.new
          ret[i].from_hash(v)
        end
      end
      ret
    end

    # AdminAdminUserNew
    #
    # Add a new administrator.
    #
    # You must supply administrator authentication credentials to use this API.
    # Access to this API may be prevented on a per-administrator basis.
    # This API is only available for top-level administrator accounts, not for Tenant administrator accounts.
    #
    # @param [String] target_user the username for this new admin
    # @param [String] target_password the password for this new admin user
    # @param [String] target_org_id (Optional) provide the organization ID for this user, it will default to the org of the authenticating user otherwise
    # @return [Comet::CometAPIResponseMessage]
    def admin_admin_user_new(target_user, target_password, target_org_id = nil)
      submit_params = {}
      raise TypeError, "'target_user' expected String, got #{target_user.class}" unless target_user.is_a? String

      submit_params['TargetUser'] = target_user
      raise TypeError, "'target_password' expected String, got #{target_password.class}" unless target_password.is_a? String

      submit_params['TargetPassword'] = target_password
      unless target_org_id.nil?
        raise TypeError, "'target_org_id' expected String, got #{target_org_id.class}" unless target_org_id.is_a? String

        submit_params['TargetOrgID'] = target_org_id
      end

      body = perform_request('api/v1/admin/admin-user/new', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminBrandingAvailablePlatforms
    #
    # List available software download platforms.
    #
    # This API requires administrator authentication credentials, unless the server is configured to allow unauthenticated software downloads.
    # This API requires the Software Build Role to be enabled.
    # This API requires the Auth Role to be enabled.
    #
    # @return [Hash{Number => Comet::AvailableDownload}]
    def admin_branding_available_platforms
      body = perform_request('api/v1/admin/branding/available-platforms')
      json_body = JSON.parse body
      check_status json_body
      ret = {}
      if json_body.nil?
        ret = {}
      else
        json_body.each do |k, v|
          ret[k] = Comet::AvailableDownload.new
          ret[k].from_hash(v)
        end
      end
      ret
    end

    # AdminBrandingGenerateClientByPlatform
    #
    # Download software.
    #
    # This API requires administrator authentication credentials, unless the server is configured to allow unauthenticated software downloads.
    # This API requires the Software Build Role to be enabled.
    # This API requires the Auth Role to be enabled.
    #
    # @param [Number] platform The selected download platform, from the AdminBrandingAvailablePlatforms API
    # @param [String] self_address (Optional) The external URL of this server, used to resolve conflicts
    # @return [String]
    def admin_branding_generate_client_by_platform(platform, self_address = nil)
      submit_params = {}
      raise TypeError, "'platform' expected Numeric, got #{platform.class}" unless platform.is_a? Numeric

      submit_params['Platform'] = platform
      if self_address.nil?
        submit_params['SelfAddress'] = @server_address
      else
        raise TypeError, "'self_address' expected String, got #{self_address.class}" unless self_address.is_a? String

        submit_params['SelfAddress'] = self_address
      end

      perform_request('api/v1/admin/branding/generate-client/by-platform', submit_params)
    end

    # AdminBrandingGenerateClientLinuxDeb
    #
    # Download software (Linux Debian Package).
    #
    # This API requires administrator authentication credentials, unless the server is configured to allow unauthenticated software downloads.
    # This API requires the Software Build Role to be enabled.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] self_address (Optional) The external URL of this server, used to resolve conflicts
    # @return [String]
    def admin_branding_generate_client_linux_deb(self_address = nil)
      submit_params = {}
      if self_address.nil?
        submit_params['SelfAddress'] = @server_address
      else
        raise TypeError, "'self_address' expected String, got #{self_address.class}" unless self_address.is_a? String

        submit_params['SelfAddress'] = self_address
      end

      perform_request('api/v1/admin/branding/generate-client/linux-deb', submit_params)
    end

    # AdminBrandingGenerateClientLinuxgeneric
    #
    # Download software (Linux Server .run).
    #
    # This API requires administrator authentication credentials, unless the server is configured to allow unauthenticated software downloads.
    # This API requires the Software Build Role to be enabled.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] self_address (Optional) The external URL of this server, used to resolve conflicts
    # @return [String]
    def admin_branding_generate_client_linuxgeneric(self_address = nil)
      submit_params = {}
      if self_address.nil?
        submit_params['SelfAddress'] = @server_address
      else
        raise TypeError, "'self_address' expected String, got #{self_address.class}" unless self_address.is_a? String

        submit_params['SelfAddress'] = self_address
      end

      perform_request('api/v1/admin/branding/generate-client/linuxgeneric', submit_params)
    end

    # AdminBrandingGenerateClientMacosArm64
    #
    # Download software (macOS arm64 pkg).
    #
    # This API requires administrator authentication credentials, unless the server is configured to allow unauthenticated software downloads.
    # This API requires the Software Build Role to be enabled.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] self_address (Optional) The external URL of this server, used to resolve conflicts
    # @return [String]
    def admin_branding_generate_client_macos_arm_64(self_address = nil)
      submit_params = {}
      if self_address.nil?
        submit_params['SelfAddress'] = @server_address
      else
        raise TypeError, "'self_address' expected String, got #{self_address.class}" unless self_address.is_a? String

        submit_params['SelfAddress'] = self_address
      end

      perform_request('api/v1/admin/branding/generate-client/macos-arm64', submit_params)
    end

    # AdminBrandingGenerateClientMacosX8664
    #
    # Download software (macOS x86_64 pkg).
    #
    # This API requires administrator authentication credentials, unless the server is configured to allow unauthenticated software downloads.
    # This API requires the Software Build Role to be enabled.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] self_address (Optional) The external URL of this server, used to resolve conflicts
    # @return [String]
    def admin_branding_generate_client_macos_x8664(self_address = nil)
      submit_params = {}
      if self_address.nil?
        submit_params['SelfAddress'] = @server_address
      else
        raise TypeError, "'self_address' expected String, got #{self_address.class}" unless self_address.is_a? String

        submit_params['SelfAddress'] = self_address
      end

      perform_request('api/v1/admin/branding/generate-client/macos-x86_64', submit_params)
    end

    # AdminBrandingGenerateClientSpkDsm6
    #
    # Download software (Synology SPK for DSM 6).
    #
    # This API requires administrator authentication credentials, unless the server is configured to allow unauthenticated software downloads.
    # This API requires the Software Build Role to be enabled.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] self_address (Optional) The external URL of this server, used to resolve conflicts
    # @return [String]
    def admin_branding_generate_client_spk_dsm_6(self_address = nil)
      submit_params = {}
      if self_address.nil?
        submit_params['SelfAddress'] = @server_address
      else
        raise TypeError, "'self_address' expected String, got #{self_address.class}" unless self_address.is_a? String

        submit_params['SelfAddress'] = self_address
      end

      perform_request('api/v1/admin/branding/generate-client/spk-dsm6', submit_params)
    end

    # AdminBrandingGenerateClientSpkDsm7
    #
    # Download software (Synology SPK for DSM 7).
    #
    # This API requires administrator authentication credentials, unless the server is configured to allow unauthenticated software downloads.
    # This API requires the Software Build Role to be enabled.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] self_address (Optional) The external URL of this server, used to resolve conflicts
    # @return [String]
    def admin_branding_generate_client_spk_dsm_7(self_address = nil)
      submit_params = {}
      if self_address.nil?
        submit_params['SelfAddress'] = @server_address
      else
        raise TypeError, "'self_address' expected String, got #{self_address.class}" unless self_address.is_a? String

        submit_params['SelfAddress'] = self_address
      end

      perform_request('api/v1/admin/branding/generate-client/spk-dsm7', submit_params)
    end

    # AdminBrandingGenerateClientTest
    #
    # Check if a software download is available.
    #
    # This API requires administrator authentication credentials, unless the server is configured to allow unauthenticated software downloads.
    # This API requires the Software Build Role to be enabled.
    # This API requires the Auth Role to be enabled.
    #
    # @param [Number] platform The selected download platform, from the AdminBrandingAvailablePlatforms API
    # @param [String] self_address (Optional) The external URL of this server, used to resolve conflicts
    # @return [Comet::CometAPIResponseMessage]
    def admin_branding_generate_client_test(platform, self_address = nil)
      submit_params = {}
      raise TypeError, "'platform' expected Numeric, got #{platform.class}" unless platform.is_a? Numeric

      submit_params['Platform'] = platform
      if self_address.nil?
        submit_params['SelfAddress'] = @server_address
      else
        raise TypeError, "'self_address' expected String, got #{self_address.class}" unless self_address.is_a? String

        submit_params['SelfAddress'] = self_address
      end

      body = perform_request('api/v1/admin/branding/generate-client/test', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminBrandingGenerateClientWindowsAnycpuExe
    #
    # Download software update (Windows AnyCPU exe).
    # The exe endpoints are not recommended for end-users, as they may not be able to provide a codesigned installer if no custom codesigning certificate is present.
    #
    # This API requires administrator authentication credentials, unless the server is configured to allow unauthenticated software downloads.
    # This API requires the Software Build Role to be enabled.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] self_address (Optional) The external URL of this server, used to resolve conflicts
    # @return [String]
    def admin_branding_generate_client_windows_anycpu_exe(self_address = nil)
      submit_params = {}
      if self_address.nil?
        submit_params['SelfAddress'] = @server_address
      else
        raise TypeError, "'self_address' expected String, got #{self_address.class}" unless self_address.is_a? String

        submit_params['SelfAddress'] = self_address
      end

      perform_request('api/v1/admin/branding/generate-client/windows-anycpu-exe', submit_params)
    end

    # AdminBrandingGenerateClientWindowsAnycpuZip
    #
    # Download software (Windows AnyCPU zip).
    # The zip endpoints are recommended for end-users, as they may be able to provide a codesigned installer even when no custom codesigning certificate is present.
    #
    # This API requires administrator authentication credentials, unless the server is configured to allow unauthenticated software downloads.
    # This API requires the Software Build Role to be enabled.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] self_address (Optional) The external URL of this server, used to resolve conflicts
    # @return [String]
    def admin_branding_generate_client_windows_anycpu_zip(self_address = nil)
      submit_params = {}
      if self_address.nil?
        submit_params['SelfAddress'] = @server_address
      else
        raise TypeError, "'self_address' expected String, got #{self_address.class}" unless self_address.is_a? String

        submit_params['SelfAddress'] = self_address
      end

      perform_request('api/v1/admin/branding/generate-client/windows-anycpu-zip', submit_params)
    end

    # AdminBrandingGenerateClientWindowsX8632Exe
    #
    # Download software update (Windows x86_32 exe).
    # The exe endpoints are not recommended for end-users, as they may not be able to provide a codesigned installer if no custom codesigning certificate is present.
    #
    # This API requires administrator authentication credentials, unless the server is configured to allow unauthenticated software downloads.
    # This API requires the Software Build Role to be enabled.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] self_address (Optional) The external URL of this server, used to resolve conflicts
    # @return [String]
    def admin_branding_generate_client_windows_x8632exe(self_address = nil)
      submit_params = {}
      if self_address.nil?
        submit_params['SelfAddress'] = @server_address
      else
        raise TypeError, "'self_address' expected String, got #{self_address.class}" unless self_address.is_a? String

        submit_params['SelfAddress'] = self_address
      end

      perform_request('api/v1/admin/branding/generate-client/windows-x86_32-exe', submit_params)
    end

    # AdminBrandingGenerateClientWindowsX8632Zip
    #
    # Download software (Windows x86_32 zip).
    # The zip endpoints are recommended for end-users, as they may be able to provide a codesigned installer even when no custom codesigning certificate is present.
    #
    # This API requires administrator authentication credentials, unless the server is configured to allow unauthenticated software downloads.
    # This API requires the Software Build Role to be enabled.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] self_address (Optional) The external URL of this server, used to resolve conflicts
    # @return [String]
    def admin_branding_generate_client_windows_x8632zip(self_address = nil)
      submit_params = {}
      if self_address.nil?
        submit_params['SelfAddress'] = @server_address
      else
        raise TypeError, "'self_address' expected String, got #{self_address.class}" unless self_address.is_a? String

        submit_params['SelfAddress'] = self_address
      end

      perform_request('api/v1/admin/branding/generate-client/windows-x86_32-zip', submit_params)
    end

    # AdminBrandingGenerateClientWindowsX8664Exe
    #
    # Download software update (Windows x86_64 exe).
    # The exe endpoints are not recommended for end-users, as they may not be able to provide a codesigned installer if no custom codesigning certificate is present.
    #
    # This API requires administrator authentication credentials, unless the server is configured to allow unauthenticated software downloads.
    # This API requires the Software Build Role to be enabled.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] self_address (Optional) The external URL of this server, used to resolve conflicts
    # @return [String]
    def admin_branding_generate_client_windows_x8664exe(self_address = nil)
      submit_params = {}
      if self_address.nil?
        submit_params['SelfAddress'] = @server_address
      else
        raise TypeError, "'self_address' expected String, got #{self_address.class}" unless self_address.is_a? String

        submit_params['SelfAddress'] = self_address
      end

      perform_request('api/v1/admin/branding/generate-client/windows-x86_64-exe', submit_params)
    end

    # AdminBrandingGenerateClientWindowsX8664Zip
    #
    # Download software (Windows x86_64 zip).
    # The zip endpoints are recommended for end-users, as they may be able to provide a codesigned installer even when no custom codesigning certificate is present.
    #
    # This API requires administrator authentication credentials, unless the server is configured to allow unauthenticated software downloads.
    # This API requires the Software Build Role to be enabled.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] self_address (Optional) The external URL of this server, used to resolve conflicts
    # @return [String]
    def admin_branding_generate_client_windows_x8664zip(self_address = nil)
      submit_params = {}
      if self_address.nil?
        submit_params['SelfAddress'] = @server_address
      else
        raise TypeError, "'self_address' expected String, got #{self_address.class}" unless self_address.is_a? String

        submit_params['SelfAddress'] = self_address
      end

      perform_request('api/v1/admin/branding/generate-client/windows-x86_64-zip', submit_params)
    end

    # AdminBulletinSubmit
    #
    # Send an email bulletin to all users.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] subject Bulletin subject line
    # @param [String] content Bulletin message content
    # @return [Comet::CometAPIResponseMessage]
    def admin_bulletin_submit(subject, content)
      submit_params = {}
      raise TypeError, "'subject' expected String, got #{subject.class}" unless subject.is_a? String

      submit_params['Subject'] = subject
      raise TypeError, "'content' expected String, got #{content.class}" unless content.is_a? String

      submit_params['Content'] = content

      body = perform_request('api/v1/admin/bulletin/submit', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminConstellationLastReport
    #
    # Get Constellation bucket usage report (cached).
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Constellation Role to be enabled.
    #
    # @return [Comet::ConstellationCheckReport]
    def admin_constellation_last_report
      body = perform_request('api/v1/admin/constellation/last-report')
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::ConstellationCheckReport.new
      ret.from_hash(json_body)
      ret
    end

    # AdminConstellationNewReport
    #
    # Get Constellation bucket usage report (regenerate).
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Constellation Role to be enabled.
    #
    # @return [Comet::ConstellationCheckReport]
    def admin_constellation_new_report
      body = perform_request('api/v1/admin/constellation/new-report')
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::ConstellationCheckReport.new
      ret.from_hash(json_body)
      ret
    end

    # AdminConstellationPruneNow
    #
    # Prune unused buckets.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API is only available for top-level administrator accounts, not for Tenant administrator accounts.
    # This API requires the Constellation Role to be enabled.
    #
    # @return [Comet::CometAPIResponseMessage]
    def admin_constellation_prune_now
      body = perform_request('api/v1/admin/constellation/prune-now')
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminConstellationStatus
    #
    # Get Constellation status.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Constellation Role to be enabled.
    #
    # @return [Comet::ConstellationStatusAPIResponse]
    def admin_constellation_status
      body = perform_request('api/v1/admin/constellation/status')
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::ConstellationStatusAPIResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminConvertStorageRole
    #
    # Convert IAM Storage Role vault to its underlying S3 type.
    #
    # You must supply administrator authentication credentials to use this API.
    #
    # @param [String] target_user The user to receive the new Storage Vault
    # @param [String] destination_id The id of the old storage role destination to convert
    # @return [Comet::RequestStorageVaultResponseMessage]
    def admin_convert_storage_role(target_user, destination_id)
      submit_params = {}
      raise TypeError, "'target_user' expected String, got #{target_user.class}" unless target_user.is_a? String

      submit_params['TargetUser'] = target_user
      raise TypeError, "'destination_id' expected String, got #{destination_id.class}" unless destination_id.is_a? String

      submit_params['DestinationId'] = destination_id

      body = perform_request('api/v1/admin/convert-storage-role', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::RequestStorageVaultResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminCountJobsForCustomSearch
    #
    # Count jobs (for custom search).
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [Comet::SearchClause] query (No description available)
    # @return [Comet::CountJobsResponse]
    def admin_count_jobs_for_custom_search(query)
      submit_params = {}
      raise TypeError, "'query' expected Comet::SearchClause, got #{query.class}" unless query.is_a? Comet::SearchClause

      submit_params['Query'] = query.to_json

      body = perform_request('api/v1/admin/count-jobs-for-custom-search', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CountJobsResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminCreateInstallToken
    #
    # Create token for silent installation.
    # Currently only supported for Windows & macOS only
    # Provide the installation token to silently install the client on windows `install.exe /TOKEN=<installtoken>`
    # Provide the installation token to silently install the client on Mac OS `sudo launchctl setenv BACKUP_APP_TOKEN "installtoken" && sudo /usr/sbin/installer -allowUntrusted -pkg "Comet Backup.pkg" -target /`
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_user Selected account username
    # @param [String] target_password Selected account password
    # @param [String] server (Optional) External URL of the authentication server that is different from the current server
    # @return [Comet::InstallTokenResponse]
    def admin_create_install_token(target_user, target_password, server = nil)
      submit_params = {}
      raise TypeError, "'target_user' expected String, got #{target_user.class}" unless target_user.is_a? String

      submit_params['TargetUser'] = target_user
      raise TypeError, "'target_password' expected String, got #{target_password.class}" unless target_password.is_a? String

      submit_params['TargetPassword'] = target_password
      unless server.nil?
        raise TypeError, "'server' expected String, got #{server.class}" unless server.is_a? String

        submit_params['Server'] = server
      end

      body = perform_request('api/v1/admin/create-install-token', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::InstallTokenResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDeleteProtectedItem
    #
    # Delete a Protected Item.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_user Selected account username
    # @param [String] source_id Selected Protected Item GUID
    # @return [Comet::CometAPIResponseMessage]
    def admin_delete_protected_item(target_user, source_id)
      submit_params = {}
      raise TypeError, "'target_user' expected String, got #{target_user.class}" unless target_user.is_a? String

      submit_params['TargetUser'] = target_user
      raise TypeError, "'source_id' expected String, got #{source_id.class}" unless source_id.is_a? String

      submit_params['SourceID'] = source_id

      body = perform_request('api/v1/admin/delete-protected-item', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDeleteUser
    #
    # Delete user account.
    # This does not remove any storage buckets. Unused storage buckets will be cleaned up by the Constellation Role.
    # Any stored data can not be decrypted without the user profile. Misuse can cause data loss!
    # This also allows to uninstall software from active devices under the user account
    # This also removes all job history for the user account.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_user Selected account username
    # @param [Comet::UninstallConfig] uninstall_config (Optional) Uninstall software configuration (>= 20.3.5)
    # @return [Comet::CometAPIResponseMessage]
    def admin_delete_user(target_user, uninstall_config = nil)
      submit_params = {}
      raise TypeError, "'target_user' expected String, got #{target_user.class}" unless target_user.is_a? String

      submit_params['TargetUser'] = target_user
      unless uninstall_config.nil?
        raise TypeError, "'uninstall_config' expected Comet::UninstallConfig, got #{uninstall_config.class}" unless uninstall_config.is_a? Comet::UninstallConfig

        submit_params['UninstallConfig'] = uninstall_config.to_json
      end

      body = perform_request('api/v1/admin/delete-user', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDisableUserTotp
    #
    # Disable user account 2FA(TOTP) authentication.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_user Selected account username
    # @return [Comet::CometAPIResponseMessage]
    def admin_disable_user_totp(target_user)
      submit_params = {}
      raise TypeError, "'target_user' expected String, got #{target_user.class}" unless target_user.is_a? String

      submit_params['TargetUser'] = target_user

      body = perform_request('api/v1/admin/disable-user-totp', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherApplyRetentionRules
    #
    # Instruct a live connected device to apply retention rules now.
    # This command is understood by Comet Backup 17.6.9 and newer.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [String] destination The Storage Vault GUID
    # @return [Comet::CometAPIResponseMessage]
    def admin_dispatcher_apply_retention_rules(target_id, destination)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'destination' expected String, got #{destination.class}" unless destination.is_a? String

      submit_params['Destination'] = destination

      body = perform_request('api/v1/admin/dispatcher/apply-retention-rules', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherBrowseVirtualMachines
    #
    # Browse virtual machines in target snapshot.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [String] destination_id The Storage Vault GUID
    # @param [String] snapshot_id Snapshot to search
    # @return [Comet::DispatcherListSnapshotVirtualMachinesResponse]
    def admin_dispatcher_browse_virtual_machines(target_id, destination_id, snapshot_id)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'destination_id' expected String, got #{destination_id.class}" unless destination_id.is_a? String

      submit_params['DestinationID'] = destination_id
      raise TypeError, "'snapshot_id' expected String, got #{snapshot_id.class}" unless snapshot_id.is_a? String

      submit_params['SnapshotID'] = snapshot_id

      body = perform_request('api/v1/admin/dispatcher/browse-virtual-machines', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::DispatcherListSnapshotVirtualMachinesResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherDeepverifyStorageVault
    #
    # Instruct a live connected device to deeply verify Storage Vault content.
    # This command is understood by Comet Backup 18.8.2 and newer.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [String] destination The Storage Vault GUID
    # @return [Comet::CometAPIResponseMessage]
    def admin_dispatcher_deepverify_storage_vault(target_id, destination)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'destination' expected String, got #{destination.class}" unless destination.is_a? String

      submit_params['Destination'] = destination

      body = perform_request('api/v1/admin/dispatcher/deepverify-storage-vault', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherDeleteSnapshot
    #
    # Instruct a live connected device to delete a stored snapshot.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [String] destination_id The Storage Vault GUID
    # @param [String] snapshot_id The backup job snapshot ID to delete
    # @return [Comet::CometAPIResponseMessage]
    def admin_dispatcher_delete_snapshot(target_id, destination_id, snapshot_id)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'destination_id' expected String, got #{destination_id.class}" unless destination_id.is_a? String

      submit_params['DestinationID'] = destination_id
      raise TypeError, "'snapshot_id' expected String, got #{snapshot_id.class}" unless snapshot_id.is_a? String

      submit_params['SnapshotID'] = snapshot_id

      body = perform_request('api/v1/admin/dispatcher/delete-snapshot', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherDeleteSnapshots
    #
    # Instruct a live connected device to delete multiple stored snapshots.
    # The target device must be running Comet 20.9.10 or later.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [String] destination_id The Storage Vault GUID
    # @param [Array<String>] snapshot_ids The backup job snapshot IDs to delete
    # @return [Comet::CometAPIResponseMessage]
    def admin_dispatcher_delete_snapshots(target_id, destination_id, snapshot_ids)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'destination_id' expected String, got #{destination_id.class}" unless destination_id.is_a? String

      submit_params['DestinationID'] = destination_id
      raise TypeError, "'snapshot_ids' expected Array, got #{snapshot_ids.class}" unless snapshot_ids.is_a? Array

      submit_params['SnapshotIDs'] = snapshot_ids.to_json

      body = perform_request('api/v1/admin/dispatcher/delete-snapshots', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherDropConnection
    #
    # Disconnect a live connected device.
    # The device will almost certainly attempt to reconnect.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @return [Comet::CometAPIResponseMessage]
    def admin_dispatcher_drop_connection(target_id)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id

      body = perform_request('api/v1/admin/dispatcher/drop-connection', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherEmailPreview
    #
    # Request HTML content of an email.
    # The remote device must have given consent for an MSP to browse their mail
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [String] snapshot where the email belongs to
    # @param [String] destination The Storage Vault ID
    # @param [String] path of the email to view
    # @return [Comet::EmailReportGeneratedPreview]
    def admin_dispatcher_email_preview(target_id, snapshot, destination, path)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'snapshot' expected String, got #{snapshot.class}" unless snapshot.is_a? String

      submit_params['Snapshot'] = snapshot
      raise TypeError, "'destination' expected String, got #{destination.class}" unless destination.is_a? String

      submit_params['Destination'] = destination
      raise TypeError, "'path' expected String, got #{path.class}" unless path.is_a? String

      submit_params['Path'] = path

      body = perform_request('api/v1/admin/dispatcher/email-preview', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::EmailReportGeneratedPreview.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherForceLogin
    #
    # Instruct a live connected device to re-enter login credentials.
    # The device will terminate its live-connection process and will not reconnect.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @return [Comet::CometAPIResponseMessage]
    def admin_dispatcher_force_login(target_id)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id

      body = perform_request('api/v1/admin/dispatcher/force-login', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherGetDefaultLoginUrl
    #
    # Get the default login URL for a tenant.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    # This API is only available for top-level administrator accounts, not for Tenant administrator accounts.
    #
    # @param [String] organization_id Target organization
    # @return [Comet::OrganizationLoginURLResponse]
    def admin_dispatcher_get_default_login_url(organization_id)
      submit_params = {}
      raise TypeError, "'organization_id' expected String, got #{organization_id.class}" unless organization_id.is_a? String

      submit_params['OrganizationID'] = organization_id

      body = perform_request('api/v1/admin/dispatcher/get-default-login-url', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::OrganizationLoginURLResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherImportApply
    #
    # Instruct a live connected device to import settings from an installed product.
    # This command is understood by Comet Backup 17.12.0 and newer.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [String] import_source_id The selected import source, as found by the AdminDispatcherRequestImportSources API
    # @return [Comet::CometAPIResponseMessage]
    def admin_dispatcher_import_apply(target_id, import_source_id)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'import_source_id' expected String, got #{import_source_id.class}" unless import_source_id.is_a? String

      submit_params['ImportSourceID'] = import_source_id

      body = perform_request('api/v1/admin/dispatcher/import-apply', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherKillProcess
    #
    # Instruct a live connected device to disconnect.
    # The device will terminate its live-connection process and will not reconnect.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @return [Comet::CometAPIResponseMessage]
    def admin_dispatcher_kill_process(target_id)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id

      body = perform_request('api/v1/admin/dispatcher/kill-process', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherListActive
    #
    # List live connected devices.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] user_name_filter (Optional) User name filter string
    # @return [Hash{String => Comet::LiveUserConnection}]
    def admin_dispatcher_list_active(user_name_filter = nil)
      submit_params = {}
      unless user_name_filter.nil?
        raise TypeError, "'user_name_filter' expected String, got #{user_name_filter.class}" unless user_name_filter.is_a? String

        submit_params['UserNameFilter'] = user_name_filter
      end

      body = perform_request('api/v1/admin/dispatcher/list-active', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = {}
      if json_body.nil?
        ret = {}
      else
        json_body.each do |k, v|
          ret[k] = Comet::LiveUserConnection.new
          ret[k].from_hash(v)
        end
      end
      ret
    end

    # AdminDispatcherOffice365ListVirtualAccounts
    #
    # Request a list of Office365 Resources (groups, sites, teams groups and users).
    # The remote device must have given consent for an MSP to browse their files.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [Comet::Office365Credential] credentials The Office365 account credential
    # @return [Comet::BrowseOffice365ListVirtualAccountsResponse]
    def admin_dispatcher_office_365list_virtual_accounts(target_id, credentials)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'credentials' expected Comet::Office365Credential, got #{credentials.class}" unless credentials.is_a? Comet::Office365Credential

      submit_params['Credentials'] = credentials.to_json

      body = perform_request('api/v1/admin/dispatcher/office365-list-virtual-accounts', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::BrowseOffice365ListVirtualAccountsResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherPingDestination
    #
    # Test the connection to the storage bucket.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [Comet::DestinationLocation] extra_data The destination location settings
    # @return [Comet::CometAPIResponseMessage]
    def admin_dispatcher_ping_destination(target_id, extra_data)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'extra_data' expected Comet::DestinationLocation, got #{extra_data.class}" unless extra_data.is_a? Comet::DestinationLocation

      submit_params['ExtraData'] = extra_data.to_json

      body = perform_request('api/v1/admin/dispatcher/ping-destination', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRefetchProfile
    #
    # Instruct a live connected device to refresh their profile.
    # This command is understood by Comet Backup 17.12.0 and newer.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @return [Comet::CometAPIResponseMessage]
    def admin_dispatcher_refetch_profile(target_id)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id

      body = perform_request('api/v1/admin/dispatcher/refetch-profile', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRegisterOfficeApplicationBegin
    #
    # Begin the process of registering a new Azure AD application that can access Office 365 for backup.
    # After calling this API, you should supply the login details to the end-user, and then begin polling the AdminDispatcherRegisterOfficeApplicationCheck with the supplied "Continuation" parameter to check on the registration process.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [String] email_address The email address of the Azure AD administrator
    # @return [Comet::RegisterOfficeApplicationBeginResponse]
    def admin_dispatcher_register_office_application_begin(target_id, email_address)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'email_address' expected String, got #{email_address.class}" unless email_address.is_a? String

      submit_params['EmailAddress'] = email_address

      body = perform_request('api/v1/admin/dispatcher/register-office-application/begin', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::RegisterOfficeApplicationBeginResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRegisterOfficeApplicationCheck
    #
    # Check the process of registering a new Azure AD application that can access Office 365 for backup.
    # You should begin the process by calling AdminDispatcherRegisterOfficeApplicationBegin and asking the end-user to complete the Azure authentication steps.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [String] continuation The ID returned from the AdminDispatcherRegisterOfficeApplicationBegin endpoint
    # @return [Comet::RegisterOfficeApplicationCheckResponse]
    def admin_dispatcher_register_office_application_check(target_id, continuation)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'continuation' expected String, got #{continuation.class}" unless continuation.is_a? String

      submit_params['Continuation'] = continuation

      body = perform_request('api/v1/admin/dispatcher/register-office-application/check', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::RegisterOfficeApplicationCheckResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherReindexStorageVault
    #
    # Instruct a live connected device to rebuild Storage Vault indexes now.
    # This command is understood by Comet Backup 18.6.9 and newer.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [String] destination The Storage Vault GUID
    # @return [Comet::CometAPIResponseMessage]
    def admin_dispatcher_reindex_storage_vault(target_id, destination)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'destination' expected String, got #{destination.class}" unless destination.is_a? String

      submit_params['Destination'] = destination

      body = perform_request('api/v1/admin/dispatcher/reindex-storage-vault', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRequestBrowseDiskDrives
    #
    # Request a list of physical disk drive information from a live connected device.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @return [Comet::BrowseDiskDrivesResponse]
    def admin_dispatcher_request_browse_disk_drives(target_id)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id

      body = perform_request('api/v1/admin/dispatcher/request-browse-disk-drives', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::BrowseDiskDrivesResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRequestBrowseExchangeEdb
    #
    # Request a list of Exchange EDB databases from a live connected device.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @return [Comet::BrowseEDBResponse]
    def admin_dispatcher_request_browse_exchange_edb(target_id)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id

      body = perform_request('api/v1/admin/dispatcher/request-browse-exchange-edb', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::BrowseEDBResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRequestBrowseHyperv
    #
    # Request a list of Hyper-V virtual machines from a live connected device.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @return [Comet::BrowseHVResponse]
    def admin_dispatcher_request_browse_hyperv(target_id)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id

      body = perform_request('api/v1/admin/dispatcher/request-browse-hyperv', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::BrowseHVResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRequestBrowseMongodb
    #
    # Request a list of tables in MongoDB database.
    # The remote device must have given consent for an MSP to browse their files.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [Comet::MongoDBConnection] credentials The Mongo database authentication settings
    # @return [Comet::BrowseSQLServerResponse]
    def admin_dispatcher_request_browse_mongodb(target_id, credentials)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'credentials' expected Comet::MongoDBConnection, got #{credentials.class}" unless credentials.is_a? Comet::MongoDBConnection

      submit_params['Credentials'] = credentials.to_json

      body = perform_request('api/v1/admin/dispatcher/request-browse-mongodb', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::BrowseSQLServerResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRequestBrowseMssql
    #
    # Request a list of tables in MSSQL database.
    # The remote device must have given consent for an MSP to browse their files.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [Comet::MSSQLConnection] credentials The MSSQL database authentication settings
    # @return [Comet::BrowseSQLServerResponse]
    def admin_dispatcher_request_browse_mssql(target_id, credentials)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'credentials' expected Comet::MSSQLConnection, got #{credentials.class}" unless credentials.is_a? Comet::MSSQLConnection

      submit_params['Credentials'] = credentials.to_json

      body = perform_request('api/v1/admin/dispatcher/request-browse-mssql', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::BrowseSQLServerResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRequestBrowseMysql
    #
    # Request a list of tables in MySQL database.
    # The remote device must have given consent for an MSP to browse their files.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [Comet::MySQLConnection] credentials The MySQL database authentication settings
    # @return [Comet::BrowseSQLServerResponse]
    def admin_dispatcher_request_browse_mysql(target_id, credentials)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'credentials' expected Comet::MySQLConnection, got #{credentials.class}" unless credentials.is_a? Comet::MySQLConnection

      submit_params['Credentials'] = credentials.to_json

      body = perform_request('api/v1/admin/dispatcher/request-browse-mysql', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::BrowseSQLServerResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRequestBrowseProxmox
    #
    # Request a list of Proxmox virtual machines and containers.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [Comet::ProxmoxConnection] credentials The Proxmox connection settings
    # @return [Comet::BrowseProxmoxResponse]
    def admin_dispatcher_request_browse_proxmox(target_id, credentials)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'credentials' expected Comet::ProxmoxConnection, got #{credentials.class}" unless credentials.is_a? Comet::ProxmoxConnection

      submit_params['Credentials'] = credentials.to_json

      body = perform_request('api/v1/admin/dispatcher/request-browse-proxmox', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::BrowseProxmoxResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRequestBrowseProxmoxNodes
    #
    # Request a list of Proxmox nodes.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [Comet::SSHConnection] credentials The SSH connection settings
    # @return [Comet::BrowseProxmoxNodesResponse]
    def admin_dispatcher_request_browse_proxmox_nodes(target_id, credentials)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'credentials' expected Comet::SSHConnection, got #{credentials.class}" unless credentials.is_a? Comet::SSHConnection

      submit_params['Credentials'] = credentials.to_json

      body = perform_request('api/v1/admin/dispatcher/request-browse-proxmox/nodes', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::BrowseProxmoxNodesResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRequestBrowseProxmoxStorage
    #
    # Request a list of configured Proxmox storage.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [Comet::SSHConnection] credentials The SSH connection settings
    # @return [Comet::BrowseProxmoxStorageResponse]
    def admin_dispatcher_request_browse_proxmox_storage(target_id, credentials)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'credentials' expected Comet::SSHConnection, got #{credentials.class}" unless credentials.is_a? Comet::SSHConnection

      submit_params['Credentials'] = credentials.to_json

      body = perform_request('api/v1/admin/dispatcher/request-browse-proxmox/storage', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::BrowseProxmoxStorageResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRequestBrowseVmware
    #
    # Request a list of VMware vSphere virtual machines.
    # The remote device must have given consent for an MSP to browse their files.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [Comet::VMwareConnection] credentials The VMware vSphere connection settings
    # @return [Comet::BrowseVMwareResponse]
    def admin_dispatcher_request_browse_vmware(target_id, credentials)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'credentials' expected Comet::VMwareConnection, got #{credentials.class}" unless credentials.is_a? Comet::VMwareConnection

      submit_params['Credentials'] = credentials.to_json

      body = perform_request('api/v1/admin/dispatcher/request-browse-vmware', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::BrowseVMwareResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRequestBrowseVmwareDatacenters
    #
    # Request a list of VMware vSphere Datacenters on a VMware vSphere connection.
    # The remote device must have given consent for an MSP to browse their files.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [Comet::VMwareConnection] credentials The VMware vSphere connection settings
    # @return [Comet::BrowseVMwareDatacentersResponse]
    def admin_dispatcher_request_browse_vmware_datacenters(target_id, credentials)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'credentials' expected Comet::VMwareConnection, got #{credentials.class}" unless credentials.is_a? Comet::VMwareConnection

      submit_params['Credentials'] = credentials.to_json

      body = perform_request('api/v1/admin/dispatcher/request-browse-vmware/datacenters', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::BrowseVMwareDatacentersResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRequestBrowseVmwareDatastores
    #
    # Request a list of VMware vSphere Datastores on a VMware vSphere connection, for a specified VMware Datacenter.
    # The remote device must have given consent for an MSP to browse their files.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [Comet::VMwareConnection] credentials The VMware vSphere connection settings
    # @param [String] filter The name of the target VMware Datacenter
    # @return [Comet::BrowseVMwareDatastoresResponse]
    def admin_dispatcher_request_browse_vmware_datastores(target_id, credentials, filter)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'credentials' expected Comet::VMwareConnection, got #{credentials.class}" unless credentials.is_a? Comet::VMwareConnection

      submit_params['Credentials'] = credentials.to_json
      raise TypeError, "'filter' expected String, got #{filter.class}" unless filter.is_a? String

      submit_params['Filter'] = filter

      body = perform_request('api/v1/admin/dispatcher/request-browse-vmware/datastores', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::BrowseVMwareDatastoresResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRequestBrowseVmwareHosts
    #
    # Request a list of VMware vSphere Hosts on a VMware vSphere connection, for a specified VMware Datacenter.
    # The remote device must have given consent for an MSP to browse their files.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [Comet::VMwareConnection] credentials The VMware vSphere connection settings
    # @param [String] filter The name of the target VMware Datacenter
    # @return [Comet::BrowseVMwareHostsResponse]
    def admin_dispatcher_request_browse_vmware_hosts(target_id, credentials, filter)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'credentials' expected Comet::VMwareConnection, got #{credentials.class}" unless credentials.is_a? Comet::VMwareConnection

      submit_params['Credentials'] = credentials.to_json
      raise TypeError, "'filter' expected String, got #{filter.class}" unless filter.is_a? String

      submit_params['Filter'] = filter

      body = perform_request('api/v1/admin/dispatcher/request-browse-vmware/hosts', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::BrowseVMwareHostsResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRequestBrowseVmwareNetworks
    #
    # Request a list of VMware vSphere Networks on a VMware vSphere connection, for a specified VMware Datacenter.
    # The remote device must have given consent for an MSP to browse their files.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [Comet::VMwareConnection] credentials The VMware vSphere connection settings
    # @param [String] filter The name of the target VMware Datacenter
    # @return [Comet::BrowseVMwareNetworksResponse]
    def admin_dispatcher_request_browse_vmware_networks(target_id, credentials, filter)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'credentials' expected Comet::VMwareConnection, got #{credentials.class}" unless credentials.is_a? Comet::VMwareConnection

      submit_params['Credentials'] = credentials.to_json
      raise TypeError, "'filter' expected String, got #{filter.class}" unless filter.is_a? String

      submit_params['Filter'] = filter

      body = perform_request('api/v1/admin/dispatcher/request-browse-vmware/networks', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::BrowseVMwareNetworksResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRequestBrowseVssAaw
    #
    # Request a list of installed VSS Writers (Application-Aware Writers) from a live connected device.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @return [Comet::BrowseVSSResponse]
    def admin_dispatcher_request_browse_vss_aaw(target_id)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id

      body = perform_request('api/v1/admin/dispatcher/request-browse-vss-aaw', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::BrowseVSSResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRequestFilesystemObjects
    #
    # Request a list of filesystem objects from a live connected device.
    # The device must have granted the administrator permission to view its filenames.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [String] path (Optional) Browse objects inside this path. If empty or not present, returns the top-level device paths
    # @return [Comet::DispatcherStoredObjectsResponse]
    def admin_dispatcher_request_filesystem_objects(target_id, path = nil)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      unless path.nil?
        raise TypeError, "'path' expected String, got #{path.class}" unless path.is_a? String

        submit_params['Path'] = path
      end

      body = perform_request('api/v1/admin/dispatcher/request-filesystem-objects', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::DispatcherStoredObjectsResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRequestImportSources
    #
    # Request a list of import sources from a live connected device.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @return [Comet::DispatcherAdminSourcesResponse]
    def admin_dispatcher_request_import_sources(target_id)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id

      body = perform_request('api/v1/admin/dispatcher/request-import-sources', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::DispatcherAdminSourcesResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRequestOffice365Accounts
    #
    # Request a list of Office365 mailbox accounts.
    # The remote device must have given consent for an MSP to browse their files.
    # This is primarily used for testing the connection to Graph API, not for actual listing
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [Comet::Office365Credential] credentials The Office365 account credential
    # @return [Comet::BrowseOffice365ObjectsResponse]
    def admin_dispatcher_request_office_365accounts(target_id, credentials)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'credentials' expected Comet::Office365Credential, got #{credentials.class}" unless credentials.is_a? Comet::Office365Credential

      submit_params['Credentials'] = credentials.to_json

      body = perform_request('api/v1/admin/dispatcher/request-office365-accounts', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::BrowseOffice365ObjectsResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRequestOffice365Sites
    #
    # Request a list of Office365 sites.
    # The remote device must have given consent for an MSP to browse their files.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [Comet::Office365Credential] credentials The Office365 account credential
    # @return [Comet::BrowseOffice365ObjectsResponse]
    def admin_dispatcher_request_office_365sites(target_id, credentials)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'credentials' expected Comet::Office365Credential, got #{credentials.class}" unless credentials.is_a? Comet::Office365Credential

      submit_params['Credentials'] = credentials.to_json

      body = perform_request('api/v1/admin/dispatcher/request-office365-sites', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::BrowseOffice365ObjectsResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRequestStoredObjects
    #
    # Request a list of stored objects inside an existing backup job.
    # The remote device must have given consent for an MSP to browse their files.
    # To service this request, the remote device must connect to the Storage Vault and load index data. There may be a small delay. If the remote device is running Comet 20.12.0 or later, the necessary index data is cached when this API is first called, for 15 minutes after the last repeated call. This can improve performance for interactively browsing an entire tree of stored objects.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [String] destination The Storage Vault ID
    # @param [String] snapshot_id The selected backup job snapshot
    # @param [String] tree_id (Optional) Browse objects inside subdirectory of backup snapshot. If it is for VMDK single file restore, it should be the disk image's subtree ID.
    # @param [Comet::VMDKSnapshotViewOptions] options (Optional) Request a list of stored objects in vmdk file
    # @return [Comet::DispatcherStoredObjectsResponse]
    def admin_dispatcher_request_stored_objects(target_id, destination, snapshot_id, tree_id = nil, options = nil)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'destination' expected String, got #{destination.class}" unless destination.is_a? String

      submit_params['Destination'] = destination
      raise TypeError, "'snapshot_id' expected String, got #{snapshot_id.class}" unless snapshot_id.is_a? String

      submit_params['SnapshotID'] = snapshot_id
      unless tree_id.nil?
        raise TypeError, "'tree_id' expected String, got #{tree_id.class}" unless tree_id.is_a? String

        submit_params['TreeID'] = tree_id
      end
      unless options.nil?
        raise TypeError, "'options' expected Comet::VMDKSnapshotViewOptions, got #{options.class}" unless options.is_a? Comet::VMDKSnapshotViewOptions

        submit_params['Options'] = options.to_json
      end

      body = perform_request('api/v1/admin/dispatcher/request-stored-objects', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::DispatcherStoredObjectsResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRequestVaultSnapshots
    #
    # Request a list of Storage Vault snapshots from a live connected device.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [String] destination The Storage Vault ID
    # @return [Comet::DispatcherVaultSnapshotsResponse]
    def admin_dispatcher_request_vault_snapshots(target_id, destination)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'destination' expected String, got #{destination.class}" unless destination.is_a? String

      submit_params['Destination'] = destination

      body = perform_request('api/v1/admin/dispatcher/request-vault-snapshots', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::DispatcherVaultSnapshotsResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRequestWindiskSnapshot
    #
    # Request a Disk Image snapshot with the windiskbrowse-style from a live connected device.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [String] destination The Storage Vault ID
    # @param [String] snapshot_id The Snapshot ID
    # @return [Comet::DispatcherWindiskSnapshotResponse]
    def admin_dispatcher_request_windisk_snapshot(target_id, destination, snapshot_id)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'destination' expected String, got #{destination.class}" unless destination.is_a? String

      submit_params['Destination'] = destination
      raise TypeError, "'snapshot_id' expected String, got #{snapshot_id.class}" unless snapshot_id.is_a? String

      submit_params['SnapshotID'] = snapshot_id

      body = perform_request('api/v1/admin/dispatcher/request-windisk-snapshot', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::DispatcherWindiskSnapshotResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRunBackup
    #
    # Instruct a live connected device to run a scheduled backup.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [String] backup_rule The schedule GUID
    # @return [Comet::DispatchWithJobIDResponse]
    def admin_dispatcher_run_backup(target_id, backup_rule)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'backup_rule' expected String, got #{backup_rule.class}" unless backup_rule.is_a? String

      submit_params['BackupRule'] = backup_rule

      body = perform_request('api/v1/admin/dispatcher/run-backup', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::DispatchWithJobIDResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRunBackupCustom
    #
    # Instruct a live connected device to run a backup.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [String] source The Protected Item GUID
    # @param [String] destination The Storage Vault GUID
    # @param [Comet::BackupJobAdvancedOptions] options (Optional) Extra job parameters (>= 19.3.6)
    # @return [Comet::DispatchWithJobIDResponse]
    def admin_dispatcher_run_backup_custom(target_id, source, destination, options = nil)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'source' expected String, got #{source.class}" unless source.is_a? String

      submit_params['Source'] = source
      raise TypeError, "'destination' expected String, got #{destination.class}" unless destination.is_a? String

      submit_params['Destination'] = destination
      unless options.nil?
        raise TypeError, "'options' expected Comet::BackupJobAdvancedOptions, got #{options.class}" unless options.is_a? Comet::BackupJobAdvancedOptions

        submit_params['Options'] = options.to_json
      end

      body = perform_request('api/v1/admin/dispatcher/run-backup-custom', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::DispatchWithJobIDResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRunRestore
    #
    # Instruct a live connected device to perform a local restore.
    # This command is understood by Comet Backup 17.9.3 and newer.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [String] path The local path to restore to
    # @param [String] source The Protected Item ID
    # @param [String] destination The Storage Vault ID
    # @param [String] snapshot (Optional) If present, restore a specific snapshot. Otherwise, restore the latest snapshot for the selected Protected Item + Storage Vault pair
    # @param [Array<String>] paths (Optional) If present, restore these paths only. Otherwise, restore all data (>= 19.3.0)
    # @return [Comet::DispatchWithJobIDResponse]
    def admin_dispatcher_run_restore(target_id, path, source, destination, snapshot = nil, paths = nil)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'path' expected String, got #{path.class}" unless path.is_a? String

      submit_params['Path'] = path
      raise TypeError, "'source' expected String, got #{source.class}" unless source.is_a? String

      submit_params['Source'] = source
      raise TypeError, "'destination' expected String, got #{destination.class}" unless destination.is_a? String

      submit_params['Destination'] = destination
      unless snapshot.nil?
        raise TypeError, "'snapshot' expected String, got #{snapshot.class}" unless snapshot.is_a? String

        submit_params['Snapshot'] = snapshot
      end
      unless paths.nil?
        raise TypeError, "'paths' expected Array, got #{paths.class}" unless paths.is_a? Array

        submit_params['Paths'] = paths.to_json
      end

      body = perform_request('api/v1/admin/dispatcher/run-restore', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::DispatchWithJobIDResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherRunRestoreCustom
    #
    # Instruct a live connected device to perform a local restore.
    # This command is understood by Comet Backup 18.6.0 and newer.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [String] source The Protected Item ID
    # @param [String] destination The Storage Vault ID
    # @param [Comet::RestoreJobAdvancedOptions] options Restore targets
    # @param [String] snapshot (Optional) If present, restore a specific snapshot. Otherwise, restore the latest snapshot for the selected Protected Item + Storage Vault pair
    # @param [Array<String>] paths (Optional) If present, restore these paths only. Otherwise, restore all data
    # @param [Number] known_file_count (Optional) The number of files to restore, if known. Supplying this means we don't need to walk the entire tree just to find the file count and will speed up the restoration process.
    # @param [Number] known_byte_count (Optional) The total size in bytes of files to restore, if known. Supplying this means we don't need to walk the entire tree just to find the total file size and will speed up the restoration process.
    # @param [Number] known_dir_count (Optional) The number of directories to restore, if known. Supplying this means we don't need to walk the entire tree just to find the number of directories and will speed up the restoration process.
    # @return [Comet::DispatchWithJobIDResponse]
    def admin_dispatcher_run_restore_custom(target_id, source, destination, options, snapshot = nil, paths = nil, known_file_count = nil, known_byte_count = nil, known_dir_count = nil)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'source' expected String, got #{source.class}" unless source.is_a? String

      submit_params['Source'] = source
      raise TypeError, "'destination' expected String, got #{destination.class}" unless destination.is_a? String

      submit_params['Destination'] = destination
      raise TypeError, "'options' expected Comet::RestoreJobAdvancedOptions, got #{options.class}" unless options.is_a? Comet::RestoreJobAdvancedOptions

      submit_params['Options'] = options.to_json
      unless snapshot.nil?
        raise TypeError, "'snapshot' expected String, got #{snapshot.class}" unless snapshot.is_a? String

        submit_params['Snapshot'] = snapshot
      end
      unless paths.nil?
        raise TypeError, "'paths' expected Array, got #{paths.class}" unless paths.is_a? Array

        submit_params['Paths'] = paths.to_json
      end
      unless known_file_count.nil?
        raise TypeError, "'known_file_count' expected Numeric, got #{known_file_count.class}" unless known_file_count.is_a? Numeric

        submit_params['KnownFileCount'] = known_file_count
      end
      unless known_byte_count.nil?
        raise TypeError, "'known_byte_count' expected Numeric, got #{known_byte_count.class}" unless known_byte_count.is_a? Numeric

        submit_params['KnownByteCount'] = known_byte_count
      end
      unless known_dir_count.nil?
        raise TypeError, "'known_dir_count' expected Numeric, got #{known_dir_count.class}" unless known_dir_count.is_a? Numeric

        submit_params['KnownDirCount'] = known_dir_count
      end

      body = perform_request('api/v1/admin/dispatcher/run-restore-custom', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::DispatchWithJobIDResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherSearchSnapshots
    #
    # Search storage vault snapshots.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [String] destination_id The Storage Vault GUID
    # @param [Array<String>] snapshot_ids Snapshots to search
    # @param [Comet::SearchClause] filter The search filter
    # @return [Comet::SearchSnapshotsResponse]
    def admin_dispatcher_search_snapshots(target_id, destination_id, snapshot_ids, filter)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'destination_id' expected String, got #{destination_id.class}" unless destination_id.is_a? String

      submit_params['DestinationID'] = destination_id
      raise TypeError, "'snapshot_ids' expected Array, got #{snapshot_ids.class}" unless snapshot_ids.is_a? Array

      submit_params['SnapshotIDs'] = snapshot_ids.to_json
      raise TypeError, "'filter' expected Comet::SearchClause, got #{filter.class}" unless filter.is_a? Comet::SearchClause

      submit_params['Filter'] = filter.to_json

      body = perform_request('api/v1/admin/dispatcher/search-snapshots', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::SearchSnapshotsResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherTestSmbAuth
    #
    # Test a set of Windows SMB credentials.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [Comet::WinSMBAuth] wsa The target credentials to test
    # @return [Comet::CometAPIResponseMessage]
    def admin_dispatcher_test_smb_auth(target_id, wsa)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'wsa' expected Comet::WinSMBAuth, got #{wsa.class}" unless wsa.is_a? Comet::WinSMBAuth

      submit_params['Wsa'] = wsa.to_json

      body = perform_request('api/v1/admin/dispatcher/test-smb-auth', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherUninstallSoftware
    #
    # Instruct a live connected device to self-uninstall the software.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [Boolean] remove_config_file Determine if the config.dat file will be deleted at the same time
    # @return [Comet::CometAPIResponseMessage]
    def admin_dispatcher_uninstall_software(target_id, remove_config_file)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      submit_params['RemoveConfigFile'] = (remove_config_file ? 1 : 0)

      body = perform_request('api/v1/admin/dispatcher/uninstall-software', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherUnlock
    #
    # Instruct a live connected device to remove lock files from a Storage Vault.
    # Misuse can cause data loss!
    # This command is understood by Comet Backup 17.9.4 and newer.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [String] destination The Storage Vault GUID
    # @param [Boolean] allow_unsafe (Optional) Allow legacy Storage Vault unlocking, which is unsafe in some cases.
    # @return [Comet::CometAPIResponseMessage]
    def admin_dispatcher_unlock(target_id, destination, allow_unsafe = nil)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'destination' expected String, got #{destination.class}" unless destination.is_a? String

      submit_params['Destination'] = destination
      unless allow_unsafe.nil?
        submit_params['AllowUnsafe'] = (allow_unsafe ? 1 : 0)
      end

      body = perform_request('api/v1/admin/dispatcher/unlock', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherUpdateLoginPassword
    #
    # Instruct a live connected device to update its login password.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [String] new_password The new password of this user
    # @return [Comet::CometAPIResponseMessage]
    def admin_dispatcher_update_login_password(target_id, new_password)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'new_password' expected String, got #{new_password.class}" unless new_password.is_a? String

      submit_params['NewPassword'] = new_password

      body = perform_request('api/v1/admin/dispatcher/update-login-password', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherUpdateLoginUrl
    #
    # Instruct a live connected device to update its login server URL.
    # The device will attempt to connect to the new Auth Role Comet Server using its current username and password. If the test connection succeeds, the device migrates its saved connection settings and live connections to the new server. If the device is not registered on the new URL, or if the credentials are incorrect, the device remains on the current Auth Role server.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [String] new_url The new external URL of this server
    # @param [Boolean] force (Optional) No checks will be done using previous URL
    # @return [Comet::CometAPIResponseMessage]
    def admin_dispatcher_update_login_url(target_id, new_url, force = nil)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      raise TypeError, "'new_url' expected String, got #{new_url.class}" unless new_url.is_a? String

      submit_params['NewURL'] = new_url
      unless force.nil?
        submit_params['Force'] = (force ? 1 : 0)
      end

      body = perform_request('api/v1/admin/dispatcher/update-login-url', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminDispatcherUpdateSoftware
    #
    # Instruct a live connected device to download a software update.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    # This API requires the Software Build Role to be enabled.
    #
    # @param [String] target_id The live connection GUID
    # @param [String] self_address (Optional) The external URL of this server, used to resolve conflicts (>= 19.3.11)
    # @return [Comet::CometAPIResponseMessage]
    def admin_dispatcher_update_software(target_id, self_address = nil)
      submit_params = {}
      raise TypeError, "'target_id' expected String, got #{target_id.class}" unless target_id.is_a? String

      submit_params['TargetID'] = target_id
      if self_address.nil?
        submit_params['SelfAddress'] = @server_address
      else
        raise TypeError, "'self_address' expected String, got #{self_address.class}" unless self_address.is_a? String

        submit_params['SelfAddress'] = self_address
      end

      body = perform_request('api/v1/admin/dispatcher/update-software', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminExternalAuthSourcesDelete
    #
    # Delete an external admin authentication source.
    #
    # You must supply administrator authentication credentials to use this API.
    #
    # @param [String] source_id (No description available)
    # @return [Comet::CometAPIResponseMessage]
    def admin_external_auth_sources_delete(source_id)
      submit_params = {}
      raise TypeError, "'source_id' expected String, got #{source_id.class}" unless source_id.is_a? String

      submit_params['SourceID'] = source_id

      body = perform_request('api/v1/admin/external-auth-sources/delete', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminExternalAuthSourcesGet
    #
    # Get a map of all external admin authentication sources.
    #
    # You must supply administrator authentication credentials to use this API.
    #
    # @return [Hash{String => Comet::ExternalAuthenticationSource}]
    def admin_external_auth_sources_get
      body = perform_request('api/v1/admin/external-auth-sources/get')
      json_body = JSON.parse body
      check_status json_body
      ret = {}
      if json_body.nil?
        ret = {}
      else
        json_body.each do |k, v|
          ret[k] = Comet::ExternalAuthenticationSource.new
          ret[k].from_hash(v)
        end
      end
      ret
    end

    # AdminExternalAuthSourcesNew
    #
    # Create an external admin authentication source.
    #
    # You must supply administrator authentication credentials to use this API.
    #
    # @param [Comet::ExternalAuthenticationSource] source (No description available)
    # @param [String] source_id (Optional) (No description available)
    # @return [Comet::ExternalAuthenticationSourceResponse]
    def admin_external_auth_sources_new(source, source_id = nil)
      submit_params = {}
      raise TypeError, "'source' expected Comet::ExternalAuthenticationSource, got #{source.class}" unless source.is_a? Comet::ExternalAuthenticationSource

      submit_params['Source'] = source.to_json
      unless source_id.nil?
        raise TypeError, "'source_id' expected String, got #{source_id.class}" unless source_id.is_a? String

        submit_params['SourceID'] = source_id
      end

      body = perform_request('api/v1/admin/external-auth-sources/new', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::ExternalAuthenticationSourceResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminExternalAuthSourcesSet
    #
    # Updates the current tenant's external admin authentication sources. This will set all.
    # sources for the tenant; none will be preserved.
    #
    # You must supply administrator authentication credentials to use this API.
    #
    # @param [Hash{String => Comet::ExternalAuthenticationSource}] sources (No description available)
    # @return [Comet::CometAPIResponseMessage]
    def admin_external_auth_sources_set(sources)
      submit_params = {}
      raise TypeError, "'sources' expected Hash, got #{sources.class}" unless sources.is_a? Hash

      submit_params['Sources'] = sources.to_json

      body = perform_request('api/v1/admin/external-auth-sources/set', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminGetJobLog
    #
    # Get the report log entries for a single job, in plaintext format.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] job_id Selected job ID
    # @return [String]
    def admin_get_job_log(job_id)
      submit_params = {}
      raise TypeError, "'job_id' expected String, got #{job_id.class}" unless job_id.is_a? String

      submit_params['JobID'] = job_id

      perform_request('api/v1/admin/get-job-log', submit_params)
    end

    # AdminGetJobLogEntries
    #
    # Get the report log entries for a single job.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] job_id Selected job ID
    # @param [String] min_severity (Optional) Return only job log entries with equal or higher severity
    # @param [String] message_contains (Optional) Return only job log entries that contain exact string
    # @return [Array<Comet::JobEntry>]
    def admin_get_job_log_entries(job_id, min_severity = nil, message_contains = nil)
      submit_params = {}
      raise TypeError, "'job_id' expected String, got #{job_id.class}" unless job_id.is_a? String

      submit_params['JobID'] = job_id
      unless min_severity.nil?
        raise TypeError, "'min_severity' expected String, got #{min_severity.class}" unless min_severity.is_a? String

        submit_params['MinSeverity'] = min_severity
      end
      unless message_contains.nil?
        raise TypeError, "'message_contains' expected String, got #{message_contains.class}" unless message_contains.is_a? String

        submit_params['MessageContains'] = message_contains
      end

      body = perform_request('api/v1/admin/get-job-log-entries', submit_params)
      json_body = JSON.parse body
      check_status json_body
      if json_body.nil?
        ret = []
      else
        ret = Array.new(json_body.length)
        json_body.each_with_index do |v, i|
          ret[i] = Comet::JobEntry.new
          ret[i].from_hash(v)
        end
      end
      ret
    end

    # AdminGetJobProperties
    #
    # Get properties of a single job.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] job_id Selected job ID
    # @return [Comet::BackupJobDetail]
    def admin_get_job_properties(job_id)
      submit_params = {}
      raise TypeError, "'job_id' expected String, got #{job_id.class}" unless job_id.is_a? String

      submit_params['JobID'] = job_id

      body = perform_request('api/v1/admin/get-job-properties', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::BackupJobDetail.new
      ret.from_hash(json_body)
      ret
    end

    # AdminGetJobsAll
    #
    # Get jobs (All).
    # The jobs are returned in an unspecified order.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @return [Array<Comet::BackupJobDetail>]
    def admin_get_jobs_all
      body = perform_request('api/v1/admin/get-jobs-all')
      json_body = JSON.parse body
      check_status json_body
      if json_body.nil?
        ret = []
      else
        ret = Array.new(json_body.length)
        json_body.each_with_index do |v, i|
          ret[i] = Comet::BackupJobDetail.new
          ret[i].from_hash(v)
        end
      end
      ret
    end

    # AdminGetJobsForCustomSearch
    #
    # Get jobs (for custom search).
    # The jobs are returned in an unspecified order.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [Comet::SearchClause] query (No description available)
    # @return [Array<Comet::BackupJobDetail>]
    def admin_get_jobs_for_custom_search(query)
      submit_params = {}
      raise TypeError, "'query' expected Comet::SearchClause, got #{query.class}" unless query.is_a? Comet::SearchClause

      submit_params['Query'] = query.to_json

      body = perform_request('api/v1/admin/get-jobs-for-custom-search', submit_params)
      json_body = JSON.parse body
      check_status json_body
      if json_body.nil?
        ret = []
      else
        ret = Array.new(json_body.length)
        json_body.each_with_index do |v, i|
          ret[i] = Comet::BackupJobDetail.new
          ret[i].from_hash(v)
        end
      end
      ret
    end

    # AdminGetJobsForDateRange
    #
    # Get jobs (for date range).
    # The jobs are returned in an unspecified order.
    #
    # If the `Start` parameter is later than `End`, they will be swapped.
    #
    # This API will return all jobs that either started or ended within the supplied range.
    #
    # Incomplete jobs have an end time of `0`. You can use this API to find only incomplete jobs by setting both `Start` and `End` to `0`.
    #
    # Prior to Comet Server 22.6.0, additional Incomplete jobs may have been returned if you specified non-zero arguments for both `Start` and `End`.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [Number] start_value Timestamp (Unix)
    # @param [Number] end_value Timestamp (Unix)
    # @return [Array<Comet::BackupJobDetail>]
    def admin_get_jobs_for_date_range(start_value, end_value)
      submit_params = {}
      raise TypeError, "'start_value' expected Numeric, got #{start_value.class}" unless start_value.is_a? Numeric

      submit_params['Start'] = start_value
      raise TypeError, "'end_value' expected Numeric, got #{end_value.class}" unless end_value.is_a? Numeric

      submit_params['End'] = end_value

      body = perform_request('api/v1/admin/get-jobs-for-date-range', submit_params)
      json_body = JSON.parse body
      check_status json_body
      if json_body.nil?
        ret = []
      else
        ret = Array.new(json_body.length)
        json_body.each_with_index do |v, i|
          ret[i] = Comet::BackupJobDetail.new
          ret[i].from_hash(v)
        end
      end
      ret
    end

    # AdminGetJobsForUser
    #
    # Get jobs (for user).
    # The jobs are returned in an unspecified order.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_user Selected username
    # @return [Array<Comet::BackupJobDetail>]
    def admin_get_jobs_for_user(target_user)
      submit_params = {}
      raise TypeError, "'target_user' expected String, got #{target_user.class}" unless target_user.is_a? String

      submit_params['TargetUser'] = target_user

      body = perform_request('api/v1/admin/get-jobs-for-user', submit_params)
      json_body = JSON.parse body
      check_status json_body
      if json_body.nil?
        ret = []
      else
        ret = Array.new(json_body.length)
        json_body.each_with_index do |v, i|
          ret[i] = Comet::BackupJobDetail.new
          ret[i].from_hash(v)
        end
      end
      ret
    end

    # AdminGetJobsRecent
    #
    # Get jobs (Recent and incomplete).
    # The jobs are returned in an unspecified order.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @return [Array<Comet::BackupJobDetail>]
    def admin_get_jobs_recent
      body = perform_request('api/v1/admin/get-jobs-recent')
      json_body = JSON.parse body
      check_status json_body
      if json_body.nil?
        ret = []
      else
        ret = Array.new(json_body.length)
        json_body.each_with_index do |v, i|
          ret[i] = Comet::BackupJobDetail.new
          ret[i].from_hash(v)
        end
      end
      ret
    end

    # AdminGetProtectedItemWithBackupRules
    #
    # Get a Protected Item with its backup rules.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_user Selected account username
    # @param [String] source_id Selected Protected Item GUID
    # @return [Comet::ProtectedItemWithBackupRulesResponse]
    def admin_get_protected_item_with_backup_rules(target_user, source_id)
      submit_params = {}
      raise TypeError, "'target_user' expected String, got #{target_user.class}" unless target_user.is_a? String

      submit_params['TargetUser'] = target_user
      raise TypeError, "'source_id' expected String, got #{source_id.class}" unless source_id.is_a? String

      submit_params['SourceID'] = source_id

      body = perform_request('api/v1/admin/get-protected-item-with-backup-rules', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::ProtectedItemWithBackupRulesResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminGetUserProfile
    #
    # Get user account profile.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_user Selected account username
    # @return [Comet::UserProfileConfig]
    def admin_get_user_profile(target_user)
      submit_params = {}
      raise TypeError, "'target_user' expected String, got #{target_user.class}" unless target_user.is_a? String

      submit_params['TargetUser'] = target_user

      body = perform_request('api/v1/admin/get-user-profile', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::UserProfileConfig.new
      ret.from_hash(json_body)
      ret
    end

    # AdminGetUserProfileAndHash
    #
    # Get user account profile (atomic).
    # The resulting hash parameter can be passed to the corresponding update API, to atomically ensure that no changes occur between get/set operations.
    # The hash format is not publicly documented and may change in a future server version. Use server APIs to retrieve current hash values.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_user Selected account username
    # @return [Comet::GetProfileAndHashResponseMessage]
    def admin_get_user_profile_and_hash(target_user)
      submit_params = {}
      raise TypeError, "'target_user' expected String, got #{target_user.class}" unless target_user.is_a? String

      submit_params['TargetUser'] = target_user

      body = perform_request('api/v1/admin/get-user-profile-and-hash', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::GetProfileAndHashResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminGetUserProfileHash
    #
    # Get user account profile (hash).
    # The profile hash can be used to determine if a user account profile has changed.
    # The hash format is not publicly documented and may change in a future server version. Use server APIs to retrieve current hash values.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_user Selected account username
    # @return [Comet::GetProfileHashResponseMessage]
    def admin_get_user_profile_hash(target_user)
      submit_params = {}
      raise TypeError, "'target_user' expected String, got #{target_user.class}" unless target_user.is_a? String

      submit_params['TargetUser'] = target_user

      body = perform_request('api/v1/admin/get-user-profile-hash', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::GetProfileHashResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminInstallationDispatchDropConnection
    #
    # Instruct a live connected device to disconnect.
    # The device will terminate its live-connection process and will not reconnect.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] device_id The live connection Device GUID
    # @return [Comet::CometAPIResponseMessage]
    def admin_installation_dispatch_drop_connection(device_id)
      submit_params = {}
      raise TypeError, "'device_id' expected String, got #{device_id.class}" unless device_id.is_a? String

      submit_params['DeviceID'] = device_id

      body = perform_request('api/v1/admin/installation/dispatch/drop-connection', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminInstallationDispatchRegisterDevice
    #
    # Instruct an unregistered device to authenticate with a given user.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] device_id The live connection Device GUID
    # @param [String] target_user Selected account username
    # @param [String] target_password Selected account password
    # @param [String] target_totpcode (Optional) Selected account TOTP code
    # @return [String]
    def admin_installation_dispatch_register_device(device_id, target_user, target_password, target_totpcode = nil)
      submit_params = {}
      raise TypeError, "'device_id' expected String, got #{device_id.class}" unless device_id.is_a? String

      submit_params['DeviceID'] = device_id
      raise TypeError, "'target_user' expected String, got #{target_user.class}" unless target_user.is_a? String

      submit_params['TargetUser'] = target_user
      raise TypeError, "'target_password' expected String, got #{target_password.class}" unless target_password.is_a? String

      submit_params['TargetPassword'] = target_password
      unless target_totpcode.nil?
        raise TypeError, "'target_totpcode' expected String, got #{target_totpcode.class}" unless target_totpcode.is_a? String

        submit_params['TargetTOTPCode'] = target_totpcode
      end

      body = perform_request('api/v1/admin/installation/dispatch/register-device', submit_params)
      json_body = JSON.parse body
      check_status json_body
      raise TypeError, "'json_body' expected String, got #{json_body.class}" unless json_body.is_a? String

      ret = json_body
      ret
    end

    # AdminInstallationListActive
    #
    # List live connected devices in lobby mode.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @return [Hash{String => Comet::RegistrationLobbyConnection}]
    def admin_installation_list_active
      body = perform_request('api/v1/admin/installation/list-active')
      json_body = JSON.parse body
      check_status json_body
      ret = {}
      if json_body.nil?
        ret = {}
      else
        json_body.each do |k, v|
          ret[k] = Comet::RegistrationLobbyConnection.new
          ret[k].from_hash(v)
        end
      end
      ret
    end

    # AdminJobAbandon
    #
    # Mark a running job as abandoned.
    # This will change the status of a running job to abandoned.
    # This is intended to be used on jobs which are definitely no longer running but are stuck in the running state; it will not attempt to cancel the job. If the job is detected to still be running after being marked as abandoned, it will be revived.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_user Username
    # @param [String] job_id Job ID
    # @return [Comet::CometAPIResponseMessage]
    def admin_job_abandon(target_user, job_id)
      submit_params = {}
      raise TypeError, "'target_user' expected String, got #{target_user.class}" unless target_user.is_a? String

      submit_params['TargetUser'] = target_user
      raise TypeError, "'job_id' expected String, got #{job_id.class}" unless job_id.is_a? String

      submit_params['JobID'] = job_id

      body = perform_request('api/v1/admin/job/abandon', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminJobCancel
    #
    # Cancel a running job.
    # A request is sent to the live-connected device, asking it to cancel the operation. This may fail if there is no live-connection.
    # Only jobs from Comet 18.3.5 or newer can be cancelled. A job can only be cancelled if it has a non-empty CancellationID field in its properties.
    # If the device is running Comet 21.9.5 or later, this API will wait up to ten seconds for a confirmation from the client.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_user Username
    # @param [String] job_id Job ID
    # @return [Comet::CometAPIResponseMessage]
    def admin_job_cancel(target_user, job_id)
      submit_params = {}
      raise TypeError, "'target_user' expected String, got #{target_user.class}" unless target_user.is_a? String

      submit_params['TargetUser'] = target_user
      raise TypeError, "'job_id' expected String, got #{job_id.class}" unless job_id.is_a? String

      submit_params['JobID'] = job_id

      body = perform_request('api/v1/admin/job/cancel', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminListUsers
    #
    # List all user accounts.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @return [Array<String>]
    def admin_list_users
      body = perform_request('api/v1/admin/list-users')
      json_body = JSON.parse body
      check_status json_body
      if json_body.nil?
        ret = []
      else
        ret = Array.new(json_body.length)
        json_body.each_with_index do |v, i|
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          ret[i] = v
        end
      end
      ret
    end

    # AdminListUsersFull
    #
    # List all user account profiles.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @return [Hash{String => Comet::UserProfileConfig}]
    def admin_list_users_full
      body = perform_request('api/v1/admin/list-users-full')
      json_body = JSON.parse body
      check_status json_body
      ret = {}
      if json_body.nil?
        ret = {}
      else
        json_body.each do |k, v|
          ret[k] = Comet::UserProfileConfig.new
          ret[k].from_hash(v)
        end
      end
      ret
    end

    # AdminMetaBrandingConfigGet
    #
    # Get Branding configuration.
    #
    # You must supply administrator authentication credentials to use this API.
    # Access to this API may be prevented on a per-administrator basis.
    #
    # @return [Comet::ServerConfigOptionsBrandingFragment]
    def admin_meta_branding_config_get
      body = perform_request('api/v1/admin/meta/branding-config/get')
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::ServerConfigOptionsBrandingFragment.new
      ret.from_hash(json_body)
      ret
    end

    # AdminMetaBrandingConfigSet
    #
    # Set Branding configuration.
    # Note that file resources must be provided using a resource URI, i.e `"resource://05ba0b90ee66bda433169581188aba8d29faa938f9464cccd651a02fdf2e5b57"`. See AdminMetaResourceNew for the API documentation to create new file resources.
    #
    # You must supply administrator authentication credentials to use this API.
    # Access to this API may be prevented on a per-administrator basis.
    #
    # @param [Comet::BrandingOptions] branding_config Updated configuration content
    # @return [Comet::CometAPIResponseMessage]
    def admin_meta_branding_config_set(branding_config)
      submit_params = {}
      raise TypeError, "'branding_config' expected Comet::BrandingOptions, got #{branding_config.class}" unless branding_config.is_a? Comet::BrandingOptions

      submit_params['BrandingConfig'] = branding_config.to_json

      body = perform_request('api/v1/admin/meta/branding-config/set', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminMetaBuildConfigGet
    #
    # Get Software Build Role configuration.
    #
    # You must supply administrator authentication credentials to use this API.
    # Access to this API may be prevented on a per-administrator basis.
    #
    # @return [Comet::ServerConfigOptionsSoftwareBuildRoleFragment]
    def admin_meta_build_config_get
      body = perform_request('api/v1/admin/meta/build-config/get')
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::ServerConfigOptionsSoftwareBuildRoleFragment.new
      ret.from_hash(json_body)
      ret
    end

    # AdminMetaBuildConfigSet
    #
    # Set Build Role configuration.
    #
    # You must supply administrator authentication credentials to use this API.
    # Access to this API may be prevented on a per-administrator basis.
    #
    # @param [Comet::SoftwareBuildRoleOptions] software_build_role_config Updated configuration content
    # @return [Comet::CometAPIResponseMessage]
    def admin_meta_build_config_set(software_build_role_config)
      submit_params = {}
      raise TypeError, "'software_build_role_config' expected Comet::SoftwareBuildRoleOptions, got #{software_build_role_config.class}" unless software_build_role_config.is_a? Comet::SoftwareBuildRoleOptions

      submit_params['SoftwareBuildRoleConfig'] = software_build_role_config.to_json

      body = perform_request('api/v1/admin/meta/build-config/set', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminMetaConstellationConfigGet
    #
    # Get Constellation configuration for the current organization.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Constellation Role to be enabled.
    #
    # @return [Comet::ConstellationRoleOptions]
    def admin_meta_constellation_config_get
      body = perform_request('api/v1/admin/meta/constellation/config/get')
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::ConstellationRoleOptions.new
      ret.from_hash(json_body)
      ret
    end

    # AdminMetaConstellationConfigSet
    #
    # Set Constellation configuration for the current organization.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Constellation Role to be enabled.
    #
    # @param [Comet::ConstellationRoleOptions] constellation_role_options Constellation role options to set
    # @return [Comet::CometAPIResponseMessage]
    def admin_meta_constellation_config_set(constellation_role_options)
      submit_params = {}
      raise TypeError, "'constellation_role_options' expected Comet::ConstellationRoleOptions, got #{constellation_role_options.class}" unless constellation_role_options.is_a? Comet::ConstellationRoleOptions

      submit_params['ConstellationRoleOptions'] = constellation_role_options.to_json

      body = perform_request('api/v1/admin/meta/constellation/config/set', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminMetaEmailOptionsGet
    #
    # Get the email options.
    #
    # You must supply administrator authentication credentials to use this API.
    # Access to this API may be prevented on a per-administrator basis.
    #
    # @return [Comet::EmailOptions]
    def admin_meta_email_options_get
      body = perform_request('api/v1/admin/meta/email-options/get')
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::EmailOptions.new
      ret.from_hash(json_body)
      ret
    end

    # AdminMetaEmailOptionsSet
    #
    # Set the email options.
    #
    # You must supply administrator authentication credentials to use this API.
    # Access to this API may be prevented on a per-administrator basis.
    #
    # @param [Comet::EmailOptions] email_options The replacement email reporting options.
    # @return [Comet::CometAPIResponseMessage]
    def admin_meta_email_options_set(email_options)
      submit_params = {}
      raise TypeError, "'email_options' expected Comet::EmailOptions, got #{email_options.class}" unless email_options.is_a? Comet::EmailOptions

      submit_params['EmailOptions'] = email_options.to_json

      body = perform_request('api/v1/admin/meta/email-options/set', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminMetaListAvailableLogDays
    #
    # Get log files.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API is only available for top-level administrator accounts, not for Tenant administrator accounts.
    #
    # @return [Array<Number>]
    def admin_meta_list_available_log_days
      body = perform_request('api/v1/admin/meta/list-available-log-days')
      json_body = JSON.parse body
      check_status json_body
      if json_body.nil?
        ret = []
      else
        ret = Array.new(json_body.length)
        json_body.each_with_index do |v, i|
          raise TypeError, "'v' expected Numeric, got #{v.class}" unless v.is_a? Numeric

          ret[i] = v
        end
      end
      ret
    end

    # AdminMetaPsaConfigListGet
    #
    # Get the server PSA configuration.
    #
    # You must supply administrator authentication credentials to use this API.
    #
    # @return [Array<Comet::PSAConfig>]
    def admin_meta_psa_config_list_get
      body = perform_request('api/v1/admin/meta/psa-config-list/get')
      json_body = JSON.parse body
      check_status json_body
      if json_body.nil?
        ret = []
      else
        ret = Array.new(json_body.length)
        json_body.each_with_index do |v, i|
          ret[i] = Comet::PSAConfig.new
          ret[i].from_hash(v)
        end
      end
      ret
    end

    # AdminMetaPsaConfigListSet
    #
    # Update the server PSA configuration.
    #
    # You must supply administrator authentication credentials to use this API.
    #
    # @param [Array<Comet::PSAConfig>] psaconfig_list The replacement PSA configuration list
    # @return [Comet::CometAPIResponseMessage]
    def admin_meta_psa_config_list_set(psaconfig_list)
      submit_params = {}
      raise TypeError, "'psaconfig_list' expected Array, got #{psaconfig_list.class}" unless psaconfig_list.is_a? Array

      submit_params['PSAConfigList'] = psaconfig_list.to_json

      body = perform_request('api/v1/admin/meta/psa-config-list/set', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminMetaPsaConfigListSyncNow
    #
    # Synchronize all PSA services now.
    # This API applies to the current Organization's PSAConfig's only.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @return [Comet::CometAPIResponseMessage]
    def admin_meta_psa_config_list_sync_now
      body = perform_request('api/v1/admin/meta/psa-config-list/sync-now')
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminMetaReadAllLogs
    #
    # Get a ZIP file of all of the server's log files.
    # On non-Windows platforms, log content uses LF line endings. On Windows, Comet changed from LF to CRLF line endings in 18.3.2.
    # This API does not automatically convert line endings; around the 18.3.2 timeframe, log content may even contain mixed line-endings.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API is only available for top-level administrator accounts, not for Tenant administrator accounts.
    #
    # @return [String]
    def admin_meta_read_all_logs
      perform_request('api/v1/admin/meta/read-all-logs')
    end

    # AdminMetaReadLogs
    #
    # Get log file content.
    # On non-Windows platforms, log content uses LF line endings. On Windows, Comet changed from LF to CRLF line endings in 18.3.2.
    # This API does not automatically convert line endings; around the 18.3.2 timeframe, log content may even contain mixed line-endings.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API is only available for top-level administrator accounts, not for Tenant administrator accounts.
    #
    # @param [Number] log A log day, selected from the options returned by the Get Log Files API
    # @return [String]
    def admin_meta_read_logs(log)
      submit_params = {}
      raise TypeError, "'log' expected Numeric, got #{log.class}" unless log.is_a? Numeric

      submit_params['Log'] = log

      perform_request('api/v1/admin/meta/read-logs', submit_params)
    end

    # AdminMetaReadSelectLogs
    #
    # Get logs file content.
    # On non-Windows platforms, log content uses LF line endings. On Windows, Comet changed from LF to CRLF line endings in 18.3.2.
    # This API does not automatically convert line endings; around the 18.3.2 timeframe, log content may even contain mixed line-endings.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API is only available for top-level administrator accounts, not for Tenant administrator accounts.
    #
    # @param [Array<Number>] logs An array of log days, selected from the options returned by the Get Log Files API
    # @return [String]
    def admin_meta_read_select_logs(logs)
      submit_params = {}
      raise TypeError, "'logs' expected Array, got #{logs.class}" unless logs.is_a? Array

      submit_params['Logs'] = logs.to_json

      perform_request('api/v1/admin/meta/read-select-logs', submit_params)
    end

    # AdminMetaRemoteStorageVaultGet
    #
    # Get Requesting Remote Storage Vault Config.
    #
    # You must supply administrator authentication credentials to use this API.
    # Access to this API may be prevented on a per-administrator basis.
    #
    # @return [Array<Comet::RemoteStorageOption>]
    def admin_meta_remote_storage_vault_get
      body = perform_request('api/v1/admin/meta/remote-storage-vault/get')
      json_body = JSON.parse body
      check_status json_body
      if json_body.nil?
        ret = []
      else
        ret = Array.new(json_body.length)
        json_body.each_with_index do |v, i|
          ret[i] = Comet::RemoteStorageOption.new
          ret[i].from_hash(v)
        end
      end
      ret
    end

    # AdminMetaRemoteStorageVaultSet
    #
    # Set Storage template vault options.
    #
    # You must supply administrator authentication credentials to use this API.
    # Access to this API may be prevented on a per-administrator basis.
    #
    # @param [Array<Comet::RemoteStorageOption>] remote_storage_options Updated configuration content
    # @param [String] replacement_auto_vault_id (Optional) Replacement Storage Template ID for auto Storage Vault configurations that use deleted Storage Templates
    # @return [Comet::CometAPIResponseMessage]
    def admin_meta_remote_storage_vault_set(remote_storage_options, replacement_auto_vault_id = nil)
      submit_params = {}
      raise TypeError, "'remote_storage_options' expected Array, got #{remote_storage_options.class}" unless remote_storage_options.is_a? Array

      submit_params['RemoteStorageOptions'] = remote_storage_options.to_json
      unless replacement_auto_vault_id.nil?
        raise TypeError, "'replacement_auto_vault_id' expected String, got #{replacement_auto_vault_id.class}" unless replacement_auto_vault_id.is_a? String

        submit_params['ReplacementAutoVaultID'] = replacement_auto_vault_id
      end

      body = perform_request('api/v1/admin/meta/remote-storage-vault/set', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminMetaRemoteStorageVaultTest
    #
    # Test the connection to the storage template.
    #
    # You must supply administrator authentication credentials to use this API.
    # Access to this API may be prevented on a per-administrator basis.
    #
    # @param [Comet::RemoteStorageOption] template_options Storage Template Vault Options
    # @return [Comet::CometAPIResponseMessage]
    def admin_meta_remote_storage_vault_test(template_options)
      submit_params = {}
      raise TypeError, "'template_options' expected Comet::RemoteStorageOption, got #{template_options.class}" unless template_options.is_a? Comet::RemoteStorageOption

      submit_params['TemplateOptions'] = template_options.to_json

      body = perform_request('api/v1/admin/meta/remote-storage-vault/test', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminMetaResourceGet
    #
    # Get a resource file.
    # Resources are used to upload files within the server configuration.
    #
    # You must supply administrator authentication credentials to use this API.
    #
    # @param [String] hash The resource identifier
    # @return [String]
    def admin_meta_resource_get(hash)
      submit_params = {}
      raise TypeError, "'hash' expected String, got #{hash.class}" unless hash.is_a? String

      submit_params['Hash'] = hash

      perform_request('api/v1/admin/meta/resource/get', submit_params)
    end

    # AdminMetaResourceNew
    #
    # Upload a resource file.
    # Resources are used to upload files within the server configuration.
    # The resulting resource ID is autogenerated.
    # The lifespan of an uploaded resource is undefined. Resources may be deleted automatically, but it should remain available until the next call to AdminMetaServerConfigSet, and will remain available for as long as it is referenced by the server configuration.
    #
    # You must supply administrator authentication credentials to use this API.
    #
    # @param [String] upload The uploaded file contents, as a multipart/form-data part.
    # @return [Comet::AdminResourceResponse]
    def admin_meta_resource_new(upload)
      submit_params = {}
      raise TypeError, "'upload' expected String, got #{upload.class}" unless upload.is_a? String

      submit_params['upload'] = upload

      body = perform_request_multipart('api/v1/admin/meta/resource/new', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::AdminResourceResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminMetaRestartService
    #
    # Restart server.
    # The Comet Server process will exit. The service manager should restart the server automatically.
    #
    # Prior to 18.9.2, this API terminated the server immediately without returning a response. In 18.9.2 and later, it returns a successful response before shutting down.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API is only available for top-level administrator accounts, not for Tenant administrator accounts.
    # Access to this API may be prevented on a per-administrator basis.
    #
    # @return [Comet::CometAPIResponseMessage]
    def admin_meta_restart_service
      body = perform_request('api/v1/admin/meta/restart-service')
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminMetaSendTestEmail
    #
    # Send a test email message.
    # This allows the Comet Server web interface to support testing different email credentials during setup.
    #
    # You must supply administrator authentication credentials to use this API.
    # Access to this API may be prevented on a per-administrator basis.
    #
    # @param [Comet::EmailOptions] email_options Updated configuration content
    # @param [String] recipient Target email address to send test email
    # @return [Comet::CometAPIResponseMessage]
    def admin_meta_send_test_email(email_options, recipient)
      submit_params = {}
      raise TypeError, "'email_options' expected Comet::EmailOptions, got #{email_options.class}" unless email_options.is_a? Comet::EmailOptions

      submit_params['EmailOptions'] = email_options.to_json
      raise TypeError, "'recipient' expected String, got #{recipient.class}" unless recipient.is_a? String

      submit_params['Recipient'] = recipient

      body = perform_request('api/v1/admin/meta/send-test-email', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminMetaSendTestReport
    #
    # Send a test admin email report.
    # This allows a user to send a test email report
    #
    # You must supply administrator authentication credentials to use this API.
    # Access to this API may be prevented on a per-administrator basis.
    #
    # @param [Comet::EmailReportingOption] email_reporting_option Test email reporting option for sending
    # @param [String] target_organization (Optional) If present, Testing email with a target organization. Only allowed for top-level admins. (>= 24.3.0)
    # @return [Comet::CometAPIResponseMessage]
    def admin_meta_send_test_report(email_reporting_option, target_organization = nil)
      submit_params = {}
      raise TypeError, "'email_reporting_option' expected Comet::EmailReportingOption, got #{email_reporting_option.class}" unless email_reporting_option.is_a? Comet::EmailReportingOption

      submit_params['EmailReportingOption'] = email_reporting_option.to_json
      unless target_organization.nil?
        raise TypeError, "'target_organization' expected String, got #{target_organization.class}" unless target_organization.is_a? String

        submit_params['TargetOrganization'] = target_organization
      end

      body = perform_request('api/v1/admin/meta/send-test-report', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminMetaServerConfigGet
    #
    # Get server configuration.
    #
    # You must supply administrator authentication credentials to use this API.
    # Access to this API may be prevented on a per-administrator basis.
    # This API is only available for top-level administrator accounts, not for Tenant administrator accounts.
    #
    # @return [Comet::ServerConfigOptions]
    def admin_meta_server_config_get
      body = perform_request('api/v1/admin/meta/server-config/get')
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::ServerConfigOptions.new
      ret.from_hash(json_body)
      ret
    end

    # AdminMetaServerConfigNetworkInterfaces
    #
    # List the available network interfaces on the PC running Comet Server.
    # Any IPv6 addresses are listed in compressed form without square-brackets.
    #
    # You must supply administrator authentication credentials to use this API.
    # Access to this API may be prevented on a per-administrator basis.
    # This API is only available for top-level administrator accounts, not for Tenant administrator accounts.
    #
    # @return [Array<String>]
    def admin_meta_server_config_network_interfaces
      body = perform_request('api/v1/admin/meta/server-config/network-interfaces')
      json_body = JSON.parse body
      check_status json_body
      if json_body.nil?
        ret = []
      else
        ret = Array.new(json_body.length)
        json_body.each_with_index do |v, i|
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          ret[i] = v
        end
      end
      ret
    end

    # AdminMetaServerConfigSet
    #
    # Set server configuration.
    # The Comet Server process will exit. The service manager should restart the server automatically.
    #
    # Prior to 18.9.2, this API terminated the server immediately without returning a response. In 18.9.2 and later, it returns a successful response before shutting down.
    #
    # You must supply administrator authentication credentials to use this API.
    # Access to this API may be prevented on a per-administrator basis.
    # This API is only available for top-level administrator accounts, not for Tenant administrator accounts.
    #
    # @param [Comet::ServerConfigOptions] config Updated configuration content
    # @return [Comet::CometAPIResponseMessage]
    def admin_meta_server_config_set(config)
      submit_params = {}
      raise TypeError, "'config' expected Comet::ServerConfigOptions, got #{config.class}" unless config.is_a? Comet::ServerConfigOptions

      submit_params['Config'] = config.to_json

      body = perform_request('api/v1/admin/meta/server-config/set', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminMetaShutdownService
    #
    # Shut down server.
    # The Comet Server process will exit.
    #
    # Prior to 18.9.2, this API terminated the server immediately without returning a response. In 18.9.2 and later, it returns a successful response before shutting down.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API is only available for top-level administrator accounts, not for Tenant administrator accounts.
    # Access to this API may be prevented on a per-administrator basis.
    #
    # @return [Comet::CometAPIResponseMessage]
    def admin_meta_shutdown_service
      body = perform_request('api/v1/admin/meta/shutdown-service')
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminMetaSoftwareUpdateNews
    #
    # Get software update news from the software provider.
    #
    # You must supply administrator authentication credentials to use this API.
    #
    # @return [Comet::SoftwareUpdateNewsResponse]
    def admin_meta_software_update_news
      body = perform_request('api/v1/admin/meta/software-update-news')
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::SoftwareUpdateNewsResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminMetaStats
    #
    # Get Comet Server historical statistics.
    # The returned key-value map is not necessarily ordered. Client-side code should sort the result before display.
    #
    # You must supply administrator authentication credentials to use this API.
    #
    # @param [Boolean] simple Remove redundant statistics
    # @return [Hash{Number => Comet::StatResult}]
    def admin_meta_stats(simple)
      submit_params = {}
      submit_params['Simple'] = (simple ? 1 : 0)

      body = perform_request('api/v1/admin/meta/stats', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = {}
      if json_body.nil?
        ret = {}
      else
        json_body.each do |k, v|
          ret[k] = Comet::StatResult.new
          ret[k].from_hash(v)
        end
      end
      ret
    end

    # AdminMetaVersion
    #
    # Get server properties.
    # Retrieve the version number and basic properties about the server.
    #
    # You must supply administrator authentication credentials to use this API.
    #
    # @return [Comet::ServerMetaVersionInfo]
    def admin_meta_version
      body = perform_request('api/v1/admin/meta/version')
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::ServerMetaVersionInfo.new
      ret.from_hash(json_body)
      ret
    end

    # AdminMetaWebhookOptionsGet
    #
    # Get the server webhook configuration.
    #
    # You must supply administrator authentication credentials to use this API.
    # Access to this API may be prevented on a per-administrator basis.
    #
    # @return [Hash{String => Comet::WebhookOption}]
    def admin_meta_webhook_options_get
      body = perform_request('api/v1/admin/meta/webhook-options/get')
      json_body = JSON.parse body
      check_status json_body
      ret = {}
      if json_body.nil?
        ret = {}
      else
        json_body.each do |k, v|
          ret[k] = Comet::WebhookOption.new
          ret[k].from_hash(v)
        end
      end
      ret
    end

    # AdminMetaWebhookOptionsSet
    #
    # Update the server webhook configuration.
    # Calling this endpoint will interrupt any messages currently queued for existing webhook destinations.
    #
    # You must supply administrator authentication credentials to use this API.
    # Access to this API may be prevented on a per-administrator basis.
    #
    # @param [Hash{String => Comet::WebhookOption}] webhook_options The replacement webhook target options.
    # @return [Comet::CometAPIResponseMessage]
    def admin_meta_webhook_options_set(webhook_options)
      submit_params = {}
      raise TypeError, "'webhook_options' expected Hash, got #{webhook_options.class}" unless webhook_options.is_a? Hash

      submit_params['WebhookOptions'] = webhook_options.to_json

      body = perform_request('api/v1/admin/meta/webhook-options/set', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminNewsGetAll
    #
    # Get News entries (Admin).
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @return [Hash{String => Comet::NewsEntry}]
    def admin_news_get_all
      body = perform_request('api/v1/admin/news/get-all')
      json_body = JSON.parse body
      check_status json_body
      ret = {}
      if json_body.nil?
        ret = {}
      else
        json_body.each do |k, v|
          ret[k] = Comet::NewsEntry.new
          ret[k].from_hash(v)
        end
      end
      ret
    end

    # AdminNewsRemove
    #
    # Remove news item.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] news_item Selected news item GUID
    # @return [Comet::CometAPIResponseMessage]
    def admin_news_remove(news_item)
      submit_params = {}
      raise TypeError, "'news_item' expected String, got #{news_item.class}" unless news_item.is_a? String

      submit_params['NewsItem'] = news_item

      body = perform_request('api/v1/admin/news/remove', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminNewsSubmit
    #
    # Submit news item.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] news_content Content of news item
    # @return [Comet::CometAPIResponseMessage]
    def admin_news_submit(news_content)
      submit_params = {}
      raise TypeError, "'news_content' expected String, got #{news_content.class}" unless news_content.is_a? String

      submit_params['NewsContent'] = news_content

      body = perform_request('api/v1/admin/news/submit', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminOrganizationDelete
    #
    # Delete an organization and all related users.
    #
    # Prior to Comet 22.6.0, this API was documented as returning the OrganizationResponse type. However, it always has returned only a CometAPIResponseMessage.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API is only available for top-level administrator accounts, not for Tenant administrator accounts.
    #
    # @param [String] organization_id (Optional) (No description available)
    # @param [Comet::UninstallConfig] uninstall_config (Optional) Uninstall software configuration
    # @return [Comet::CometAPIResponseMessage]
    def admin_organization_delete(organization_id = nil, uninstall_config = nil)
      submit_params = {}
      unless organization_id.nil?
        raise TypeError, "'organization_id' expected String, got #{organization_id.class}" unless organization_id.is_a? String

        submit_params['OrganizationID'] = organization_id
      end
      unless uninstall_config.nil?
        raise TypeError, "'uninstall_config' expected Comet::UninstallConfig, got #{uninstall_config.class}" unless uninstall_config.is_a? Comet::UninstallConfig

        submit_params['UninstallConfig'] = uninstall_config.to_json
      end

      body = perform_request('api/v1/admin/organization/delete', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminOrganizationExport
    #
    # Run self-backup for a specific tenant.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API is only available for top-level administrator accounts, not for Tenant administrator accounts.
    #
    # @param [Comet::SelfBackupExportOptions] options The export config options
    # @return [Comet::CometAPIResponseMessage]
    def admin_organization_export(options)
      submit_params = {}
      raise TypeError, "'options' expected Comet::SelfBackupExportOptions, got #{options.class}" unless options.is_a? Comet::SelfBackupExportOptions

      submit_params['Options'] = options.to_json

      body = perform_request('api/v1/admin/organization/export', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminOrganizationList
    #
    # List Organizations.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API is only available for top-level administrator accounts, not for Tenant administrator accounts.
    #
    # @return [Hash{String => Comet::Organization}]
    def admin_organization_list
      body = perform_request('api/v1/admin/organization/list')
      json_body = JSON.parse body
      check_status json_body
      ret = {}
      if json_body.nil?
        ret = {}
      else
        json_body.each do |k, v|
          ret[k] = Comet::Organization.new
          ret[k].from_hash(v)
        end
      end
      ret
    end

    # AdminOrganizationSet
    #
    # Create or Update an Organization.
    #
    # Prior to Comet 22.6.0, the 'ID' and 'Organization' fields were not present in the response.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API is only available for top-level administrator accounts, not for Tenant administrator accounts.
    #
    # @param [String] organization_id (Optional) (No description available)
    # @param [Comet::Organization] organization (Optional) (No description available)
    # @return [Comet::OrganizationResponse]
    def admin_organization_set(organization_id = nil, organization = nil)
      submit_params = {}
      unless organization_id.nil?
        raise TypeError, "'organization_id' expected String, got #{organization_id.class}" unless organization_id.is_a? String

        submit_params['OrganizationID'] = organization_id
      end
      unless organization.nil?
        raise TypeError, "'organization' expected Comet::Organization, got #{organization.class}" unless organization.is_a? Comet::Organization

        submit_params['Organization'] = organization.to_json
      end

      body = perform_request('api/v1/admin/organization/set', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::OrganizationResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminPoliciesDelete
    #
    # Delete an existing policy object.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] policy_id The policy ID to update or create
    # @return [Comet::CometAPIResponseMessage]
    def admin_policies_delete(policy_id)
      submit_params = {}
      raise TypeError, "'policy_id' expected String, got #{policy_id.class}" unless policy_id.is_a? String

      submit_params['PolicyID'] = policy_id

      body = perform_request('api/v1/admin/policies/delete', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminPoliciesGet
    #
    # Retrieve a single policy object.
    # A hash is also returned, to allow atomic modification operations.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] policy_id The policy ID to retrieve
    # @return [Comet::GetGroupPolicyResponse]
    def admin_policies_get(policy_id)
      submit_params = {}
      raise TypeError, "'policy_id' expected String, got #{policy_id.class}" unless policy_id.is_a? String

      submit_params['PolicyID'] = policy_id

      body = perform_request('api/v1/admin/policies/get', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::GetGroupPolicyResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminPoliciesList
    #
    # List all policy object names.
    # For the top-level organization, the API result includes all policies for all organizations, unless the TargetOrganization parameter is present.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_organization (Optional) If present, list the policies belonging to another organization. Only allowed for administrator accounts in the top-level organization. (>= 22.3.7)
    # @return [Hash{String => String}]
    def admin_policies_list(target_organization = nil)
      submit_params = {}
      unless target_organization.nil?
        raise TypeError, "'target_organization' expected String, got #{target_organization.class}" unless target_organization.is_a? String

        submit_params['TargetOrganization'] = target_organization
      end

      body = perform_request('api/v1/admin/policies/list', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = {}
      if json_body.nil?
        ret = {}
      else
        json_body.each do |k, v|
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          ret[k] = v
        end
      end
      ret
    end

    # AdminPoliciesListFull
    #
    # Get all policy objects.
    # For the top-level organization, the API result includes all policies for all organizations, unless the TargetOrganization parameter is present.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_organization (Optional) If present, list the policies belonging to another organization. Only allowed for administrator accounts in the top-level organization. (>= 22.3.7)
    # @return [Hash{String => Comet::GroupPolicy}]
    def admin_policies_list_full(target_organization = nil)
      submit_params = {}
      unless target_organization.nil?
        raise TypeError, "'target_organization' expected String, got #{target_organization.class}" unless target_organization.is_a? String

        submit_params['TargetOrganization'] = target_organization
      end

      body = perform_request('api/v1/admin/policies/list-full', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = {}
      if json_body.nil?
        ret = {}
      else
        json_body.each do |k, v|
          ret[k] = Comet::GroupPolicy.new
          ret[k].from_hash(v)
        end
      end
      ret
    end

    # AdminPoliciesNew
    #
    # Create a new policy object.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [Comet::GroupPolicy] policy The policy data
    # @return [Comet::CreateGroupPolicyResponse]
    def admin_policies_new(policy)
      submit_params = {}
      raise TypeError, "'policy' expected Comet::GroupPolicy, got #{policy.class}" unless policy.is_a? Comet::GroupPolicy

      submit_params['Policy'] = policy.to_json

      body = perform_request('api/v1/admin/policies/new', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CreateGroupPolicyResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminPoliciesSet
    #
    # Update an existing policy object.
    # An optional hash may be used, to ensure the modification was atomic.
    # This API can also be used to create a new policy object with a specific hash.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] policy_id The policy ID to update or create
    # @param [Comet::GroupPolicy] policy The policy data
    # @param [String] check_policy_hash (Optional) An atomic verification hash as supplied by the AdminPoliciesGet API
    # @param [Comet::PolicyOptions] options (Optional) An array of PolicySourceID that will be explicitly deleted.
    # @return [Comet::CometAPIResponseMessage]
    def admin_policies_set(policy_id, policy, check_policy_hash = nil, options = nil)
      submit_params = {}
      raise TypeError, "'policy_id' expected String, got #{policy_id.class}" unless policy_id.is_a? String

      submit_params['PolicyID'] = policy_id
      raise TypeError, "'policy' expected Comet::GroupPolicy, got #{policy.class}" unless policy.is_a? Comet::GroupPolicy

      submit_params['Policy'] = policy.to_json
      unless check_policy_hash.nil?
        raise TypeError, "'check_policy_hash' expected String, got #{check_policy_hash.class}" unless check_policy_hash.is_a? String

        submit_params['CheckPolicyHash'] = check_policy_hash
      end
      unless options.nil?
        raise TypeError, "'options' expected Comet::PolicyOptions, got #{options.class}" unless options.is_a? Comet::PolicyOptions

        submit_params['Options'] = options.to_json
      end

      body = perform_request('api/v1/admin/policies/set', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminPreviewUserEmailReport
    #
    # Preview an email report for a customer.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_user Selected account username
    # @param [Comet::EmailReportConfig] email_report_config Email report configuration to preview
    # @param [String] email_address (Optional) Email address that may be included in the report body (>= 20.3.3)
    # @return [Comet::EmailReportGeneratedPreview]
    def admin_preview_user_email_report(target_user, email_report_config, email_address = nil)
      submit_params = {}
      raise TypeError, "'target_user' expected String, got #{target_user.class}" unless target_user.is_a? String

      submit_params['TargetUser'] = target_user
      raise TypeError, "'email_report_config' expected Comet::EmailReportConfig, got #{email_report_config.class}" unless email_report_config.is_a? Comet::EmailReportConfig

      submit_params['EmailReportConfig'] = email_report_config.to_json
      unless email_address.nil?
        raise TypeError, "'email_address' expected String, got #{email_address.class}" unless email_address.is_a? String

        submit_params['EmailAddress'] = email_address
      end

      body = perform_request('api/v1/admin/preview-user-email-report', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::EmailReportGeneratedPreview.new
      ret.from_hash(json_body)
      ret
    end

    # AdminReplicationState
    #
    # Get Replication status.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API is only available for top-level administrator accounts, not for Tenant administrator accounts.
    #
    # @return [Array<Comet::ReplicatorStateAPIResponse>]
    def admin_replication_state
      body = perform_request('api/v1/admin/replication/state')
      json_body = JSON.parse body
      check_status json_body
      if json_body.nil?
        ret = []
      else
        ret = Array.new(json_body.length)
        json_body.each_with_index do |v, i|
          ret[i] = Comet::ReplicatorStateAPIResponse.new
          ret[i].from_hash(v)
        end
      end
      ret
    end

    # AdminRequestStorageVault
    #
    # Request a new Storage Vault on behalf of a user.
    # This action does not respect the "Prevent creating new Storage Vaults (via Request)" policy setting. New Storage Vaults can be requested regardless of the policy setting.
    # Prior to Comet 19.8.0, the response type was CometAPIResponseMessage (i.e. no DestinationID field in response).
    # The StorageProvider must exist for the target user account's organization.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_user The user to receive the new Storage Vault
    # @param [String] storage_provider ID for the storage template destination
    # @param [String] self_address (Optional) The external URL for this server. Used to resolve conflicts
    # @param [String] device_id (Optional) The ID of the device to be added as a associated device of the Storage Vault
    # @param [String] profile_hash (Optional) The profile hash of the user profile
    # @return [Comet::RequestStorageVaultResponseMessage]
    def admin_request_storage_vault(target_user, storage_provider, self_address = nil, device_id = nil, profile_hash = nil)
      submit_params = {}
      raise TypeError, "'target_user' expected String, got #{target_user.class}" unless target_user.is_a? String

      submit_params['TargetUser'] = target_user
      raise TypeError, "'storage_provider' expected String, got #{storage_provider.class}" unless storage_provider.is_a? String

      submit_params['StorageProvider'] = storage_provider
      if self_address.nil?
        submit_params['SelfAddress'] = @server_address
      else
        raise TypeError, "'self_address' expected String, got #{self_address.class}" unless self_address.is_a? String

        submit_params['SelfAddress'] = self_address
      end
      unless device_id.nil?
        raise TypeError, "'device_id' expected String, got #{device_id.class}" unless device_id.is_a? String

        submit_params['DeviceID'] = device_id
      end
      unless profile_hash.nil?
        raise TypeError, "'profile_hash' expected String, got #{profile_hash.class}" unless profile_hash.is_a? String

        submit_params['ProfileHash'] = profile_hash
      end

      body = perform_request('api/v1/admin/request-storage-vault', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::RequestStorageVaultResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminRequestStorageVaultProviders
    #
    # Get the available options for Requesting a Storage Vault.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_organization (Optional) If present, list the storage template options belonging to another organization. Only allowed for administrator accounts in the top-level organization. (>= 22.3.7)
    # @return [Hash{String => String}]
    def admin_request_storage_vault_providers(target_organization = nil)
      submit_params = {}
      unless target_organization.nil?
        raise TypeError, "'target_organization' expected String, got #{target_organization.class}" unless target_organization.is_a? String

        submit_params['TargetOrganization'] = target_organization
      end

      body = perform_request('api/v1/admin/request-storage-vault-providers', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = {}
      if json_body.nil?
        ret = {}
      else
        json_body.each do |k, v|
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          ret[k] = v
        end
      end
      ret
    end

    # AdminResetUserPassword
    #
    # Reset user account password.
    # The user account must have a recovery code present. A new replacement recovery code will be generated automatically.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_user Selected account username
    # @param [String] new_password New account password
    # @param [String] old_password (Optional) Old account password. Required if no recovery code is present for the user account.
    # @return [Comet::CometAPIResponseMessage]
    def admin_reset_user_password(target_user, new_password, old_password = nil)
      submit_params = {}
      raise TypeError, "'target_user' expected String, got #{target_user.class}" unless target_user.is_a? String

      submit_params['TargetUser'] = target_user
      raise TypeError, "'new_password' expected String, got #{new_password.class}" unless new_password.is_a? String

      submit_params['NewPassword'] = new_password
      unless old_password.nil?
        raise TypeError, "'old_password' expected String, got #{old_password.class}" unless old_password.is_a? String

        submit_params['OldPassword'] = old_password
      end

      body = perform_request('api/v1/admin/reset-user-password', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminRevokeDevice
    #
    # Revoke device from user account.
    # It's possible to simply remove the Device section from the user's profile, however, using this dedicated API will also gracefully handle live connections.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_user Selected account username
    # @param [String] target_device Selected Device ID
    # @return [Comet::CometAPIResponseMessage]
    def admin_revoke_device(target_user, target_device)
      submit_params = {}
      raise TypeError, "'target_user' expected String, got #{target_user.class}" unless target_user.is_a? String

      submit_params['TargetUser'] = target_user
      raise TypeError, "'target_device' expected String, got #{target_device.class}" unless target_device.is_a? String

      submit_params['TargetDevice'] = target_device

      body = perform_request('api/v1/admin/revoke-device', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminSelfBackupStart
    #
    # Run self-backup on all targets.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API is only available for top-level administrator accounts, not for Tenant administrator accounts.
    #
    # @return [Comet::CometAPIResponseMessage]
    def admin_self_backup_start
      body = perform_request('api/v1/admin/self-backup/start')
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminSetProtectedItemWithBackupRules
    #
    # Add or update a Protected Item with its backup rules.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_user Selected account username
    # @param [String] source_id Selected Protected Item GUID
    # @param [String] require_hash (Optional) Previous account profile hash
    # @param [Comet::SourceConfig] source (Optional) Optional Protected Item to create or update
    # @param [Hash{String => Comet::BackupRuleConfig}] backup_rules (Optional) Optional backup rules for the Protected Item
    # @return [Comet::CometAPIResponseMessage]
    def admin_set_protected_item_with_backup_rules(target_user, source_id, require_hash = nil, source = nil, backup_rules = nil)
      submit_params = {}
      raise TypeError, "'target_user' expected String, got #{target_user.class}" unless target_user.is_a? String

      submit_params['TargetUser'] = target_user
      raise TypeError, "'source_id' expected String, got #{source_id.class}" unless source_id.is_a? String

      submit_params['SourceID'] = source_id
      unless require_hash.nil?
        raise TypeError, "'require_hash' expected String, got #{require_hash.class}" unless require_hash.is_a? String

        submit_params['RequireHash'] = require_hash
      end
      unless source.nil?
        raise TypeError, "'source' expected Comet::SourceConfig, got #{source.class}" unless source.is_a? Comet::SourceConfig

        submit_params['Source'] = source.to_json
      end
      unless backup_rules.nil?
        raise TypeError, "'backup_rules' expected Hash, got #{backup_rules.class}" unless backup_rules.is_a? Hash

        submit_params['BackupRules'] = backup_rules.to_json
      end

      body = perform_request('api/v1/admin/set-protected-item-with-backup-rules', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminSetUserProfile
    #
    # Modify user account profile.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_user Selected account username
    # @param [Comet::UserProfileConfig] profile_data Modified user profile
    # @return [Comet::CometAPIResponseMessage]
    def admin_set_user_profile(target_user, profile_data)
      submit_params = {}
      raise TypeError, "'target_user' expected String, got #{target_user.class}" unless target_user.is_a? String

      submit_params['TargetUser'] = target_user
      raise TypeError, "'profile_data' expected Comet::UserProfileConfig, got #{profile_data.class}" unless profile_data.is_a? Comet::UserProfileConfig

      submit_params['ProfileData'] = profile_data.to_json

      body = perform_request('api/v1/admin/set-user-profile', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminSetUserProfileHash
    #
    # Modify user account profile (atomic).
    # The hash parameter can be determined from the corresponding API, to atomically ensure that no changes occur between get/set operations.
    # The hash format is not publicly documented and may change in a future server version. Use server APIs to retrieve current hash values.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_user Selected account username
    # @param [Comet::UserProfileConfig] profile_data Modified user profile
    # @param [String] require_hash Previous hash parameter
    # @param [Comet::AdminOptions] admin_options (Optional) Instructions for modifying user profile
    # @return [Comet::GetProfileAndHashResponseMessage]
    def admin_set_user_profile_hash(target_user, profile_data, require_hash, admin_options = nil)
      submit_params = {}
      raise TypeError, "'target_user' expected String, got #{target_user.class}" unless target_user.is_a? String

      submit_params['TargetUser'] = target_user
      raise TypeError, "'profile_data' expected Comet::UserProfileConfig, got #{profile_data.class}" unless profile_data.is_a? Comet::UserProfileConfig

      submit_params['ProfileData'] = profile_data.to_json
      raise TypeError, "'require_hash' expected String, got #{require_hash.class}" unless require_hash.is_a? String

      submit_params['RequireHash'] = require_hash
      unless admin_options.nil?
        raise TypeError, "'admin_options' expected Comet::AdminOptions, got #{admin_options.class}" unless admin_options.is_a? Comet::AdminOptions

        submit_params['AdminOptions'] = admin_options.to_json
      end

      body = perform_request('api/v1/admin/set-user-profile-hash', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::GetProfileAndHashResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminStorageBucketProperties
    #
    # Retrieve properties for a single bucket.
    # This API can also be used to refresh the size measurement for a single bucket by passing a valid AfterTimestamp parameter.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Storage Role to be enabled.
    #
    # @param [String] bucket_id Bucket ID
    # @param [Number] after_timestamp (Optional) Allow a stale size measurement if it is at least as new as the supplied Unix timestamp. Timestamps in the future may produce a result clamped down to the Comet Server's current time. If not present, the size measurement may be arbitrarily stale.
    # @return [Comet::BucketProperties]
    def admin_storage_bucket_properties(bucket_id, after_timestamp = nil)
      submit_params = {}
      raise TypeError, "'bucket_id' expected String, got #{bucket_id.class}" unless bucket_id.is_a? String

      submit_params['BucketID'] = bucket_id
      unless after_timestamp.nil?
        raise TypeError, "'after_timestamp' expected Numeric, got #{after_timestamp.class}" unless after_timestamp.is_a? Numeric

        submit_params['AfterTimestamp'] = after_timestamp
      end

      body = perform_request('api/v1/admin/storage/bucket-properties', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::BucketProperties.new
      ret.from_hash(json_body)
      ret
    end

    # AdminStorageDeleteBucket
    #
    # Delete a bucket.
    # All data will be removed from the server. Misuse can cause data loss!
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Storage Role to be enabled.
    #
    # @param [String] bucket_id Selected bucket name
    # @return [Comet::CometAPIResponseMessage]
    def admin_storage_delete_bucket(bucket_id)
      submit_params = {}
      raise TypeError, "'bucket_id' expected String, got #{bucket_id.class}" unless bucket_id.is_a? String

      submit_params['BucketID'] = bucket_id

      body = perform_request('api/v1/admin/storage/delete-bucket', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminStorageFreeSpace
    #
    # Retrieve available space metrics.
    #
    # You must supply administrator authentication credentials to use this API.
    # Access to this API may be prevented on a per-administrator basis.
    # This API requires the Storage Role to be enabled.
    # This API is only available for top-level administrator accounts, not for Tenant administrator accounts.
    #
    # @param [String] bucket_id (Optional) (This parameter is not used)
    # @return [Comet::StorageFreeSpaceInfo]
    def admin_storage_free_space(bucket_id = nil)
      submit_params = {}
      unless bucket_id.nil?
        raise TypeError, "'bucket_id' expected String, got #{bucket_id.class}" unless bucket_id.is_a? String

        submit_params['BucketID'] = bucket_id
      end

      body = perform_request('api/v1/admin/storage/free-space', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::StorageFreeSpaceInfo.new
      ret.from_hash(json_body)
      ret
    end

    # AdminStorageListBuckets
    #
    # List all buckets.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Storage Role to be enabled.
    #
    # @return [Hash{String => Comet::BucketProperties}]
    def admin_storage_list_buckets
      body = perform_request('api/v1/admin/storage/list-buckets')
      json_body = JSON.parse body
      check_status json_body
      ret = {}
      if json_body.nil?
        ret = {}
      else
        json_body.each do |k, v|
          ret[k] = Comet::BucketProperties.new
          ret[k].from_hash(v)
        end
      end
      ret
    end

    # AdminStoragePingDestination
    #
    # Ping a storage destination.
    #
    # You must supply administrator authentication credentials to use this API.
    # Access to this API may be prevented on a per-administrator basis.
    # This API is only available for top-level administrator accounts, not for Tenant administrator accounts.
    #
    # @param [Comet::DestinationLocation] extra_data The destination location settings
    # @return [Comet::CometAPIResponseMessage]
    def admin_storage_ping_destination(extra_data)
      submit_params = {}
      raise TypeError, "'extra_data' expected Comet::DestinationLocation, got #{extra_data.class}" unless extra_data.is_a? Comet::DestinationLocation

      submit_params['ExtraData'] = extra_data.to_json

      body = perform_request('api/v1/admin/storage/ping-destination', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminStorageRegisterBucket
    #
    # Create a new bucket.
    # Leave the Set* parameters blank to generate a bucket with random credentials, or, supply a pre-hashed password for zero-knowledge operations.
    # Any auto-generated credentials are returned in the response message.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Storage Role to be enabled.
    #
    # @param [String] set_bucket_value (Optional) Bucket ID
    # @param [String] set_key_hash_format (Optional) Bucket key hashing format
    # @param [String] set_key_hash_value (Optional) Bucket key hash
    # @param [String] set_organization_id (Optional) Target organization ID (>= 20.9.0)
    # @return [Comet::AddBucketResponseMessage]
    def admin_storage_register_bucket(set_bucket_value = nil, set_key_hash_format = nil, set_key_hash_value = nil, set_organization_id = nil)
      submit_params = {}
      unless set_bucket_value.nil?
        raise TypeError, "'set_bucket_value' expected String, got #{set_bucket_value.class}" unless set_bucket_value.is_a? String

        submit_params['SetBucketValue'] = set_bucket_value
      end
      unless set_key_hash_format.nil?
        raise TypeError, "'set_key_hash_format' expected String, got #{set_key_hash_format.class}" unless set_key_hash_format.is_a? String

        submit_params['SetKeyHashFormat'] = set_key_hash_format
      end
      unless set_key_hash_value.nil?
        raise TypeError, "'set_key_hash_value' expected String, got #{set_key_hash_value.class}" unless set_key_hash_value.is_a? String

        submit_params['SetKeyHashValue'] = set_key_hash_value
      end
      unless set_organization_id.nil?
        raise TypeError, "'set_organization_id' expected String, got #{set_organization_id.class}" unless set_organization_id.is_a? String

        submit_params['SetOrganizationID'] = set_organization_id
      end

      body = perform_request('api/v1/admin/storage/register-bucket', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::AddBucketResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminUpdateCampaignStart
    #
    # Start a new software update campaign.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API is only available for top-level administrator accounts, not for Tenant administrator accounts.
    # This API requires the Software Build Role to be enabled.
    # This API requires the Auth Role to be enabled.
    #
    # @param [Comet::UpdateCampaignOptions] options Configure targets for the software update campaign
    # @return [Comet::CometAPIResponseMessage]
    def admin_update_campaign_start(options)
      submit_params = {}
      raise TypeError, "'options' expected Comet::UpdateCampaignOptions, got #{options.class}" unless options.is_a? Comet::UpdateCampaignOptions

      submit_params['Options'] = options.to_json

      body = perform_request('api/v1/admin/update-campaign/start', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminUpdateCampaignStatus
    #
    # Get current campaign status.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API is only available for top-level administrator accounts, not for Tenant administrator accounts.
    # This API requires the Software Build Role to be enabled.
    # This API requires the Auth Role to be enabled.
    #
    # @return [Comet::UpdateCampaignStatus]
    def admin_update_campaign_status
      body = perform_request('api/v1/admin/update-campaign/status')
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::UpdateCampaignStatus.new
      ret.from_hash(json_body)
      ret
    end

    # AdminUserGroupsDelete
    #
    # Delete an existing user group object.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] group_id The user group ID to delete
    # @return [Comet::CometAPIResponseMessage]
    def admin_user_groups_delete(group_id)
      submit_params = {}
      raise TypeError, "'group_id' expected String, got #{group_id.class}" unless group_id.is_a? String

      submit_params['GroupID'] = group_id

      body = perform_request('api/v1/admin/user-groups/delete', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminUserGroupsGet
    #
    # Retrieve a single user group object.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] group_id The user group ID to retrieve
    # @param [Boolean] include_users (Optional) If present, includes the users array in the response.
    # @return [Comet::GetUserGroupWithUsersResponse]
    def admin_user_groups_get(group_id, include_users = nil)
      submit_params = {}
      raise TypeError, "'group_id' expected String, got #{group_id.class}" unless group_id.is_a? String

      submit_params['GroupID'] = group_id
      unless include_users.nil?
        submit_params['IncludeUsers'] = (include_users ? 1 : 0)
      end

      body = perform_request('api/v1/admin/user-groups/get', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::GetUserGroupWithUsersResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminUserGroupsList
    #
    # List all user group names.
    # For the top-level organization, the API result includes all user groups for all organizations, unless the TargetOrganization parameter is present.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_organization (Optional) If present, list the user groups belonging to another organization. Only allowed for administrator accounts in the top-level organization.
    # @return [Hash{String => String}]
    def admin_user_groups_list(target_organization = nil)
      submit_params = {}
      unless target_organization.nil?
        raise TypeError, "'target_organization' expected String, got #{target_organization.class}" unless target_organization.is_a? String

        submit_params['TargetOrganization'] = target_organization
      end

      body = perform_request('api/v1/admin/user-groups/list', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = {}
      if json_body.nil?
        ret = {}
      else
        json_body.each do |k, v|
          raise TypeError, "'v' expected String, got #{v.class}" unless v.is_a? String

          ret[k] = v
        end
      end
      ret
    end

    # AdminUserGroupsListFull
    #
    # Get all user group objects.
    # For the top-level organization, the API result includes all user groups for all organizations, unless the TargetOrganization parameter is present.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] target_organization (Optional) If present, list the user groups belonging to the specified organization. Only allowed for administrator accounts in the top-level organization.
    # @return [Hash{String => Comet::UserGroup}]
    def admin_user_groups_list_full(target_organization = nil)
      submit_params = {}
      unless target_organization.nil?
        raise TypeError, "'target_organization' expected String, got #{target_organization.class}" unless target_organization.is_a? String

        submit_params['TargetOrganization'] = target_organization
      end

      body = perform_request('api/v1/admin/user-groups/list-full', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = {}
      if json_body.nil?
        ret = {}
      else
        json_body.each do |k, v|
          ret[k] = Comet::UserGroup.new
          ret[k].from_hash(v)
        end
      end
      ret
    end

    # AdminUserGroupsNew
    #
    # Create a new user group object.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] name this is the name of the group.
    # @param [String] target_organization (Optional) If present, list the policies belonging to another organization. Only allowed for administrator accounts in the top-level organization.
    # @return [Comet::CreateUserGroupResponse]
    def admin_user_groups_new(name, target_organization = nil)
      submit_params = {}
      raise TypeError, "'name' expected String, got #{name.class}" unless name.is_a? String

      submit_params['Name'] = name
      unless target_organization.nil?
        raise TypeError, "'target_organization' expected String, got #{target_organization.class}" unless target_organization.is_a? String

        submit_params['TargetOrganization'] = target_organization
      end

      body = perform_request('api/v1/admin/user-groups/new', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CreateUserGroupResponse.new
      ret.from_hash(json_body)
      ret
    end

    # AdminUserGroupsSet
    #
    # Update an existing user group or create a new user group.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] group_id The user group ID to update or create
    # @param [Comet::UserGroup] group The user group data
    # @return [Comet::CometAPIResponseMessage]
    def admin_user_groups_set(group_id, group)
      submit_params = {}
      raise TypeError, "'group_id' expected String, got #{group_id.class}" unless group_id.is_a? String

      submit_params['GroupID'] = group_id
      raise TypeError, "'group' expected Comet::UserGroup, got #{group.class}" unless group.is_a? Comet::UserGroup

      submit_params['Group'] = group.to_json

      body = perform_request('api/v1/admin/user-groups/set', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # AdminUserGroupsSetUsersForGroup
    #
    # Update the users in the specified group.
    # The provided list of users will be moved into the specified group, and any users
    # already in the group who are not in the list of usernames will be removed.
    #
    # You must supply administrator authentication credentials to use this API.
    # This API requires the Auth Role to be enabled.
    #
    # @param [String] group_id The user group ID to update
    # @param [Array<String>] users An array of usernames.
    # @return [Comet::CometAPIResponseMessage]
    def admin_user_groups_set_users_for_group(group_id, users)
      submit_params = {}
      raise TypeError, "'group_id' expected String, got #{group_id.class}" unless group_id.is_a? String

      submit_params['GroupID'] = group_id
      raise TypeError, "'users' expected Array, got #{users.class}" unless users.is_a? Array

      submit_params['Users'] = users.to_json

      body = perform_request('api/v1/admin/user-groups/set-users-for-group', submit_params)
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # HybridSessionStart
    #
    # Generate a session key (log in).
    # This hybrid API allows you to log in to the Comet Server as either an administrator or end-user account.
    # This API behaves like either AdminAccountSessionStart or UserWebSessionStart, depending on what the supplied credentials were valid for.
    #
    # @return [Comet::SessionKeyRegeneratedResponse]
    def hybrid_session_start
      body = perform_request('api/v1/hybrid/session/start')
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::SessionKeyRegeneratedResponse.new
      ret.from_hash(json_body)
      ret
    end

    # UserWebSessionRevoke
    #
    # Revoke a session key (log out).
    #
    # You must supply user authentication credentials to use this API, and the user account must be authorized for web access.
    # This API requires the Auth Role to be enabled.
    #
    # @return [Comet::CometAPIResponseMessage]
    def user_web_session_revoke
      body = perform_request('api/v1/user/web/session/revoke')
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::CometAPIResponseMessage.new
      ret.from_hash(json_body)
      ret
    end

    # UserWebSessionStart
    #
    # Generate a session key (log in).
    #
    # You must supply user authentication credentials to use this API, and the user account must be authorized for web access.
    # This API requires the Auth Role to be enabled.
    #
    # @return [Comet::SessionKeyRegeneratedResponse]
    def user_web_session_start
      body = perform_request('api/v1/user/web/session/start')
      json_body = JSON.parse body
      check_status json_body
      ret = Comet::SessionKeyRegeneratedResponse.new
      ret.from_hash(json_body)
      ret
    end

    # If the supplied object represents an unsuccessful CometAPIResponseMessage, raise
    # it as an error.
    #
    # @param [Hash] obj
    def check_status(obj)
      return unless obj.is_a? Hash
      return unless obj.key?('Status')
      return unless obj.key?('Message')
      return unless obj['Status'] != 200 && obj['Status'] != 201

      ret_error = Comet::CometAPIResponseMessage.new
      ret_error.from_hash(obj)
      raise Comet::APIResponseError.new(ret_error)
    end

    # Perform a synchronous HTTP request.
    #
    # @param [String] endpoint The URL suffix
    # @param [Hash<String,String>] params Form post parameters to submit to the target API
    # @return [String] Response body
    def perform_request(endpoint, params = {})
      full_uri = URI(@server_address + endpoint)
      params['Username'] = @username
      params['AuthType'] = 'Password'
      params['Password'] = @password

      res = Net::HTTP.post_form(full_uri, params)
      unless res.is_a?(Net::HTTPSuccess)
        raise res
      end

      res.body
    end

    # Perform a synchronous HTTP request, using multipart/form-data.
    #
    # @param [String] endpoint The URL suffix
    # @param [Hash<String,String>] params Form post parameters to submit to the target API
    # @return [String] Response body
    def perform_request_multipart(endpoint, params = {})
      full_uri = URI(@server_address + endpoint)

      req = Net::HTTP::Post.new(full_uri)
      req['X-Comet-Admin-Username'] = @username
      req['X-Comet-Admin-AuthType'] = 'Password'
      req['X-Comet-Admin-Password'] = @password

      form_params = []
      params.each do |k, v|
        form_params.append [k, v, {:filename => k}]
      end
      req.set_form(form_params, 'multipart/form-data')

      http = Net::HTTP.new(full_uri.hostname, full_uri.port)
      res = http.request(req)

      unless res.is_a?(Net::HTTPSuccess)
        raise res
      end

      res.body
    end
  end

end
