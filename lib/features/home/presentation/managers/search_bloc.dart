import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hessa/features/home/data/models/query_model.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  QueryModel initialQuery = QueryModel();

  void setQuery({required QueryModel query}) {
    initialQuery = query;
  }

  SearchBloc() : super(SearchInitial());
}
