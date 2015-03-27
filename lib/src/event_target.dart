// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// The notification library.
///
/// Implements Notification (
/// https://developer.mozilla.org/en-US/docs/Web/API/notification ) using
/// JS-interop.
library event_target;

import 'dart:async';
import 'dart:html';
import 'dart:js';

class EventTarget {

  static bool get supported => constructor != null;

  factory Notification.raw(title, [options]) {
    return new JsObject(constructor, [title, options]);
  }

  // To suppress missing implicit constructor warnings.
  factory Notification._() { throw new UnsupportedError("Not supported"); }


  factory Notification(title, {dir, lang, body, tag, icon}) {
    var options = {}; // ### make this a JS map to start with
    if (dir != null) options['dir'] = dir;
    if (lang != null) options['lang'] = lang;
    if (body != null) options['body'] = body;
    if (tag != null) options['tag'] = dir;
    if (icon != null) options['icon'] = dir;

    return new Notification.raw(title, options);
  }

  static JsObject constructor = context['Notification'];


  String title;
  Stream<Event> onClick;
  Stream<Event> onClose;
  Stream<Event> onError;
  Stream<Event> onShow;

  static requestPermission() => null;
  static get permission => true; /// ####

  static const EventStreamProvider<Event> clickEvent = null;
  static const EventStreamProvider<Event> closeEvent = null;
  static const EventStreamProvider<Event> errorEvent = null;
  static const EventStreamProvider<Event> showEvent = null;


  void close() => null;
}
