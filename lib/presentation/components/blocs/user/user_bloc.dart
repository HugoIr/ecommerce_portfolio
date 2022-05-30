import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:funesia_clone/data/model/remote/user.dart';
import 'package:funesia_clone/services/user/user_service.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserService userService;
  UserBloc({required this.userService}) : super(UserInitial()) {
    on<GetUserInformationEvent>(_onGetUserInformationEvent);
    on<BecomeSellerEvent>(_onBecomeSellerEvent);
  }

  void _onGetUserInformationEvent(
      GetUserInformationEvent event, Emitter<UserState> emit) async {
    bool isSeller = await userService.isSeller();
    var currentUserInfo = await userService.getCurrentUserInfo();
    print("currentUserInfo bloc $currentUserInfo");
    if (currentUserInfo != null) {
      emit(UserLoaded(
          isSeller: isSeller, userInfo: currentUserInfo as UserInformation));
    } else {
      emit(UserLoaded(isSeller: isSeller, userInfo: null));
    }
  }

  void _onBecomeSellerEvent(BecomeSellerEvent event, Emitter<UserState> emit) {
    final state = this.state;
    if (state is UserLoaded) {
      userService.becomeSeller();
      UserInformation userInfo = state.userInfo!;
      userInfo.isSeller = true;
      print("BEcome seller");
      emit(UserLoaded(isSeller: true, userInfo: userInfo));
    }
  }
}
