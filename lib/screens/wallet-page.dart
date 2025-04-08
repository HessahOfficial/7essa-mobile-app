import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

// Data Models for easy backend integration
class User {
  final String name;
  final String email;
  final String avatarUrl;

  User({
    required this.name,
    required this.email,
    required this.avatarUrl,
  });
}

class Balance {
  final double currentBalance;
  final String currency;

  Balance({
    required this.currentBalance,
    required this.currency,
  });
}

class Transaction {
  final String type; // "Pay Shares" or "Fees"
  final String date;
  final String currency;
  final double amount;
  final String category; // "Expense" or "Income"

  Transaction({
    required this.type,
    required this.date,
    required this.currency,
    required this.amount,
    required this.category,
  });
}

// Provider for managing wallet data (static for now, API-ready)
class WalletProvider with ChangeNotifier {
  final User _user = User(
    name: "James Butler",
    email: "james@gmail.com",
    avatarUrl: '', // Placeholder for now
  );

  Balance _balance = Balance(
    currentBalance: 20560.50,
    currency: "LE",
  );

  final List<Transaction> _transactions = [
    Transaction(
      type: "Pay Shares",
      date: "04-Jan-2024",
      currency: "EGP",
      amount: 250,
      category: "Expense",
    ),
    Transaction(
      type: "Fees",
      date: "08-May-2024",
      currency: "EGP",
      amount: 50,
      category: "Expense",
    ),
    Transaction(
      type: "Pay Shares",
      date: "04-Aug-2023",
      currency: "EGP",
      amount: 250,
      category: "Expense",
    ),
    Transaction(
      type: "Rent",
      date: "01-Jan-2024",
      currency: "EGP",
      amount: 500,
      category: "Income",
    ),
    Transaction(
      type: "Bonus",
      date: "15-Mar-2024",
      currency: "EGP",
      amount: 300,
      category: "Income",
    ),
  ];

  User get user => _user;
  Balance get balance => _balance;
  List<Transaction> get transactions => _transactions;

  // Filter transactions by category
  List<Transaction> getExpenses() {
    return _transactions.where((transaction) => transaction.category == "Expense").toList();
  }

  List<Transaction> getIncomes() {
    return _transactions.where((transaction) => transaction.category == "Income").toList();
  }

  // Methods for future API integration
  Future<void> fetchUserData() async {
    // Backend team can replace this with API call
    notifyListeners();
  }

  Future<void> fetchBalance() async {
    // Backend team can replace this with API call
    notifyListeners();
  }

