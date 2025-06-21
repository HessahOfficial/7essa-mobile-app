import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hessa/features/auth/data/models/user_model.dart';
import 'package:hessa/features/home/data/models/get_all_partners_request.dart';
import 'package:hessa/features/home/data/models/get_all_partners_response.dart';
import 'package:hessa/features/settings/data/models/become_investor_request.dart';
import 'package:hessa/features/settings/data/models/become_investor_response.dart';
import 'package:hessa/features/settings/data/models/change_pin_request.dart';
import 'package:hessa/features/settings/data/models/change_pin_response.dart';
import 'package:hessa/features/settings/data/models/update_user_request.dart';
import 'package:hessa/features/settings/data/models/update_user_response.dart';
import 'package:hessa/features/settings/data/repositories/user_service.dart';
import 'package:hessa/features/settings/presentation/views/widgets/custom_pin_dialog.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService service;

  bool isUpdate = false;

  List<UserModel> partnres = [];

  void updateDetails({required bool isUpdate}) {
    this.isUpdate = isUpdate;
    emit(ActiveUpdate());
  }

  void showPinDialog({required BuildContext context}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CustomPinDialog(),
    );
  }

  UserBloc({required this.service}) : super(UserInitial()) {
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

    on<UpdateUserEvent>((event, emit) async {
      emit(UpdateUserLoading());
      final response = await service.updateUser(request: event.request);
      response.fold(
        (failure) {
          print(failure);
          emit(UpdateUserFailure(message: failure.message));
        },
        (data) {
          print(data);
          isUpdate = false;
          emit(UpdateUserSuccess(response: data));
        },
      );
    });

    on<UpdateAvatarEvent>((event, emit) async {
      emit(UpdateAvatarLoading());
      final response = await service.updateUser(request: event.request);
      response.fold(
        (failure) {
          print(failure);
          emit(UpdateAvatarFailure(message: failure.message));
        },
        (data) {
          print(data);
          isUpdate = false;
          emit(UpdateAvatarSuccess(response: data));
        },
      );
    });

    on<GetAllPartnersEvent>((event, emit) async {
      emit(GetAllPartnersLoading());
      final response = await service.getPartners(request: event.request);
      response.fold(
        (failure) {
          print(failure);
          emit(GetAllPartnersFailure(message: failure.message));
        },
        (data) {
          print(data);
          partnres = data.partners;
          emit(GetAllPartnersSuccess(response: data));
        },
      );
    });
  }
}
