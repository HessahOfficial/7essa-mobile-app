import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:hessa/core/widgets/custom_button.dart';
import 'package:hessa/features/home/data/models/get_all_properties_request.dart';
import 'package:hessa/features/home/data/models/property_query_model.dart';
import 'package:hessa/features/home/presentation/managers/search_bloc.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_slider_list.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_status_list.dart';
import 'package:hessa/features/home/presentation/views/widgets/rooms_filter_form.dart';
import 'package:hessa/generated/l10n.dart';

class FilterBottomSheet extends StatefulWidget {
  final String? title;

  const FilterBottomSheet({super.key, this.title});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  double minAvailableShares = 1;
  double maxAvailableShares = 400;
  RangeValues availableSharesValues = RangeValues(1, 400);

  double minPrice = 200000;
  double maxPrice = 18000000;
  RangeValues priceValues = RangeValues(200000, 18000000);

  double minPricePerShare = 1000;
  double maxPricePerShare = 500000;
  RangeValues pricePerShareValues = RangeValues(1000, 500000);

  double minRentalIncome = 2000;
  double maxRentalIncome = 200000;
  RangeValues rentalIncomeValues = RangeValues(2000, 200000);

  double minArea = 50;
  double maxArea = 1000;
  RangeValues areaValues = RangeValues(50, 1000);

  double minYearlyPayment = 24000;
  double maxYearlyPayment = 1200000;
  RangeValues yearlyPaymentValues = RangeValues(24000, 1200000);

  bool? isRented = false;

  final roomsController = TextEditingController();
  final bedsController = TextEditingController();
  final kitchensController = TextEditingController();
  final bathsController = TextEditingController();

  final roomsFocusNode = FocusNode();
  final bathsFocusNode = FocusNode();
  final bedsFocusNode = FocusNode();
  final kitchensFocusNode = FocusNode();

  bool roomsTouched = false;
  bool bedsTouched = false;
  bool kitchensTouched = false;
  bool bathsTouched = false;

  late GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    roomsFocusNode.addListener(() {
      if (roomsFocusNode.hasFocus) {
        setState(() {
          roomsTouched = true;
        });
      }
    });

    kitchensFocusNode.addListener(() {
      if (kitchensFocusNode.hasFocus) {
        setState(() {
          kitchensTouched = true;
        });
      }
    });

    bathsFocusNode.addListener(() {
      if (bathsFocusNode.hasFocus) {
        setState(() {
          bathsTouched = true;
        });
      }
    });

    bedsFocusNode.addListener(() {
      if (bedsFocusNode.hasFocus) {
        setState(() {
          bedsTouched = true;
        });
      }
    });
  }

  @override
  void dispose() {
    roomsFocusNode.dispose();
    bedsFocusNode.dispose();
    kitchensFocusNode.dispose();
    bathsFocusNode.dispose();

    roomsController.dispose();
    bedsController.dispose();
    kitchensController.dispose();
    bathsController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    PropertyQueryModel query = context.read<SearchBloc>().initialQuery;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 40,
          horizontal: screenWidth * 0.06,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            CustomStatusList(),

            RoomsFilterForm(
              roomsController: roomsController,
              bedsController: bedsController,
              kitchensController: kitchensController,
              bathsController: bathsController,
              roomsFocusNode: roomsFocusNode,
              bedsFocusNode: bedsFocusNode,
              kitchensFocusNode: kitchensFocusNode,
              bathsFocusNode: bathsFocusNode,
              roomsTouched: roomsTouched,
              kitchensTouched: kitchensTouched,
              bathsTouched: bathsTouched,
              bedsTouched: bedsTouched,
              formKey: formKey,
            ),

            CustomSliderList(
              minAvailableShares: minAvailableShares,
              maxAvailableShares: maxAvailableShares,
              minPrice: minPrice,
              maxPrice: maxPrice,
              minPricePerShare: minPricePerShare,
              maxPricePerShare: maxPricePerShare,
              minRentalIncome: minRentalIncome,
              maxRentalIncome: maxRentalIncome,
              minArea: minArea,
              maxArea: maxArea,
              minYearlyPayment: minYearlyPayment,
              maxYearlyPayment: maxYearlyPayment,
              availableSharesValues: availableSharesValues,
              pricePerShareValues: pricePerShareValues,
              rentalIncomeValues: rentalIncomeValues,
              areaValues: areaValues,
              yearlyPaymentValues: yearlyPaymentValues,
              availableSharesOnchanged: (value) {
                setState(() {
                  availableSharesValues = value;
                });
              },
              priceOnchanged: (value) {
                setState(() {
                  priceValues = value;
                });
              },
              pricePerShareOnchanged: (value) {
                setState(() {
                  pricePerShareValues = value;
                });
              },
              rentalIncomeOnchanged: (value) {
                setState(() {
                  rentalIncomeValues = value;
                });
              },
              areaOnchanged: (value) {
                setState(() {
                  areaValues = value;
                });
              },
              yealyPaymentOnchanged: (value) {
                setState(() {
                  yearlyPaymentValues = value;
                });
              },
              priceValues: priceValues,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: isRented,
                      onChanged:
                          (value) => setState(() {
                            isRented = value;
                          }),
                    ),
                    Text(
                      S.of(context).rented,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                CustomButton(
                  onPressed: () {
                    String? status = context.read<SearchBloc>().statusText;
                    context.read<SearchBloc>().setStatus(index: -1);
                    context.read<SearchBloc>().setQuery(
                      query: PropertyQueryModel(
                        minAvailableShares: availableSharesValues.start.toInt(),
                        maxAvailableShares: availableSharesValues.end.toInt(),
                        minPrice: priceValues.start,
                        maxPrice: priceValues.end,
                        minPricePerShare: pricePerShareValues.start,
                        maxPricePerShare: pricePerShareValues.end,
                        minRentalIncome: rentalIncomeValues.start,
                        maxRentalIncome: rentalIncomeValues.end,
                        minArea: areaValues.start,
                        maxArea: areaValues.end,
                        minYearlyPayment: yearlyPaymentValues.start,
                        maxYearlyPayment: yearlyPaymentValues.end,
                        numberOfRooms:
                            roomsController.text.isEmpty
                                ? null
                                : int.parse(roomsController.text),
                        numberOfBathrooms:
                            bathsController.text.isEmpty
                                ? null
                                : int.parse(bathsController.text),
                        numberOfbeds:
                            bedsController.text.isEmpty
                                ? null
                                : int.parse(bedsController.text),
                        numberOfKitchens:
                            kitchensController.text.isEmpty
                                ? null
                                : int.parse(kitchensController.text),
                        isRented: isRented,
                        status: status,
                        title: widget.title,
                      ),
                    );
                    context.read<SearchBloc>().add(
                      GetFilteredPropertiesEvent(
                        request: GetAllPropertiesRequest(query: query),
                      ),
                    );
                    context.pop();
                  },
                  width: 100,
                  height: 30,
                  text: S.of(context).apply,
                  textColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
