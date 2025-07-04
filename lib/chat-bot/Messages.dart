import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../core/themes/colors/app_colors.dart';

class MessagesScreen extends StatefulWidget {
  final List messages;
  const MessagesScreen({Key? key, required this.messages}) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void didUpdateWidget(covariant MessagesScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Auto-scroll to the bottom when messages change
    if (widget.messages.length != oldWidget.messages.length ||
        widget.messages != oldWidget.messages) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    // Reverse the messages list to display oldest to newest
    final reversedMessages = List.from(widget.messages.reversed);

    return Container(
      color: Color(0xFFE5DDD5), // WhatsApp-like background
      child: ListView.separated(
        controller: _scrollController,
        reverse: true, // Newest messages at the bottom
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final messageData = reversedMessages[index];
          final isUserMessage = messageData['isUserMessage'] ?? false;
          final isTyping = messageData['isTyping'] ?? false;
          final timestamp = messageData['timestamp'] ?? DateTime.now();

          if (isTyping) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bot avatar
                  ClipOval(
                    child: Image.asset(
                      'assets/images/icon.png',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 40,
                        height: 40,
                        color: Colors.grey,
                        child: SvgPicture.asset(
                          'assets/images/Icon.svg',
                          fit: BoxFit.cover,
                          placeholderBuilder: (context) => Icon(Icons.android, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  // Typing indicator
                  CustomBubble(
                    isUserMessage: false,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: TypingIndicator(),
                    ),
                  ),
                ],
              ),
            );
          }

          return Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              mainAxisAlignment: isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: isUserMessage
                  ? [
                // User message bubble
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomBubble(
                      isUserMessage: true,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        child: Text(
                          messageData['message'].text.text[0],
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      DateFormat('h:mm a').format(timestamp),
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ]
                  : [
                // Bot avatar
                ClipOval(
                  child: Image.asset(
                    'assets/images/icon.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 40,
                      height: 40,
                      color: Colors.grey,
                      child: SvgPicture.asset(
                        'assets/images/Icon.svg',
                        fit: BoxFit.cover,
                        placeholderBuilder: (context) => Icon(Icons.android, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                // Bot message bubble
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomBubble(
                      isUserMessage: false,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        child: Text(
                          messageData['message'].text.text[0],
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      DateFormat('h:mm a').format(timestamp),
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        separatorBuilder: (_, i) => SizedBox(height: 0),
        itemCount: widget.messages.length,
      ),
    );
  }
}

// Custom bubble with WhatsApp-like tail
class CustomBubble extends StatelessWidget {
  final bool isUserMessage;
  final Widget child;

  const CustomBubble({Key? key, required this.isUserMessage, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BubblePainter(isUserMessage: isUserMessage),
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 2 / 3),
        decoration: BoxDecoration(
          color: isUserMessage ? Color(0xFFDCF8C6) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: isUserMessage ? Radius.circular(12) : Radius.circular(0),
            bottomRight: isUserMessage ? Radius.circular(0) : Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(1, 1)),
          ],
        ),
        child: child,
      ),
    );
  }
}

class BubblePainter extends CustomPainter {
  final bool isUserMessage;

  BubblePainter({required this.isUserMessage});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isUserMessage ? Color(0xFFDCF8C6) : Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    if (isUserMessage) {
      path.moveTo(size.width - 10, size.height);
      path.lineTo(size.width, size.height - 10);
      path.lineTo(size.width, size.height);
      path.close();
    } else {
      path.moveTo(10, size.height);
      path.lineTo(0, size.height - 10);
      path.lineTo(0, size.height);
      path.close();
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Typing indicator widget with animated dots
class TypingIndicator extends StatefulWidget {
  const TypingIndicator({Key? key}) : super(key: key);

  @override
  _TypingIndicatorState createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _dot1;
  late Animation<double> _dot2;
  late Animation<double> _dot3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    )..repeat(reverse: true);

    _dot1 = Tween<double>(begin: 0, end: 5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.33, curve: Curves.easeInOut),
      ),
    );
    _dot2 = Tween<double>(begin: 0, end: 5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.33, 0.66, curve: Curves.easeInOut),
      ),
    );
    _dot3 = Tween<double>(begin: 0, end: 5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.66, 1.0, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.translate(
              offset: Offset(0, _dot1.value),
              child: Dot(),
            ),
            SizedBox(width: 4),
            Transform.translate(
              offset: Offset(0, _dot2.value),
              child: Dot(),
            ),
            SizedBox(width: 4),
            Transform.translate(
              offset: Offset(0, _dot3.value),
              child: Dot(),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Dot extends StatelessWidget {
  const Dot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.grey[600],
        shape: BoxShape.circle,
      ),
    );
  }
}