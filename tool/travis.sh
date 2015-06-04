#!/bin/bash

# Copyright (c) 2015, Google Inc. Please see the AUTHORS file for details.
# All rights reserved. Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# Fast fail the script on failures.
set -e

# Verify that the libraries are error free.
dartanalyzer --fatal-warnings \
  lib/notification.dart \
  test/notification_test.dart

# Run the tests.
pub run test -p content-shell -p firefox
