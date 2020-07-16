import 'package:flutter/material.dart';
import 'package:authorizeit/pages/home.dart';
import 'package:authorizeit/pages/loading.dart';
import 'package:authorizeit/pages/authorized.dart';
import 'package:authorizeit/pages/error.dart';
import 'package:authorizeit/pages/info.dart';
import 'package:authorizeit/Shared/constants.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/',
  routes: {
    '/': (context) => Home(),
    '/info': (context) => Info(),
    '/loading': (context) => Loading(),
    '/authorized': (context) => Authorized(),
    '/error': (context) => Error(),
  },
));