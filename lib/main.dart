import 'package:flutter/material.dart';
import 'package:funesia_clone/common/utils/db_helper.dart';
import 'package:funesia_clone/presentation/pages/coba/animation.dart';
import 'package:funesia_clone/presentation/pages/homepage/homepage.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  runApp(const Main());
  DBHelper.createTable();
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)),
      home: Homepage(),
    );
  }
}
