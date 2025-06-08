import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hessa/features/settings/data/models/become_investor_request.dart';
import 'package:hessa/features/settings/data/models/become_investor_response.dart';
import 'package:hessa/features/settings/data/models/change_pin_request.dart';
import 'package:hessa/features/settings/data/models/change_pin_response.dart';
import 'package:hessa/features/settings/data/models/get_info_request.dart';
import 'package:hessa/features/settings/data/models/get_info_response.dart';
import 'package:hessa/features/settings/data/repositories/user_service.dart';
import 'package:hessa/features/settings/presentation/views/widgets/custom_info_popup.dart';
import 'package:hessa/features/settings/presentation/views/widgets/custom_pin_dialog.dart';
import 'package:hessa/generated/l10n.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService service;

  void showPinDialog({required BuildContext context}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CustomPinDialog(),
    );
  }

  UserBloc({required this.service}) : super(UserInitial()) {
    on<GetInfoEvent>((event, emit) async {
      emit(UserInfoLoading());
      final response = await service.getUserInfo(request: event.request);
      response.fold(
        (failure) {
          print(failure);
          emit(UserInfoFailure(message: failure.message));
        },
        (data) {
          print(data);
          emit(UserInfoSuccess(response: data));
        },
      );
    });

    on<ChangePinEvent>((event, emit) async {
      emit(ChangePinLoading());
      final response = await service.changeUserPin(request: event.request);
      response.fold(
        (failure) {
          print(failure);
          emit(ChangePinFailure(message: failure.message));
        },
        (data) {
          print(data);
          emit(ChangePinSuccess(response: data));
        },
      );
    });

    on<BecomeInvestorEvent>((event, emit) async {
      emit(BecomeInvestorLoading());
      final response = await service.becomeInvestor(request: event.request);
      response.fold(
        (failure) {
          print(failure);
          emit(BecomeInvestorFailure(message: failure.message));
        },
        (data) {
          print(data);
          emit(BecomeInvestorSuccess(response: data));
        },
      );
    });
  }
}
