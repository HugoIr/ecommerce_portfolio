import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funesia_clone/presentation/components/cubits/item_cart_counter/item_cart_counter_cubit.dart';
import 'package:funesia_clone/presentation/components/cubits/item_counter/item_counter_cubit.dart';

class ItemInput extends StatelessWidget {
  final String id;
  final TextEditingController totalItemController;
  const ItemInput(
      {Key? key, required this.id, required this.totalItemController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black38, width: 0.5)),
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Row(
        children: [
          Material(
            child: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () {
                context.read<ItemCartCounterCubit>().decreaseCounter(id);
              },
              child: Container(
                padding: EdgeInsets.all(4),
                child: Image.asset(
                  "assets/icons/minus.png",
                  width: 14,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          BlocBuilder<ItemCartCounterCubit, int>(
            builder: (context, currentCounter) {
              totalItemController.text = currentCounter.toString();
              totalItemController.selection = TextSelection.fromPosition(
                  TextPosition(offset: currentCounter.toString().length));

              return Container(
                width: 40,
                child: TextField(
                  onChanged: (val) {
                    context.read<ItemCartCounterCubit>().changeCounter(val, id);
                  },
                  controller: totalItemController,
                  style: TextStyle(color: Colors.blueAccent[700]),
                  cursorColor: Colors.blueAccent[700],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                  // controller: totalItemController,
                ),
              );
            },
          ),
          SizedBox(width: 8),
          Material(
            child: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () {
                context.read<ItemCartCounterCubit>().increaseCounter(id);
              },
              child: Container(
                padding: EdgeInsets.all(4),
                child: Image.asset(
                  "assets/icons/plus.png",
                  width: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
