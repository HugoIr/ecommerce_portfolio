import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funesia_clone/data/model/remote/item.dart';
import 'package:funesia_clone/presentation/components/blocs/for_you/for_you_bloc.dart';
import 'package:funesia_clone/services/user/user_service.dart';
import 'package:meta/meta.dart';

part 'search_result_event.dart';
part 'search_result_state.dart';

class SearchResultBloc extends Bloc<SearchResultEvent, SearchResultState> {
  UserService userService;
  BuildContext context;
  SearchResultBloc({
    required this.userService,
    required this.context,
  }) : super(SearchResultInitial()) {
    on<SearchEvent>(_onSearch);
    on<RefreshSearchEvent>(_onRefreshSearch);
  }

  FutureOr<void> _onSearch(
      SearchEvent event, Emitter<SearchResultState> emit) async {
    emit(SearchResultLoading());
    await Future.delayed(
      Duration(milliseconds: 300),
    );
    print("_onSearch");

    final state = BlocProvider.of<ForYouBloc>(context).state;
    print("State foryoubloc inside searchresult bloc : $state");
    if (state is LoadedForYouState) {
      // just a quick note: object Item yg ada disini itu sama dengan
      // Object Item yg telah diolah di ForYouBloc
      List<Item> results = state.listsItem
          .where((item) => item.name.toLowerCase().contains(event.keyword))
          .toList();
      print(results);
      emit(SearchResultLoaded(results: results));
    } else {
      emit(SearchResultNotFound());
    }

    // var listsId = await userService.getListsId();
    // results = results.map((item) {
    //   if (listsId.contains(item.id.toString())) {
    //     // print("selected item id ${item.id}");
    //     item.isSelected = true;
    //   }
    //   return item;
    // }).toList();
  }

  FutureOr<void> _onRefreshSearch(
      RefreshSearchEvent event, Emitter<SearchResultState> emit) async {
    final state = this.state;

    if (state is SearchResultLoaded) {
      emit(SearchResultLoaded(results: state.results));
    }
  }
}
