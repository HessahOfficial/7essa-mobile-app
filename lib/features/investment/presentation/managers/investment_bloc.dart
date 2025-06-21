import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/investment/data/models/get_all_investments_request.dart';
import 'package:hessa/features/investment/data/models/get_all_investments_response.dart';
import 'package:hessa/features/investment/data/models/investment_model.dart';
import 'package:hessa/features/investment/data/repositories/investment_service.dart';
import 'package:hessa/features/settings/presentation/views/widgets/custom_info_popup.dart';

part 'investment_event.dart';
part 'investment_state.dart';

class InvestmentBloc extends Bloc<InvestmentEvent, InvestmentState> {
  final InvestmentService service;

  List<InvestmentModel> investments = [];

  int selectedIndex = 0;

  void setSelectedIndex(int index) {
    selectedIndex = index;
    emit(DisplayInvestment());
  }

  void checkIsInvestor(BuildContext screenContext) {
    final currentUser = getIt.get<HiveHelper>().currentUser;
    bool isInvestor = false;
    if (isInvestor) {
    } else {
      showDialog(
        context: screenContext,
        builder:
            (context) => CustomInfoPopup(
              icon: Icons.cancel_rounded,
              height: 170,
              message:
                  "You are not Investor yet! you need to become investor first.",
              textButton: "Ok",
              onPressed: () => screenContext.pop(),
            ),
      );
    }
  }

  InvestmentBloc({required this.service}) : super(InvestmentInitial()) {
    on<GetAllInvestmentsEvent>((event, emit) async {
      emit(GetAllInvestmentsLoading());
      final response = await service.getAllInvestment(request: event.request);
      response.fold(
        (failure) {
          emit(GetAllInvestmentsFailure(message: failure.message));
        },
        (data) {
          investments = data.investments;
          emit(GetAllInvestmentsSuccess(response: data));
        },
      );
    });
  }
}
