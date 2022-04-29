import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funesia_clone/presentation/components/cubits/pages/pages_cubit.dart';

class NavigationBarItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final int index;
  const NavigationBarItem(
      {Key? key,
      required this.title,
      required this.iconData,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<PagesCubit>().changePage(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 32,
            color: (context.read<PagesCubit>().state == index)
                ? Colors.blueAccent[700]
                : Colors.grey[600],
          ),
          SizedBox(
            height: 2,
          ),
          Text(title,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w200,
                  color: (context.read<PagesCubit>().state == index)
                      ? Colors.blueAccent[700]
                      : Colors.grey[600]))
        ],
      ),
    );
  }
}
