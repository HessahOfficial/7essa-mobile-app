import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hessa/features/home/data/models/property_query_model.dart';
import 'package:hessa/features/home/presentation/managers/search_bloc.dart';
import 'package:hessa/generated/l10n.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:hessa/chat-bot/chatbot.dart';

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
  // bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _requestMicrophonePermission();
      _scheduleWelcomeMessage();
    });

    final tokens = getIt.get<HiveHelper>().token;
    context.read<AuthBloc>().add(
      RefreshRokenEvent(
        request: RefreshTokenRequest(refreshToken: tokens!.refreshToken!),
      ),
    );

    context.read<SearchBloc>().setQuery(query: PropertyQueryModel());
  }

  // Schedule the welcome message
  void _scheduleWelcomeMessage() async {
    final hiveHelper = getIt.get<HiveHelper>();
    final user = await hiveHelper.getCurrentUser();
    final username = user?.username ?? 'User';

    Timer(Duration(seconds: 1), () {
      if (mounted) {
        _showMessageOverlay(username);
      }
    });
    Timer(Duration(seconds: 3), () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  // Show overlay message
  void _showMessageOverlay(String username) {
    _overlayEntry?.remove();
    final overlay = Overlay.of(context);
    final renderBox = _fabKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox == null || !renderBox.attached) {
      return;
    }

    final offset = renderBox.localToGlobal(Offset.zero);
    final fabSize = 56.0;
    final message =
        "${S.of(context).overlayTextPart1} $username${S.of(context).overlayTextPart2}";

    _overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            left: offset.dx - 220 > 0 ? offset.dx - 220 : 0,
            top: offset.dy - (fabSize / 2),
            child: CustomPaint(
              painter: BubbleTailPainter(),
              child: AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(milliseconds: 300),
                child: Container(
                  width: 200,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white, Color(0xFFF5F5F5)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
    );

    overlay.insert(_overlayEntry!);
  }

  // Navigate to chatbot
  Future<void> _openChatbot() async {
    final hiveHelper = getIt.get<HiveHelper>();
    final user = await hiveHelper.getCurrentUser();
    final username = user?.username ?? 'User';
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  Home(username: username), // Ensure Home accepts username
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        key: _fabKey,
        heroTag: 'homeScreenFAB',
        onPressed: _openChatbot,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/Icon.png',
              width: 40,
              height: 40,
              fit: BoxFit.contain,
              errorBuilder:
                  (context, error, stackTrace) =>
                      Icon(Icons.error, color: Colors.white),
            ),
            // if (_isListening)
            //   Positioned(
            //     right: 0,
            //     bottom: 0,
            //     child: Icon(Icons.mic, size: 16, color: Colors.red),
            //   ),
          ],
        ),
      ),
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
