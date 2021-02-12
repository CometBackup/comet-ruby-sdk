#!/usr/bin/env ruby --enable-frozen-string-literal
#
# Copyright (c) 2020-2021 Comet Licensing Ltd.
# Please see the LICENSE file for usage information.
#
# SPDX-License-Identifier: MIT
#
# frozen_string_literal: true

module Comet

  # APIResponseError is a custom exception class that wraps the Comet::CometAPIResponseMessage
  # type. These represent application-level error responses from the Comet Server API.
  # Network-level error responses should be caught using the Net::HTTP error types.
  class APIResponseError < StandardError

    # @type [Comet::CometAPIResponseMessage] The application-level error
    attr_reader :detail

    def initialize(carm)
      @detail = carm

      super("#{carm.message} (#{carm.status})")
    end
  end

end
