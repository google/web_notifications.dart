// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library notification.test;

import 'dart:html' hide Notification;
import 'dart:async';
import 'dart:js';
import 'package:unittest/unittest.dart';
import 'package:notification/notification.dart';

//debugger() { context['eval'].apply(['debugger']);}
//debugger() { context['debugger'];}

main() {
  test('constructor exists', () {
    print(Notification.constructor.runtimeType);
    expect(Notification.constructor, isNotNull);
    expect(Notification.constructor is JsObject, isTrue);
  });

//  test("get permission", () {
//    // We can't actually verify getting permission, as that's interactive.
//    // Uncomment this test and run interactively, clicking the button, to
//    // exercise this.
//    var button = querySelector("#b");
//    button.onClick.listen(expectAsync((x) {
//      Future permission = Notification.requestPermission();
//      permission.then(expectAsync((x) => expect(x, 'granted')));
//      expect(permission is Future, isTrue);
//    }));
//    button.click();
//  });

  group('constructors', () {
    // Test that we create the notification and that the parameters have
    // the expected values. Note that these won't actually display, because
    // we haven't asked for permission, which would have to be done
    // interactively, so can't run on a bot.
    var allDefaults;
    var allSpecified;
//    test('outer test 1', () => print('outer test 1'));

    _closeNotifications(_) {
      print("Closing notifications, $allDefaults");
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
      }, expectation);
    });
  });
}
