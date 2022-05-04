import 'package:flutter/material.dart';

class FilterSheet extends StatelessWidget {
  const FilterSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DraggableScrollableSheet(
        // expand: false,
        // snap: true,
        initialChildSize: 0.8,
        minChildSize: 0.4,
        maxChildSize: 0.8,
        builder: (context, scrollController) {
          return Container(
            width: double.infinity,
            height: 100,
            color: Colors.amber,
          );
        },
      ),
    );
  }
}
