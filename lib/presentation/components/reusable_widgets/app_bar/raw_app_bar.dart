import 'package:flutter/material.dart';

class RawAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget? title;
  const RawAppBar({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        onTap: () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_back,
          // size: 20.sp,
          color: Colors.grey[700],
        ),
      ),
      titleSpacing: 0,
      title: title,
      elevation: 0,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(58);
}
