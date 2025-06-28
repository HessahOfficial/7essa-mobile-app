import 'package:bloc/bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/home/data/models/property_model.dart';
import 'package:hessa/features/investment/data/models/get_all_investments_request.dart';
import 'package:hessa/features/investment/data/models/get_all_investments_response.dart';
import 'package:hessa/features/investment/data/models/investment_model.dart';
import 'package:hessa/features/investment/data/models/make_investment_request.dart';
import 'package:hessa/features/investment/data/models/make_investment_response.dart';
import 'package:hessa/features/investment/data/repositories/investment_service.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_confirm_bottom_sheet.dart';
import 'package:hessa/features/settings/presentation/views/widgets/custom_info_popup.dart';
import 'package:path/path.dart';

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

  List<PieChartSectionData> getPieChartSections() {
    double totalInvestmentsAmount = 0;
    for (var investment in investments) {
      totalInvestmentsAmount += investment.investmentAmount!;
    }

    List<PieChartSectionData> sections = [];
    for (int i = 0; i < investments.length; i++) {
      sections.add(
        PieChartSectionData(
          radius: i == selectedIndex ? 25 : 15,
          color:
              selectedIndex == i
                  ? AppColors.primaryLight
                  : AppColors.primaryLight.withOpacity(0.5),
          value: investments[i].investmentAmount! / totalInvestmentsAmount,
          showTitle: false,
        ),
      );
    }

    return sections;
  }

  void checkIsInvestor(BuildContext screenContext, PropertyModel property) {
    final currentUser = getIt.get<HiveHelper>().currentUser;
    if (currentUser!.isInvestor!) {
      showModalBottomSheet(
        context: screenContext,
        builder: (context) {
          return CustomConfirmBottomSheet(property: property);
        },
      );
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

    on<MakeInvestmentEvent>((event, emit) async {
      emit(MakeInvestmentLoading());
      final response = await service.makeInvestment(request: event.request);
      response.fold(
        (failure) {
          emit(MakeInvestmentFailure(message: failure.message));
        },
        (data) {
          emit(MakeInvestmentSuccess(response: data));
        },
      );
    });
  }
}
