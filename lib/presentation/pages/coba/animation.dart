import 'dart:math';

import 'package:flutter/material.dart';
import 'package:funesia_clone/common/utils/db_helper.dart';
import 'package:funesia_clone/data/model/local/animal.dart';

class AnimatedBox extends StatefulWidget {
  const AnimatedBox({Key? key}) : super(key: key);

  @override
  State<AnimatedBox> createState() => _AnimatedBoxState();
}

class _AnimatedBoxState extends State<AnimatedBox> {
  bool isShown = false;
  double _width = 50;
  double _height = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: AnimatedContainer(
                width: _width,
                height: _height,
                color: Colors.amber,
                duration: const Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    // isShown = !isShown;
                    _width = Random().nextInt(200).toDouble();
                    _height = Random().nextInt(200).toDouble();
                    print(DBHelper.getAnimals());
                  });
                },
                child: Text("animating")),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    print(DBHelper.insertDB(
                        Animal(id: Random().nextInt(100), name: "cat")));
                  });
                },
                child: Text("insert"))
          ],
        ),
      ),
    );
  }
}
