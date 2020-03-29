import 'package:flutter/material.dart';
import 'package:timeapp/pages/choise.dart';
import 'package:timeapp/pages/loading.dart';
import 'pages/home.dart';

void main() => runApp(MaterialApp(
  initialRoute: "/",
  routes: {
    '/':(context)=>Loading(),
    '/home':(context)=>Home(),
    '/location':(context)=>Choise(),
  },
));

