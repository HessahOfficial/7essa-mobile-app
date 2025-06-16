import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/utils/show_snack_bar.dart';
import 'package:hessa/features/auth/data/models/refresh_token_request.dart';
import 'package:hessa/features/auth/presentation/managers/auth_bloc.dart';
import 'package:hessa/features/home/data/models/get_all_properties_request.dart';
import 'package:hessa/features/home/presentation/managers/category_cubit.dart';
import 'package:hessa/features/home/presentation/managers/property_bloc.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_app_bar.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_category_list.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_search_bar.dart';
import 'package:hessa/features/home/presentation/views/widgets/category_tabs_list.dart';
import 'package:hessa/generated/l10n.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

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

    _speech = stt.SpeechToText();
    // Request microphone permission and start listening after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _requestMicrophonePermission();
      _scheduleWelcomeMessage();
    });
    context.read<PropertyBloc>().add(
      GetAllPropertiesEvent(request: GetAllPropertiesRequest()),
    );
  }

  // Request microphone permission and show popup
  Future<void> _requestMicrophonePermission() async {
    PermissionStatus status = await Permission.microphone.status;
    if (!status.isGranted) {
      // Show dialog to request permission
      if (mounted) {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text('Microphone Permission'),
                content: Text(
                  'For better communication with the Hessah chatbot, please allow microphone access to enable voice commands like "Hi chat".',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _stopListening(); // Don't listen if permission is denied
                    },
                    child: Text('Deny'),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      PermissionStatus newStatus =
                          await Permission.microphone.request();
                      if (newStatus.isGranted) {
                        _initializeSpeech();
                      } else {
                        print('Microphone permission denied');
                      }
                    },
                    child: Text('Allow'),
                  ),
                ],
              ),
        );
      }
    } else {
      _initializeSpeech();
    }
  }

  // Initialize speech recognition
  Future<void> _initializeSpeech() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        setState(() {
          _isListening = status == 'listening';
        });
      },
      onError: (error) {
        print('Speech error: $error');
        setState(() {
          _isListening = false;
        });
        // Restart listening on error to ensure continuous listening
        if (mounted) {
          _startListening();
        }
      },
    );
    if (available && mounted) {
      _startListening();
    }
  }

  // Start listening for "Hi Hessah"
  void _startListening() {
    if (!_isListening) {
      _speech.listen(
        onResult: (result) {
          if (result.recognizedWords.toLowerCase().contains('hi chat')) {
            _stopListening();
            _openChatbot();
          }
        },
        localeId: 'en_US', // Adjust locale as needed
        listenMode: stt.ListenMode.confirmation,
        cancelOnError: true,
      );
      setState(() {
        _isListening = true;
      });
    }
  }

  // Stop listening
  void _stopListening() {
    if (_isListening) {
      _speech.stop();
      setState(() {
        _isListening = false;
      });
    }
  }

  // Schedule the welcome message
  void _scheduleWelcomeMessage() async {
    final hiveHelper = getIt.get<HiveHelper>();
    final user = await hiveHelper.getCurrentUser();
    final username = user?.username ?? 'User';

    print('Scheduling message for username: $username');
    Timer(Duration(seconds: 1), () {
      if (mounted) {
        print('Attempting to show message overlay');
        _showMessageOverlay(username);
      }
    });
    Timer(Duration(seconds: 3), () {
      print('Removing message overlay');
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
      print('RenderBox is null or not attached, skipping overlay');
      return;
    }

    final offset = renderBox.localToGlobal(Offset.zero);
    final fabSize = 56.0;
    final message = "Hey $username, ask me anything";

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
    print('Overlay inserted successfully');
  }

  // Navigate to chatbot
  Future<void> _openChatbot() async {
    final hiveHelper = getIt.get<HiveHelper>();
    final user = await hiveHelper.getCurrentUser();
    final username = user?.username ?? 'User';
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _stopListening();
    _speech.cancel();
    widget.searchController.dispose();
    super.dispose();
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
      floatingActionButton: FloatingActionButton(
        key: _fabKey,
        heroTag: 'homeScreenFAB',
        onPressed: _openChatbot,
        backgroundColor: AppColors.primaryLight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/icon.png',
              width: 40,
              height: 40,
              fit: BoxFit.contain,
              errorBuilder:
                  (context, error, stackTrace) =>
                      Icon(Icons.error, color: Colors.white),
            ),
            if (_isListening)
              Positioned(
                right: 0,
                bottom: 0,
                child: Icon(Icons.mic, size: 16, color: Colors.red),
              ),
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
