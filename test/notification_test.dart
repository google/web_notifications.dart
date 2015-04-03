// Copyright (c) 2015, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library notification.test;

import 'dart:html' hide Notification;
import 'dart:async';
import 'dart:js';
import 'package:unittest/unittest.dart';
import 'package:notification/notification.dart';

main() {
  test('constructor exists', () {
    expect(Notification.constructor, isNotNull);
    expect(Notification.constructor is JsObject, isTrue);
  });

  group('constructors', () {
    // Test that we create the notification and that the parameters have
    // the expected values. Note that these won't actually display, because
    // we haven't asked for permission, which would have to be done
    // interactively, so can't run on a bot.
    var allDefaults;
    var allSpecified;

    _closeNotifications(_) {
      if (allDefaults != null) allDefaults.close();
      if (allSpecified != null) allSpecified.close();
    }
    closeNotifications() => new Future.delayed(new Duration(milliseconds: 1))
        .then(_closeNotifications);
    tearDown(closeNotifications);

    test('Notification', () {
      var expectation = Notification.supported ? returnsNormally : throws;
      expect(() {
        allDefaults = new Notification("Hello world");
        allSpecified = new Notification("Deluxe notification",
            dir: "rtl",
            body: 'All parameters set',
            icon: 'icon.png',
            tag: 'tag',
            lang: 'en-US');
        expect(allDefaults is Notification, isTrue);
        expect(allSpecified is Notification, isTrue);
        expect(allDefaults.title, "Hello world");
        expect(allSpecified.title, "Deluxe notification");
        expect(allSpecified.dir, "rtl");
        expect(allSpecified.body, "All parameters set");
        var icon = allSpecified.icon;
        var tail = Uri.parse(icon).pathSegments.last;
        expect(tail, "icon.png");
        expect(allSpecified.tag, "tag");
        expect(allSpecified.lang, "en-US");
        allDefaults.onClick.listen(expectAsync((x) => null));
        clickOn(allDefaults);
      }, expectation);
    });
  });
}

/// Simulate clicking on the notification.
clickOn(thing) {
  var event =
      new MouseEvent('click', view: thing, canBubble: true, cancelable: true);
  thing.dispatchEvent(event);
}
