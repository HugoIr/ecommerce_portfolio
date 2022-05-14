import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funesia_clone/presentation/components/blocs/cart/cart_bloc.dart';
import 'package:funesia_clone/presentation/components/cubits/item_cart_counter/item_cart_counter_cubit.dart';
import 'package:funesia_clone/presentation/components/cubits/item_counter/item_counter_cubit.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/checkout/item_input.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/reusable_widget_main_page.dart';
import 'package:funesia_clone/services/user/user_service.dart';

class Checkout extends StatelessWidget {
  Checkout({Key? key}) : super(key: key);
  final List<TextEditingController> _listController = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey[600],
          ),
        ),
        title: Text(
          "Keranjang",
          style: TextStyle(color: Colors.grey[600], fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  print("State cart $state");
                  if (state is LoadedCartState) {
                    return ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: ((context, index) => const SizedBox(
                              height: 36,
                            )),
                        itemCount: state.listsItem.length,
                        itemBuilder: (context, index) {
                          _listController.add(TextEditingController());

                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                headerItem(),
                                space(),
                                mainItem(
                                  name: state.listsItem[index].name,
                                  price: state.listsItem[index].price,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "Tulis Catatan",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.green[600]),
                                ),
                                space(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Tambah ke wishlist",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[500]),
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: (() {
                                            print("cliecked");
                                            context.read<CartBloc>()
                                              ..add(RemoveCartItemEvent(
                                                  id: state.listsItem[index].id,
                                                  index: index));
                                          }),
                                          child: Image.asset(
                                            'assets/icons/bin.png',
                                            color: Colors.grey[700],
                                            width: 18,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        BlocProvider(
                                          create: (context) =>
                                              ItemCartCounterCubit(
                                                  userService: UserService(
                                                      firebaseFirestore:
                                                          FirebaseFirestore
                                                              .instance))
                                                ..changeCounter(
                                                  state.listsItem[index].total
                                                      .toString(),
                                                  state.listsItem[index].id,
                                                ),
                                          child: ItemInput(
                                            id: state.listsItem[index].id,
                                            totalItemController:
                                                _listController[index],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        });
                  } else if (state is CartInitial) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Row mainItem({
    required String name,
    required double price,
    String url = "https://picsum.photos/100",
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.check_box_outline_blank_rounded,
          color: Colors.grey[600],
        ),
        SizedBox(width: 16),
        Image.network(
          url,
          width: 75,
        ),
        SizedBox(width: 12),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(overflow: TextOverflow.ellipsis),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Sisa 3",
                style: TextStyle(fontSize: 12, color: Colors.red[900]),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Rp${price.toInt().toString()}",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )
      ],
    );
  }

  Row headerItem() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check_box_outline_blank_rounded,
          color: Colors.grey[600],
        ),
        SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                officialStoreIcon(),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Rumah Kaos Bandung",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Kab. Bogor",
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            )
          ],
        ),
      ],
    );
  }
}