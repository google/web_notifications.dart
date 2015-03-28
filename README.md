# notification

A package that implements the Notification API. Mostly an experiment in making
experimental APIs available as packages, rather than needing everything
in dart:html.

## Usage

A simple usage example:

    import 'dart:html';
    import 'package:notification/notification.dart';

    main() {
      if (!Notification.supported) return;
      await Notification.requestPermission();
      new Notification("Hello world", body: "Have a nice day!");
    }

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://example.com/issues/replaceme
