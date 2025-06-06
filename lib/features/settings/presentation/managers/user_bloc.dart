import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hessa/features/settings/data/models/get_info_request.dart';
import 'package:hessa/features/settings/data/models/get_info_response.dart';
import 'package:hessa/features/settings/data/repositories/user_service.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService service;

  UserBloc({required this.service}) : super(UserInitial()) {
    on<GetInfoEvent>((event, emit) async {});
  }
}
