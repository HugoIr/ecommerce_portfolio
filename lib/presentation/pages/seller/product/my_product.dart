import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funesia_clone/common/constant.dart';
import 'package:funesia_clone/presentation/components/blocs/for_you/for_you_bloc.dart';
import 'package:funesia_clone/presentation/components/blocs/seller/my_product/my_product_bloc.dart';
import 'package:funesia_clone/presentation/components/blocs/user/user_bloc.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/app_bar/raw_app_bar.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/seller/product_item.dart';
import 'package:funesia_clone/presentation/pages/seller/product/add_new_product.dart';

class MyProduct extends StatelessWidget {
  const MyProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RawAppBar(
        title: Text(
          "My Product",
          style: appBarStyle,
        ),
      ),
      bottomNavigationBar: Container(
        height: 55,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              offset: Offset(0, 1),
              blurStyle: BlurStyle.outer,
              spreadRadius: 2,
              blurRadius: 1,
              // color: Color.fromARGB(255, 227, 225, 225),
              color: Colors.black26)
        ]),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (builder) => AddNewProduct(
                          myProductContext: context,
                        )));
          },
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.blueAccent[700],
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              "Add New Product",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(child: Container(
        // padding: EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<MyProductBloc, MyProductState>(
          builder: (context, state) {
            if (state is MyProductLoaded) {
              if (state.listsItem.isEmpty) {
                return Padding(
                  padding: EdgeInsets.only(top: 20.sp),
                  child: Center(child: Text("There is no added product")),
                );
              }
              return ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 16.sp),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.listsItem.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 16.sp,
                    );
                  },
                  itemBuilder: (context, index) {
                    return ProductItem(
                      text: state.listsItem[index].name,
                      price: state.listsItem[index].price,
                      url: state.listsItem[index].url,
                      stock: state.listsItem[index].stock!,
                      sold: state.listsItem[index].sold,
                      // text: state.listsItem[index].name,
                      // price: state.listsItem[index].price,
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      )),
    );
  }
}
