import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funesia_clone/presentation/components/blocs/chat/chat_bloc.dart';
import 'package:funesia_clone/presentation/components/cubits/type_message/type_message_cubit.dart';

class ChatRoom extends StatefulWidget {
  final String sellerName;

  ChatRoom({Key? key, required this.sellerName}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController chatController = TextEditingController();

  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    // _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    super.initState();
  }

  Future scrollToTheEnd(int delayed) async {
    await Future.delayed(Duration(milliseconds: delayed));
    print("OFFSET ${_scrollController.offset}");
    print("maxextent ${_scrollController.position.maxScrollExtent}");
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    scrollToTheEnd(300);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // bottomNavigationBar: chatInput(context),
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey[700],
            ),
          ),
          titleSpacing: 0,
          title: Row(children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey[400]),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "assets/profile/smile_face.png",
                width: 20,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              widget.sellerName,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]),
            )
          ])),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoaded) {
            return Stack(children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width,
                    maxHeight: MediaQuery.of(context).size.height),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 16, right: 16, top: 10.w, bottom: 58.w),
                  child: BlocBuilder<ChatBloc, ChatState>(
                    builder: (context, state) {
                      if (state is ChatLoaded) {
                        scrollToTheEnd(0);
                        return ListView.separated(
                            padding: EdgeInsets.only(bottom: 10.w),
                            controller: _scrollController,
                            shrinkWrap: true,
                            itemCount: state.chatChannel.messages.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 20.sp,
                              );
                            },
                            itemBuilder: (context, index) {
                              return Row(
                                textDirection: (state.chatChannel
                                            .messages[index]["idTo"] ==
                                        state.idTo)
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                children: [
                                  Flexible(
                                      child: _chatBox(
                                          state: state,
                                          index: index,
                                          isMe: state.chatChannel
                                                  .messages[index]["idTo"] ==
                                              state.idTo)),
                                  const SizedBox(
                                    width: 80,
                                  )
                                ],
                              );
                            });
                      } else if (state is ChatInitial) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                ),
              ),
              Positioned(
                  right: 0, left: 0, bottom: 10.w, child: chatInput(context)),
            ]);
          } else if (state is ChatInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }

  Widget chatInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 0.5),
                    blurRadius: 1,
                    spreadRadius: 0,
                    blurStyle: BlurStyle.solid,
                    color: Colors.black12)
              ]),
          width: 300,
          height: 42,
          child: TextField(
            onTap: () async {
              await scrollToTheEnd(500);
            },
            onChanged: (val) {
              context.read<TypeMessageCubit>().onType(val);
            },
            cursorColor: Colors.grey[600],
            controller: chatController,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                isDense: true,
                isCollapsed: true,
                hintText: "Message",
                hintStyle: TextStyle(color: Colors.grey[600]!.withOpacity(0.6)),
                border: OutlineInputBorder(borderSide: BorderSide.none),
                prefixIcon: Icon(
                  Icons.tag_faces_rounded,
                  size: 24,
                  color: Colors.black45,
                ),
                suffixIcon: Icon(
                  Icons.add_circle_outline_rounded,
                  size: 24,
                  color: Colors.black45,
                )),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        BlocBuilder<TypeMessageCubit, bool>(
          builder: (context, isType) {
            return InkWell(
              onTap: () {
                if (isType) {
                  context.read<ChatBloc>()
                    ..add(SendChatEvent(content: chatController.text, type: 1));

                  chatController.clear();
                }
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isType
                        ? Colors.blueAccent[700]
                        : Colors.grey[300]!.withOpacity(0.6)),
                child: Icon(
                  Icons.send_rounded,
                  color: isType ? Colors.white : Colors.white.withOpacity(0.6),
                  size: 20,
                ),
              ),
            );
          },
        )
      ]),
    );
  }

  Widget _chatBox(
      {required ChatLoaded state, required int index, required bool isMe}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
          color: isMe ? Colors.lightGreenAccent[100] : Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topRight: isMe ? Radius.circular(0) : Radius.circular(20),
            topLeft: isMe ? Radius.circular(20) : Radius.circular(0),
          )),
      child: Text(state.chatChannel.messages[index]["content"]),
    );
  }
}
