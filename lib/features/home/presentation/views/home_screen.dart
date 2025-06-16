import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/features/auth/data/models/refresh_token_request.dart';
import 'package:hessa/features/auth/presentation/managers/auth_bloc.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_app_bar.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_category_list.dart';
import 'package:hessa/features/home/presentation/views/widgets/category_tabs_list.dart';

class HomeScreen extends StatefulWidget {
  final TextEditingController searchController = TextEditingController();
  final BuildContext screenContext;
  HomeScreen({super.key, required this.screenContext});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  OverlayEntry? _overlayEntry;
  final GlobalKey _fabKey = GlobalKey();
  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();

    final tokens = getIt.get<HiveHelper>().token;
    context.read<AuthBloc>().add(
      RefreshRokenEvent(
        request: RefreshTokenRequest(refreshToken: tokens!.refreshToken!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = getIt.get<HiveHelper>().isDark ?? false;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            CustomAppBar(screenContext: context),
            CategoryTabsList(),
            Expanded(child: CustomCategoryList(screenContext: context)),
          ],
        ),
      ),
    );
  }
}

// Custom painter for the bubble tail
class BubbleTailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final path = Path();
    path.moveTo(0, size.height / 2);
    path.lineTo(10, size.height / 2 - 5);
    path.lineTo(20, size.height / 2);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
