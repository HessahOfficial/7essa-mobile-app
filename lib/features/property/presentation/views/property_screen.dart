import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/utils/show_snack_bar.dart';
import 'package:hessa/features/auth/data/models/refresh_token_request.dart';
import 'package:hessa/features/auth/presentation/managers/auth_bloc.dart';
import 'package:hessa/features/home/presentation/managers/property_bloc.dart';
import 'package:hessa/features/property/data/models/get_property_request.dart';
import 'package:hessa/features/property/presentation/views/widgets/custom_image_slider.dart';
import 'package:hessa/features/property/presentation/views/widgets/property_details.dart';

class PropertyScreen extends StatefulWidget {
  final String propertyId;

  const PropertyScreen({super.key, required this.propertyId});

  @override
  State<PropertyScreen> createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyScreen> {
  @override
  void initState() {
    super.initState();

    final tokens = getIt.get<HiveHelper>().token;
    context.read<AuthBloc>().add(
      RefreshRokenEvent(
        request: RefreshTokenRequest(refreshToken: tokens!.refreshToken!),
      ),
    );

    context.read<PropertyBloc>().add(
      GetPropertyEvent(
        request: GetPropertyRequest(propertyId: widget.propertyId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (bccontext, state) {
        if (state is RefreshTokenFailure) {
          showSnackBar(context: context, message: state.message, type: 1);
        }
      },
      builder: (bccontext, state) {
        return BlocConsumer<PropertyBloc, PropertyState>(
          listener: (bccontext, state) {
            if (state is GetPropertyFailure) {
              showSnackBar(context: context, message: state.message, type: 1);
            }
          },
          builder: (bccontext, state) {
            return state is GetPropertySuccess
                ? Scaffold(
                  appBar: AppBar(
                    titleSpacing: 0,
                    title: Text(
                      state.response.property!.title!,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () => context.pop(),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomImageSlider(
                          images:
                              state.response.property!.images!.cast<String>(),
                        ),
                        PropertyDetails(property: state.response.property!),
                      ],
                    ),
                  ),
                )
                : Scaffold(
                  appBar: AppBar(
                    leading: InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () => context.pop(),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  body: Align(
                    alignment: Alignment.topCenter,
                    child: CircularProgressIndicator(
                      color:
                          isDark
                              ? Colors.white
                              : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                );
          },
        );
      },
    );
  }
}