  Future<void> fetchTransactions() async {
    // Backend team can replace this with API call
    notifyListeners();
  }
}

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  int _selectedTabIndex = 0;
  bool _isBalanceVisible = false;
  String _enteredPassword = '';
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? screenWidth * 0.1 : 16.0,
          vertical: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            SizedBox(height: 20),
            _buildBalanceCard(context, screenWidth),
            SizedBox(height: 20),
            _buildTabs(context),
            SizedBox(height: 12),
            _buildTransactionList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Consumer<WalletProvider>(
      builder: (context, provider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey[300],
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      provider.user.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      provider.user.email,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildBalanceCard(BuildContext context, double screenWidth) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final isTablet = width > 600;

    final borderRadius = width * 0.05;
    final balanceFontSize = isTablet ? 32.0 : 28.0;
    final labelFontSize = isTablet ? 18.0 : 16.0;
    final iconSize = isTablet ? 28.0 : 24.0;

    const double imageAspectRatio = 2.0;
    final cardWidth = width * 1.1;
    final cardHeight = cardWidth / imageAspectRatio;

    return Consumer<WalletProvider>(
      builder: (context, provider, child) {
        return Container(
          width: cardWidth,
          height: cardHeight,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/images/wallet-card.png'),
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: width * 0.025,
                spreadRadius: width * 0.005,
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                top: cardHeight * 0.1,
                left: cardWidth * 0.05,
                right: cardWidth * 0.08,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CURRENT BALANCE',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: labelFontSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: cardHeight * 0.02),
                    Row(
                      children: [
                        Text(
                          _isBalanceVisible
                              ? '${provider.balance.currentBalance.toStringAsFixed(2)} ${provider.balance.currency}'
                              : '*******',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: balanceFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _isBalanceVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.white,
                            size: iconSize,
                          ),
                          onPressed: () {
                            if (_isBalanceVisible) {
                              setState(() => _isBalanceVisible = false);
                            } else {
                              _showPasswordDialog(context);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: cardHeight * 0.1,
                left: cardWidth * 0.05,
                right: cardWidth * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _buildActionButton('DEPOSIT', Icons.add_box_outlined, isTablet: isTablet),
                    ),
                    SizedBox(width: cardWidth * 0.04),
                    Expanded(
                      child: _buildActionButton('WITHDRAW', Icons.arrow_downward_outlined, isTablet: isTablet),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButton(String label, IconData icon, {bool isTablet = false}) {
    final buttonPadding = EdgeInsets.symmetric(
      vertical: isTablet ? 6.0 : 4.0,
      horizontal: isTablet ? 10.0 : 8.0,
    );
    final buttonFontSize = isTablet ? 20.0 : 18.0;
    final iconSize = isTablet ? 28.0 : 24.0;

    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: iconSize, color: Colors.white),
      label: Text(
        label,
        style: TextStyle(fontSize: buttonFontSize, color: Colors.white),
      ),
      style: TextButton.styleFrom(
        padding: buttonPadding,
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildTabs(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTabButton("Expenses", 0),
        SizedBox(width: 16),
        _buildTabButton("Incomes", 1),
      ],
    );
  }

  Widget _buildTabButton(String title, int index) {
    final bool isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF4B5EFC) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionList(BuildContext context) {
    return Consumer<WalletProvider>(
      builder: (context, provider, child) {
        final transactions = _selectedTabIndex == 0 ? provider.getExpenses() : provider.getIncomes();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0, 0.1),
                      end: Offset(0, 0),
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: transactions.isEmpty
                  ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  'No ${_selectedTabIndex == 0 ? "expenses" : "incomes"} found.',
                  key: ValueKey(_selectedTabIndex),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              )
                  : Column(
                key: ValueKey(_selectedTabIndex),
                children: transactions
                    .map((transaction) => _buildTransactionItem(transaction))
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTransactionItem(Transaction transaction) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  transaction.type == "Pay Shares" || transaction.type == "Fees"
                      ? Icons.share
                      : Icons.receipt,
                  color: Colors.grey[600],
                  size: 24,
                ),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.type,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    transaction.date,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            '${transaction.currency} ${transaction.amount}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  void _showPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF4B5EFC),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Enter 6-Digit Password',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 40,
                      height: 50,
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.white, width: 2),
                          ),
                          counterText: '',
                          contentPadding: const EdgeInsets.all(0),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            _enteredPassword += value;
                            if (index < 5) {
                              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                            } else if (_enteredPassword.length == 6) {
                              _submitPassword(context);
                            }
                          } else if (_enteredPassword.isNotEmpty) {
                            _enteredPassword = _enteredPassword.substring(0, _enteredPassword.length - 1);
                            if (index > 0) {
                              FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                            }
                          }
                        },
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _enteredPassword = '';
                          _clearControllers();
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _submitPassword(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF4B5EFC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _submitPassword(BuildContext context) {
    if (_enteredPassword.length == 6) {
      const correctPassword = '123456';
      if (_enteredPassword == correctPassword) {
        setState(() {
          _isBalanceVisible = true;
          _enteredPassword = '';
          _clearControllers();
        });
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Incorrect password')),
        );
        setState(() {
          _enteredPassword = '';
          _clearControllers();
        });
        FocusScope.of(context).requestFocus(_focusNodes[0]);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all 6 digits')),
      );
    }
  }

  void _clearControllers() {
    for (var controller in _controllers) {
      controller.clear();
    }
  }
}