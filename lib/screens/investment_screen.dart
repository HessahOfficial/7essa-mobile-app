import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:hessa/screens/wallet-page.dart';
import 'package:hessa/constants/app_colors.dart';
import 'package:get/get.dart';

class InvestmentChartPage extends StatefulWidget {
  const InvestmentChartPage({super.key});

  @override
  State<InvestmentChartPage> createState() => _InvestmentChartPageState();
}

class _InvestmentChartPageState extends State<InvestmentChartPage> {
  int? selectedIndex;
  bool _isLoading = false;
  String? _error;

  Future<void> _loadInvestments(WalletProvider walletProvider) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      await walletProvider.fetchInvestments();
    } catch (e) {
      setState(() {
        _error = "Failed to load investments: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);
    _loadInvestments(walletProvider);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double chartSize = screenWidth * 0.8;

    return Consumer<WalletProvider>(
      builder: (context, walletProvider, child) {
        final investments = walletProvider.investments;
        final totalInvestments = investments.length;

        if (_isLoading) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.white1,

              centerTitle: true,
              title: const Text(
                "Investment Chart",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (_error != null || investments.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.white1,

              centerTitle: true,
              title: const Text(
                "Investment Chart",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: Center(child: Text(_error ?? "No investments found")),
          );
        }

        // Center text for chart
        String centerText = selectedIndex == null
            ? '$totalInvestments\nInvestments'
            : investments[selectedIndex!].propertyName;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.white1,

            centerTitle: true,
            title: const Text(
              "Investment Chart",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh, color: AppColors.accentColor),
                onPressed: () => _loadInvestments(walletProvider),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Chart at the top middle
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: chartSize,
                        height: chartSize,
                        child: PieChart(
                          PieChartData(
                            sections: investments.asMap().entries.map((entry) {
                              final index = entry.key;
                              final investment = entry.value;
                              final isHighlighted = selectedIndex == index;

                              return PieChartSectionData(
                                color: investment.color.withOpacity(isHighlighted ? 1.0 : 0.5),
                                value: investment.amount,
                                radius: isHighlighted ? chartSize * 0.2 : chartSize * 0.1,
                                showTitle: false,
                              );
                            }).toList(),
                            sectionsSpace: 2,
                            centerSpaceRadius: chartSize * 0.3,
                            pieTouchData: PieTouchData(
                              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  setState(() {
                                    selectedIndex = null;
                                  });
                                  return;
                                }
                                setState(() {
                                  final touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                                  selectedIndex = touchedIndex;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Text(
                        centerText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                // Filter Button and Property List
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          // Implement filter logic here
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Filter functionality to be implemented")),
                          );
                        },
                        icon: const Icon(Icons.filter_list, color: AppColors.accentColor),
                        label: const Text(
                          "Filter",
                          style: TextStyle(color: AppColors.accentColor),
                        ),
                      ),
                      ...investments.asMap().entries.map((entry) {
                        final index = entry.key;
                        final investment = entry.value;
                        final isSelected = selectedIndex == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = isSelected ? null : index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                            padding: EdgeInsets.all(screenWidth * 0.03),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            transform: isSelected
                                ? Matrix4.identity().scaled(1.05)
                                : Matrix4.identity(),
                            child: Opacity(
                              opacity: selectedIndex == null || isSelected ? 1.0 : 0.5,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 8,
                                    backgroundColor: investment.color,
                                  ),
                                  SizedBox(width: screenWidth * 0.03),
                                  Expanded(
                                    child: Text(
                                      investment.propertyName,
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.04,
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '\$${investment.amount.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.04,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  if (isSelected) ...[
                                    SizedBox(width: screenWidth * 0.03),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Implement details navigation
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Details for ${investment.propertyName} to be implemented",
                                            ),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.accentColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Text(
                                        "Details",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
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