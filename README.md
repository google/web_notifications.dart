# web_notifications

[![Build Status](https://travis-ci.org/google/web_notifications.dart.svg?branch=master)](https://travis-ci.org/google/web_notifications.dart)

A package that implements the Notification API. Somewhat of an
experiment in making new/experimental APIs available as packages,
rather than having everything in `dart:html`.

## Usage

A simple usage example:

```dart
import 'dart:html' hide Notification;
import 'package:notification/notification.dart';

main() async {
  if (!Notification.supported) return;
  await Notification.requestPermission();
  new Notification("Hello world", body: "Have a nice day!");
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/google/web_notifications.dart/issues
