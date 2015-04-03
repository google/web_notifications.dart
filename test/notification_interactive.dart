// Copyright (c) 2015, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/// A quick manual test of Notifications, using things that can only be
/// run interactively.
library notification.interactive_test;

import 'dart:async';
import 'dart:html' hide Notification;
import 'package:notification/notification.dart';

main() {
  // We can't actually verify getting permission, as that's interactive.
  // Run this interactively, clicking the button, to
  // exercise this. You should see a thank you. It may require you to
  // give permission to show notifications.
  var button = querySelector("#b");
  button.onClick.listen((_) {
    Future permission = Notification.requestPermission();
    permission.then(newNotification);
  });
}

newNotification(_) {
  var notifier = new Notification('Thank you for letting me notify you');
  notifier.onClose.listen((x) => document.body
      .appendHtml('<p>Thank you for closing the notification</p>'));
}
