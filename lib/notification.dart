// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// The notification library.
///
/// Implements Notification (
/// https://developer.mozilla.org/en-US/docs/Web/API/notification ) using
/// JS-interop.
library notification;

import 'dart:async';
import 'dart:html';
import 'dart:js';

// TODO(alanknight): What do we do about inheriting from EventTarget.
// TODO(alanknight): Are we happy to just be a wrapper around the JS object?
// Do we have any other choice?
/// Implements Notification (
/// https://developer.mozilla.org/en-US/docs/Web/API/notification ) using
/// JS-interop.
class Notification extends JsInteropEventTarget {
  Notification._basic(title, [options]) {
    native = new JsObject(constructor, [title, options]);
  }

  /// Create a new Notification.
  ///
  /// The resulting [Notification] will have the given [title] and [body] texts.
  /// The text direction [dir] can be one of 'ltr', 'rtl', or 'auto'.
  /// The [tag] is an arbitrary string that can be used to identify the
  /// notification and possibly to replace an existing Notification.
  /// The [lang] is a BCP47 language indicator, e.g. 'en-US'.
  /// The [icon] is a URL String to the icon which may be displayed along
  /// with the notification, if supported.
  factory Notification(String title, {String dir, String lang, String body, String tag, String icon}) {
    var options = new JsObject.jsify(const {});
    if (dir != null) options['dir'] = dir;
    if (lang != null) options['lang'] = lang;
    if (body != null) options['body'] = body;
    if (tag != null) options['tag'] = tag;
    if (icon != null) options['icon'] = icon;

    return new Notification._basic(title, options);
  }

  /// The JS constructor for Notifications.
  static JsObject constructor = context['Notification'];

  /// Are notifications supported on this browser.
  static bool get supported => constructor != null;

  String get title => native['title'];
  String get dir => native['dir'];
  String get lang => native['lang'];
  String get body => native['body'];
  String get tag => native['tag'];
  String get icon => native['icon'];

  Stream<Event> get onClick => clickEvent.forTarget(this);
  Stream<Event> get onClose => closeEvent.forTarget(this);
  Stream<Event> get onError => errorEvent.forTarget(this);
  Stream<Event> get onShow => showEvent.forTarget(this);

  /// This method is used to ask the user for permission for the page to
  /// display notifications.
  ///
  /// This method must be called as the result of a user action
  /// (eg: onclick callback), and cannot be used without it.
  static Future<String> requestPermission() {
    var c = new Completer();
    complete(x) => c.complete(x);
    constructor.callMethod('requestPermission', [complete]);
    return c.future;
  }
  static bool get hasPermission => constructor['permission'] == 'granted';
  static String get permission => constructor['permission'];

  static const EventStreamProvider<Event> clickEvent =
      const EventStreamProvider<Event>('click');
  static const EventStreamProvider<Event> closeEvent =
      const EventStreamProvider<Event>('close');
  static const EventStreamProvider<Event> errorEvent =
      const EventStreamProvider<Event>('error');
  static const EventStreamProvider<Event> showEvent =
      const EventStreamProvider<Event>('show');

  void close() => native.callMethod('close');
}

/// An EventTarget implementation that uses dart:js to talk to a wrapped
/// JS Object.
class JsInteropEventTarget implements EventTarget {

  /// The wrapped JavaScript Object that we delegate to.
  JsObject native;

  Events get on => new Events(this);

  void addEventListener(String type, EventListener listener,
      [bool useCapture]) {
    native.callMethod('addEventListener', [type, listener, useCapture]);
  }

  bool dispatchEvent(Event event) {
    return native.callMethod('dispatchEvent', [event]);
  }
  void removeEventListener(String type, EventListener listener,
      [bool useCapture]) {
    native.callMethod('removeEventListener', [type, listener, useCapture]);
  }
}
