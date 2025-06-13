import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:hessa/core/utils/show_snack_bar.dart';
import 'package:hessa/features/home/data/models/get_all_properties_request.dart';
import 'package:hessa/features/home/presentation/managers/category_cubit.dart';
import 'package:hessa/features/home/presentation/managers/property_bloc.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_app_bar.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_category_list.dart';
import 'package:hessa/features/home/presentation/views/widgets/custom_search_bar.dart';
import 'package:hessa/features/home/presentation/views/widgets/category_tabs_list.dart';
import 'package:hessa/generated/l10n.dart';
import 'package:hessa/chat-bot/chatbot.dart';
import 'package:hessa/core/themes/colors/app_colors.dart';
import 'dart:async';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomeScreen extends StatefulWidget {
  final TextEditingController searchController = TextEditingController();
  final BuildContext screenContext;
  HomeScreen({super.key, required this.screenContext});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  OverlayEntry? _overlayEntry;
  final GlobalKey _fabKey = GlobalKey(); // Key to track FAB position
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _listeningStatus = "Tap to start listening";

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initializeSpeech();
    context.read<PropertyBloc>().add(
      GetAllPropertiesEvent(request: GetAllPropertiesRequest()),
    );
    // Ensure widget tree is built before scheduling message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scheduleWelcomeMessage();
    });
  }

  // Initialize speech recognition
  Future<void> _initializeSpeech() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        setState(() {
          _listeningStatus = status;
        });
      },
      onError: (error) {
        print('Speech error: $error');
        setState(() {
          _isListening = false;
          _listeningStatus = "Error: $error";
        });
      },
    );
    if (available) {
      _startListening();
    }
  }

  // Start listening for "hi hessah"
  void _startListening() {
    if (!_isListening) {
      _speech.listen(
        onResult: (result) {
          if (result.recognizedWords.toLowerCase().contains('hi hessah')) {
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
        _listeningStatus = "Listening...";
      });
    }
  }

  // Stop listening
  void _stopListening() {
    if (_isListening) {
      _speech.stop();
      setState(() {
        _isListening = false;
        _listeningStatus = "Tap to start listening";
      });
    }
  }

  // Schedule the welcome message to appear after 1 second and disappear after 2 seconds
  void _scheduleWelcomeMessage() async {
    final hiveHelper = getIt.get<HiveHelper>();
    final user = await hiveHelper.getCurrentUser(); // Returns Future<UserModel?>
    final username = user?.username ?? 'User'; // Adjust 'username' to match UserModel field

    print('Scheduling message for username: $username'); // Debug print

    // Delay 1 second before showing the message
    Timer(Duration(seconds: 1), () {
      if (mounted) {
        print('Attempting to show message overlay'); // Debug print
        _showMessageOverlay(username);
      }
    });

    // Remove message after 2 more seconds (total 3 seconds from init)
    Timer(Duration(seconds: 3), () {
      print('Removing message overlay'); // Debug print
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  // Show overlay message to the left of the FAB with improved styling
  void _showMessageOverlay(String username) {
    _overlayEntry?.remove();
    final overlay = Overlay.of(context);
    final renderBox = _fabKey.currentContext?.findRenderObject() as RenderBox?;
    print('RenderBox attached: ${renderBox?.attached}'); // Debug print

    if (renderBox == null || !renderBox.attached) {
      print('RenderBox is null or not attached, skipping overlay'); // Debug print
      return;
    }

    final offset = renderBox.localToGlobal(Offset.zero);
    final fabSize = 56.0; // Default FAB size
    final message = "Hey $username, ask me anything";

    print('Inserting overlay at offset: $offset'); // Debug print

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx - 220 > 0 ? offset.dx - 220 : 0, // Left of FAB with margin, clamp to 0
        top: offset.dy - (fabSize / 2), // Align top with FAB center
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
                style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
    print('Overlay inserted successfully'); // Debug print
  }

  // Async function to handle navigation with username
  Future<void> _openChatbot() async {
    final hiveHelper = getIt.get<HiveHelper>();
    final user = await hiveHelper.getCurrentUser();
    final username = user?.username ?? 'User';
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(username: username),
        ),
      );
    }
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _stopListening();
    _speech.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        key: _fabKey, // Assign the key to the FAB
        heroTag: 'homeScreenFAB', // Unique hero tag
        onPressed: _openChatbot,
        backgroundColor: AppColors.primaryLight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/icon.png', // Replace with your logo asset
              width: 40,
              height: 40,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.error, color: Colors.white),
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
      body: BlocConsumer<PropertyBloc, PropertyState>(
        listener: (bccontext, state) {
          if (state is GetAllPropertiesFailure) {
            showSnackBar(
              context: widget.screenContext,
              message: state.message,
              type: 1,
            );
          } else if (state is GetAllPropertiesSuccess) {
            context.read<CategoryCubit>().setProperties(
              allProperties: state.response.properties,
            );
          } else if (state is AddToFavouritesSuccess) {
            showSnackBar(
              context: widget.screenContext,
              message: S.of(context).addToFavouritesResponse,
              type: 0,
            );
          } else if (state is AddToFavouritesFailure) {
            showSnackBar(
              context: widget.screenContext,
              message: state.message,
              type: 1,
            );
          }
        },
        builder: (bccontext, state) {
          bool isDark = getIt.get<HiveHelper>().isDark ?? false;
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(screenContext: context),
                CustomSearchBar(
                  searchController: widget.searchController,
                  screenContext: widget.screenContext,
                ),
                CategoryTabsList(),
                state is AddToFavouritesSuccess ||
                    state is GetAllPropertiesSuccess
                    ? Expanded(child: CustomCategoryList())
                    : Align(
                  alignment: Alignment.topCenter,
                  child: CircularProgressIndicator(
                    color: isDark
                        ? Colors.white
                        : Theme.of(context).colorScheme.primary,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _listeningStatus,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Custom painter for the bubble tail pointing to the FAB
class BubbleTailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final path = Path();
    path.moveTo(0, size.height / 2); // Start at center left
    path.lineTo(10, size.height / 2 - 5); // Top of tail
    path.lineTo(20, size.height / 2); // Bottom of tail
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}