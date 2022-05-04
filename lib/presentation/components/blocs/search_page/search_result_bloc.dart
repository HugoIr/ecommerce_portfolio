import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:funesia_clone/data/model/remote/item.dart';
import 'package:funesia_clone/services/user/user_service.dart';
import 'package:meta/meta.dart';

part 'search_result_event.dart';
part 'search_result_state.dart';

class SearchResultBloc extends Bloc<SearchResultEvent, SearchResultState> {
  UserService userService;
  SearchResultBloc({required this.userService}) : super(SearchResultInitial()) {
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
    List<Item> results = dummyItemsList
        .where((item) => item.name.toLowerCase().contains(event.keyword))
        .toList();
    print(results);

    var listsId = await userService.getListsId();
    results = results.map((item) {
      if (listsId.contains(item.id.toString())) {
        print("selected item id ${item.id}");
        item.isSelected = true;
      }
      return item;
    }).toList();

    emit(SearchResultLoaded(results: results));
  }

  FutureOr<void> _onRefreshSearch(
      RefreshSearchEvent event, Emitter<SearchResultState> emit) async {
    final state = this.state;

    if (state is SearchResultLoaded) {
      var listsId = await userService.getListsId();
      final results = state.results.map((item) {
        if (listsId.contains(item.id.toString())) {
          print("selected item id ${item.id}");
          item.isSelected = true;
        }
        return item;
      }).toList();

      emit(SearchResultLoaded(results: results));
    }
  }
}
