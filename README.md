# notification

A library for Dart developers. It is awesome.

## Usage

A simple usage example:

    import 'dart:html';
    import 'package:notification/notification.dart';

    main() {
      if (!Notification.supported) return;
      await Notification.requestPermission();
      new Notification.helloWorld();
    }

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://example.com/issues/replaceme
