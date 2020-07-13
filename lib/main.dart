import 'package:flutter/material.dart';
import 'package:authorizeit/pages/home.dart';
import 'package:authorizeit/pages/loading.dart';
import 'package:authorizeit/pages/authorized.dart';
import 'package:authorizeit/pages/error.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => Home(),
    '/loading': (context) => Loading(),
    '/authorized': (context) => Authorized(),
    '/error': (context) => Error(),
  },
));