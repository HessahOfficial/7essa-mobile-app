import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hessa/constants/app_colors.dart';
import 'package:hessa/constants/property_data.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:hessa/screens/wallet-page.dart';

class CheckoutInvestmentPage extends StatefulWidget {
  final PropertyModel property;

  const CheckoutInvestmentPage({super.key, required this.property});

  @override
  State<CheckoutInvestmentPage> createState() => _CheckoutInvestmentPageState();
}

class _CheckoutInvestmentPageState extends State<CheckoutInvestmentPage> {
  int numberOfShares = 1;
  final TextEditingController _sharesController = TextEditingController(text: '1');

  // Total price per share in EGP
  double get totalPricePerShare {
    final basePrice = widget.property.price;
    final fees = basePrice * 0.002;
    return basePrice + fees;
  }

  // Total price for all shares in EGP
  double get totalPrice {
    return numberOfShares * totalPricePerShare;
  }

  // Max shares based on wallet balance
  int get maxShares {
    final walletBalance = Provider.of<WalletProvider>(context, listen: false).balance.currentBalance;
    return (walletBalance / totalPricePerShare).floor().clamp(1, 1000);
  }

  @override
  void initState() {
    super.initState();
    _sharesController.addListener(() {
      final value = int.tryParse(_sharesController.text) ?? 1;
      if (value != numberOfShares) {
        setState(() {
          if (value > maxShares) {
            Get.snackbar(
              "Maximum Reached",
              "This is the max amount of shares according to your balance ($maxShares shares).",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.orange,
              colorText: Colors.white,
            );
            numberOfShares = maxShares;
          } else {
            numberOfShares = value.clamp(1, maxShares);
          }
          _sharesController.text = numberOfShares.toString();
        });
      }
    });
  }

  @override
  void dispose() {
    _sharesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Consumer<WalletProvider>(
      builder: (context, walletProvider, child) {
        final double walletBalance = walletProvider.balance.currentBalance;
        final bool isBalanceSufficient = totalPricePerShare <= walletBalance;

        return Scaffold(
          backgroundColor: AppColors.white1,
          appBar: AppBar(
            backgroundColor: AppColors.white1,
            leading: GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.accentColor),
            ),
            centerTitle: true,
            title: const Text(
              "Invest in Property",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Property Image
                Container(
                  height: screenHeight * 0.3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.property.image ??
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsD-IrOkZfrQw5_Fd_rE1xTmkY2lBrbo4CptJce8qBa530OL4u5f2KOrVWI644JZxxd_U&usqp=CAU',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.06,
                    vertical: screenHeight * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Property Name
                      Text(
                        widget.property.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      // Price per Share
                      Text(
                        '${widget.property.price.toStringAsFixed(2)} EGP / share',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      // Number of Shares Input
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Number of Shares",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (numberOfShares > 1) {
                                      numberOfShares--;
                                      _sharesController.text = numberOfShares.toString();
                                    }
                                  });
                                },
                                icon: const Icon(Icons.remove_circle, color: AppColors.accentColor),
                              ),
                              SizedBox(
                                width: 60,
                                child: TextField(
                                  controller: _sharesController,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (numberOfShares < maxShares) {
                                      numberOfShares++;
                                      _sharesController.text = numberOfShares.toString();
                                    } else {
                                      Get.snackbar(
                                        "Maximum Reached",
                                        "This is the max amount of shares according to your balance ($maxShares shares).",
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.orange,
                                        colorText: Colors.white,
                                      );
                                    }
                                  });
                                },
                                icon: const Icon(Icons.add_circle, color: AppColors.accentColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        'Max: $maxShares shares',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      // Wallet Balance
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Wallet Balance",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${walletBalance.toStringAsFixed(2)} EGP',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      // Price Breakdown
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Base Price",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '${(numberOfShares * widget.property.price).toStringAsFixed(2)} EGP',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Fees (0.2%)",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '${(numberOfShares * widget.property.price * 0.002).toStringAsFixed(2)} EGP',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const Divider(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total Price",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${totalPrice.toStringAsFixed(2)} EGP',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06,
              vertical: 10,
            ),
            color: AppColors.white1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isBalanceSufficient
                        ? () {
                      if (totalPrice > walletBalance) {
                        Get.snackbar(
                          "Insufficient Balance",
                          "Your wallet balance (${walletBalance.toStringAsFixed(2)} EGP) is not enough for this investment (${totalPrice.toStringAsFixed(2)} EGP).",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      } else {
                        walletProvider.updateBalance(walletBalance - totalPrice);
                        walletProvider.addTransaction(Transaction(
                          type: "Pay Shares",
                          date: DateTime.now().toString().substring(0, 10),
                          currency: "EGP",
                          amount: totalPrice,
                          category: "Expense",
                        ));
                        Get.snackbar(
                          "Success",
                          "Investment of $numberOfShares shares in ${widget.property.name} confirmed!",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                        // Reset shares to 1 after confirmation
                        setState(() {
                          numberOfShares = 1;
                          _sharesController.text = '1';
                        });
                      }
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isBalanceSufficient ? AppColors.accentColor : Colors.grey[400],
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Confirm Investment",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                if (!isBalanceSufficient)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Not enough balance to invest",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.red[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}