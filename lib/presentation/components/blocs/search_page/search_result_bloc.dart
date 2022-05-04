import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:funesia_clone/data/model/remote/item.dart';
import 'package:meta/meta.dart';

part 'search_result_event.dart';
part 'search_result_state.dart';

class SearchResultBloc extends Bloc<SearchResultEvent, SearchResultState> {
  SearchResultBloc() : super(SearchResultInitial()) {
    on<SearchEvent>(_onSearch);
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

    emit(SearchResultLoaded(results: results));
  }
}
