import 'dart:ui';

import 'package:expene_analysis/ExpenseDetails/Page/expense_details_page.dart';
import 'package:expene_analysis/RecentsExpenses/Model/expense_model.dart';
import 'package:expene_analysis/RecentsExpenses/ScopedModel/expense_viewmodel.dart';
import 'package:expene_analysis/Shared/repostery.dart';
import 'package:expene_analysis/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scoped_model/scoped_model.dart';

import 'RecentsExpenses/Page/recents_expenses_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // brightness: Brightness.dark,
        primaryColor: Colors.purple,
        accentColor: Colors.purpleAccent[600],
        buttonColor: Colors.purple,

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: HomePage(),
        routes: {
          HomePage.routeName: (context) => HomePage(),
          ExpenseDetails.routeName: (context) => ExpenseDetails(),

        }
    );
  }
}

