import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/widgets/custom_text_field.dart';

class RoomsFilterForm extends StatelessWidget {
  final TextEditingController roomsController;
  final TextEditingController bedsController;
  final TextEditingController kitchensController;
  final TextEditingController bathsController;

  final FocusNode roomsFocusNode;
  final FocusNode bedsFocusNode;
  final FocusNode kitchensFocusNode;
  final FocusNode bathsFocusNode;

  final bool roomsTouched;
  final bool kitchensTouched;
  final bool bathsTouched;
  final bool bedsTouched;

  final GlobalKey<FormState> formKey;

  const RoomsFilterForm({
    super.key,
    required this.roomsController,
    required this.bedsController,
    required this.kitchensController,
    required this.bathsController,
    required this.roomsFocusNode,
    required this.bedsFocusNode,
    required this.kitchensFocusNode,
    required this.bathsFocusNode,
    required this.roomsTouched,
    required this.kitchensTouched,
    required this.bathsTouched,
    required this.bedsTouched,
    required this.formKey,
  });

  List<CustomTextField> getRoomsFormFields() {
    List<CustomTextField> formFields = [];

    formFields.add(
      CustomTextField(
        contentPadding: EdgeInsets.all(10),
        focusNode: roomsFocusNode,
        fieldTocuhed: roomsTouched,
        controller: roomsController,
        icon: FontAwesomeIcons.personBooth,
        inputColor: AppColors.white2,
        placeholder: "Rooms",
        type: TextInputType.number,
      ),
    );

    formFields.add(
      CustomTextField(
        contentPadding: EdgeInsets.all(10),
        focusNode: bedsFocusNode,
        fieldTocuhed: bedsTouched,
        controller: bedsController,
        icon: FontAwesomeIcons.bed,
        inputColor: AppColors.white2,
        placeholder: "Bedrooms",
        type: TextInputType.number,
      ),
    );

    formFields.add(
      CustomTextField(
        contentPadding: EdgeInsets.all(10),
        focusNode: bathsFocusNode,
        fieldTocuhed: bathsTouched,
        controller: bathsController,
        icon: FontAwesomeIcons.bath,
        inputColor: AppColors.white2,
        placeholder: "Bathrooms",
        type: TextInputType.number,
      ),
    );

    formFields.add(
      CustomTextField(
        contentPadding: EdgeInsets.all(10),
        focusNode: kitchensFocusNode,
        fieldTocuhed: kitchensTouched,
        controller: kitchensController,
        icon: FontAwesomeIcons.kitchenSet,
        inputColor: AppColors.white2,
        placeholder: "Kitchens",
        type: TextInputType.number,
      ),
    );

    return formFields;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        childAspectRatio: 4,
        children: getRoomsFormFields(),
      ),
    );
  }
}

class CCustomTextField {}
