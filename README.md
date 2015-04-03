# notification

A package that implements the Notification API. Somewhat of an
experiment in making new/experimental APIs available as packages,
rather than having everything in dart:html.

## Usage

A simple usage example:

    import 'dart:html' hide Notification;
    import 'package:notification/notification.dart';

    main() {
      if (!Notification.supported) return;
      await Notification.requestPermission();
      new Notification("Hello world", body: "Have a nice day!");
    }

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/google/notification.dart/issues
