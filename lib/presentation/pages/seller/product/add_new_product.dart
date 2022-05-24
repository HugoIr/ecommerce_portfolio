import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funesia_clone/common/constant.dart';
import 'package:funesia_clone/common/utils/commonUrl.dart';
import 'package:funesia_clone/data/model/remote/item.dart';
import 'package:funesia_clone/presentation/components/blocs/product/product_bloc.dart';
import 'package:funesia_clone/presentation/components/blocs/user/user_bloc.dart';
import 'package:funesia_clone/presentation/components/cubits/file_path/file_path_cubit.dart';
import 'package:funesia_clone/presentation/components/cubits/item_counter/item_counter_cubit.dart';
import 'package:funesia_clone/presentation/components/cubits/type_message/type_message_cubit.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/app_bar/raw_app_bar.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/reusable_widget_main_page.dart';
import 'package:funesia_clone/services/product/product_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class AddNewProduct extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController discountController = TextEditingController();

  final int maxNameLength = 255;
  final int maxDescriptionLength = 3000;
  final uuid = Uuid();
  AddNewProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FilePathCubit(),
        ),
        BlocProvider(
          create: (context) => ProductBloc(productService: ProductService()),
        ),
      ],
      child: Scaffold(
        appBar: RawAppBar(
          title: Text("Add Product", style: appBarStyle),
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
          child: Container(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blueAccent[700]!,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.blueAccent[700]),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is UserLoaded && state.userInfo!.isSeller) {
                        return InkWell(
                          onTap: () async {
                            if (nameController.text.isNotEmpty &&
                                priceController.text.isNotEmpty &&
                                stockController.text.isNotEmpty &&
                                descriptionController.text.isNotEmpty) {
                              Item item = Item(
                                id: uuid.v4(),
                                idSeller: state.userInfo!.uid,
                                sellerName: state.userInfo!.email,
                                name: nameController.text,
                                price: double.parse(priceController.text),
                                discount: (discountController.text.isNotEmpty)
                                    ? double.parse(discountController.text)
                                    : null,
                                stock: int.parse(stockController.text),
                                url: "$dummyPic/200",
                              );
                              BlocProvider.of<ProductBloc>(context)
                                ..add(CreateProductEvent(item: item));
                            }
                            // await FirebaseAnalytics.instance
                            //     .logBeginCheckout(
                            //         value: 10.0,
                            //         currency: 'USD',
                            //         items: [
                            //           AnalyticsEventItem(
                            //             itemName: 'SEPATUU',
                            //             itemId: 'xjw7123123123ndnw',
                            //             price: 102312.0,
                            //           ),
                            //         ],
                            //         coupon: '10PERCENTOFF')
                            //     .catchError((error) {
                            //   print("ERRROR //");
                            // }).whenComplete(() => print("COMPLETE"));

                            // await FirebaseAnalytics.instance
                            //     .logSelectContent(
                            //       contentType: "imagedsadasdas",
                            //       itemId: "itemId",
                            //     )
                            //     .whenComplete(() => print("COMPLETE content"));
                            // print("${await FirebaseAnalytics.instance}");
                            // await FirebaseAnalytics.instance.logEvent(
                            //     name: "LOG_hugo",
                            //     parameters: {
                            //       "tes": 1
                            //     }).whenComplete(() => print("Log events"));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.blueAccent[700],
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              "Publish",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 16.sp, horizontal: 16.sp),
                    child: BlocBuilder<FilePathCubit, FilePathState>(
                      builder: (context, state) {
                        if (state is FilePathInitial) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: GestureDetector(
                                  onTap: () async {
                                    final ImagePicker _picker = ImagePicker();
                                    final XFile? image = await _picker
                                        .pickImage(source: ImageSource.gallery);

                                    if (image != null) {
                                      print("IMAGE ${image.path}");

                                      context
                                          .read<FilePathCubit>()
                                          .changeFilePath(image.path);
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(20.sp),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.blueAccent[700]!)),
                                    alignment: Alignment.center,
                                    child: Text("+ Add Photo"),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else if (state is FilePathLoaded) {
                          return Image.file(File(state.path));
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16.sp,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.sp, horizontal: 16.w),
                    color: Colors.white,
                    child: CustomTextField(
                      labelText: "Product Name",
                      isRequired: true,
                      hintText: "Enter Product Name",
                      controller: nameController,
                      maxLength: maxNameLength,
                    ),
                  ),
                  SizedBox(
                    height: 16.sp,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.sp, horizontal: 16.w),
                    color: Colors.white,
                    child: CustomTextField(
                      labelText: "Product Description",
                      isRequired: true,
                      hintText: "Enter Product Description",
                      controller: descriptionController,
                      maxLength: maxDescriptionLength,
                    ),
                  ),
                  SizedBox(
                    height: 16.sp,
                  ),
                  rowInputNumber(
                    asset: "assets/seller/price_tag.png",
                    title: "Price",
                    controller: priceController,
                    isForPrice: true,
                  ),
                  Divider(
                    height: 0.05,
                    thickness: 0.5,
                  ),
                  rowInputNumber(
                    asset: "assets/seller/layers.png",
                    title: "Stock",
                    controller: stockController,
                  ),
                  Divider(
                    height: 0.05,
                    thickness: 0.5,
                  ),
                  rowInputNumber(
                    asset: "assets/seller/discount_tag.png",
                    title: "Discount",
                    controller: discountController,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container rowInputNumber({
    required String asset,
    required String title,
    required TextEditingController controller,
    bool isForPrice = false,
    String hintText = "Set",
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.sp, horizontal: 16.w),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                asset,
                width: 20.sp,
              ),
              SizedBox(
                width: 8.w,
              ),
              Text.rich(
                TextSpan(text: title, style: normalTextStyle, children: [
                  TextSpan(
                      text: "  *",
                      style: normalTextStyle.copyWith(color: Colors.red[600]))
                ]),
              ),
            ],
          ),
          Container(
            width: 170.w,
            child: TextFormField(
              style: mediumTextStyle,
              textDirection: TextDirection.rtl,
              controller: controller,
              maxLength: 20,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  counterText: "",
                  hintText: "Set",
                  hintStyle: mediumHintTextStyle,
                  hintTextDirection: TextDirection.rtl,
                  isCollapsed: true,
                  border: InputBorder.none),
            ),
          )
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final int maxLength;
  final String labelText;
  final bool isRequired;
  final String hintText;
  final TextEditingController controller;

  CustomTextField({
    Key? key,
    required this.labelText,
    this.isRequired = false,
    required this.hintText,
    required this.maxLength,
    required this.controller,
  }) : super(key: key);

  ItemCounterCubit itemCounterCubit = ItemCounterCubit(initialCount: 0);
  TypeMessageCubit typeMessageCubit = TypeMessageCubit();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => itemCounterCubit,
        ),
        BlocProvider(
          create: (context) => typeMessageCubit,
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(text: labelText, style: normalTextStyle, children: [
                  TextSpan(
                      text: "  *",
                      style: normalTextStyle.copyWith(color: Colors.red[600]))
                ]),
              ),
              BlocBuilder<ItemCounterCubit, int>(
                builder: (context, counter) {
                  return Text(
                    "$counter/$maxLength",
                    style: subDisableTextStyle.copyWith(fontSize: 14.sp),
                  );
                },
              )
            ],
          ),
          SizedBox(
            height: 16.sp,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please $hintText";
              }
            },
            onChanged: (val) {
              itemCounterCubit.changeCounter(val.length);
              typeMessageCubit.onType(val);
            },
            style: mediumTextStyle,
            controller: controller,
            maxLength: maxLength,
            cursorColor: Colors.grey[600],
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
                counterText: "",
                isDense: true,
                isCollapsed: true,
                contentPadding: EdgeInsets.only(right: 16.sp),
                hintText: hintText,
                hintStyle: mediumHintTextStyle,
                border: InputBorder.none,
                suffixIconConstraints: BoxConstraints.tight(Size(18.sp, 18.sp)),
                suffixIcon: BlocBuilder<TypeMessageCubit, bool>(
                  builder: (context, isType) {
                    if (isType) {
                      return GestureDetector(
                        onTap: () {
                          controller.clear();
                          typeMessageCubit.onType(controller.text);
                        },
                        child: Image.asset(
                          "assets/icons/clear.png",
                          width: 18.sp,
                          color: Colors.black38,
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                )),
          ),
        ],
      ),
    );
  }
}
