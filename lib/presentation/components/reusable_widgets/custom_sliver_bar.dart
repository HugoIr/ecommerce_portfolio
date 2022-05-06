import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funesia_clone/presentation/components/blocs/search_page/search_result_bloc.dart';

class CustomSliverBar extends StatelessWidget {
  final Widget child;
  final Widget? header;
  final Widget? leading;
  final Color? bgColor;
  final List<Widget>? appBarActions;
  final double? expandedHeight;
  TextEditingController controller = TextEditingController();
  CustomSliverBar({
    Key? key,
    required this.child,
    this.bgColor,
    this.leading,
    this.header,
    this.appBarActions,
    this.expandedHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverAppBar(
          backgroundColor: bgColor ?? Colors.white,
          pinned: true,
          centerTitle: true,
          expandedHeight: expandedHeight ?? 240.w,
          titleSpacing: 4,
          elevation: 1,
          toolbarHeight: 58,
          title: Container(
              child: Row(
            children: [
              Image.asset(
                "assets/icons/search.png",
                width: 22,
                color: Colors.grey[600],
              ),
              SizedBox(
                width: 8,
              ),
              Container(
                width: 180,
                height: 40,
                alignment: Alignment.center,
                child: TextField(
                  onSubmitted: (value) {
                    print("helo $value");
                    // BlocProvider.of<SearchResultBloc>(context)
                    //   ..add(SearchEvent(keyword: value));
                    context.read<SearchResultBloc>()
                      ..add(SearchEvent(keyword: value));
                  },
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  textInputAction: TextInputAction.go,
                  cursorColor: Colors.grey[500],
                  cursorHeight: 20,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      isCollapsed: true,
                      contentPadding: EdgeInsets.all(8)),
                  controller: controller,
                ),
              )
            ],
          )),
          leading: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey[600],
            ),
          ),
          actions: [
            Icon(
              Icons.favorite_border_rounded,
              color: Colors.grey[600],
            ),
            SizedBox(
              width: 12,
            ),
            Icon(
              Icons.shopping_cart_rounded,
              color: Colors.grey[600],
            ),
            SizedBox(
              width: 20,
            )
          ],
          flexibleSpace: header,
        ),
        SliverToBoxAdapter(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            ),
            child: Column(
              children: [SizedBox(height: 8.w), this.child],
            ),
          ),
        ),
      ],
    );
  }
}
