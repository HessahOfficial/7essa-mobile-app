import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/utils/show_snack_bar.dart';
import 'package:hessa/features/auth/data/models/refresh_token_request.dart';
import 'package:hessa/features/auth/presentation/managers/auth_bloc.dart';
import 'package:hessa/features/notification/data/models/get_notifications_request.dart';
import 'package:hessa/features/notification/data/models/notification_model.dart';
import 'package:hessa/features/notification/presentation/managers/bloc/notification_bloc.dart';
import 'package:hessa/features/notification/presentation/views/widgets/notification_item.dart';
import 'package:hessa/generated/l10n.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();

    final tokens = getIt.get<HiveHelper>().token;
    context.read<AuthBloc>().add(
      RefreshRokenEvent(
        request: RefreshTokenRequest(refreshToken: tokens!.refreshToken!),
      ),
    );

    context.read<NotificationBloc>().add(
      GetNotificationsEvent(request: GetNotificationsRequest()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RefreshTokenFailure) {
          showSnackBar(context: context, message: state.message, type: 1);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: InkWell(
              splashColor: AppColors.gray.withOpacity(0.01),
              borderRadius: BorderRadius.circular(100),
              onTap: () => context.pop(),
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            title: Text(
              S.of(context).notifications,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: Directionality(
            textDirection: TextDirection.ltr,
            child: BlocConsumer<NotificationBloc, NotificationState>(
              listener: (context, state) {
                if (state is GetNotificationsFailure) {
                  showSnackBar(
                    context: context,
                    message: state.message,
                    type: 1,
                  );
                }
              },
              builder: (context, state) {
                List<NotificationModel> notifications =
                    context.read<NotificationBloc>().notifications;

                return state is GetNotificationsLoading
                    ? Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: CircularProgressIndicator(
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    )
                    : notifications.isEmpty
                    ? Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          S.of(context).noNotificationsYet,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                    : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.06,
                      ),
                      itemBuilder:
                          (context, index) => NotificationItem(
                            notification: notifications[index],
                          ),
                      itemCount: notifications.length,
                    );
              },
            ),
          ),
        );
      },
    );
  }
}
