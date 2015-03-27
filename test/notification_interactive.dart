// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library notification.test;

import 'dart:async';
import 'dart:html' hide Notification;
import 'dart:js';
import 'package:unittest/unittest.dart';
import 'package:notification/notification.dart';

//debugger() { context['eval'].apply(['debugger']);}
//debugger() { context['debugger'];}

main() {

    var b = querySelector("#b");

    var n = new Notification("Hello there");
    n.addEventListener('click',
        (_) => print("called"));
    var provider = new EventStreamProvider('click');
    var stream = provider.forTarget(n);
    var subscription = stream.listen((x) =>
       print("we heard you"));
    b.onClick.listen((x) =>
      print("Got click event $x"));

}
