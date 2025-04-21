import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

import '../constants/app_colors.dart';
import '../utils/validator.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class BecomeInvestorScreen extends StatefulWidget {
  const BecomeInvestorScreen({super.key});

  @override
  State<BecomeInvestorScreen> createState() => _BecomeInvestorScreenState();
}

class _BecomeInvestorScreenState extends State<BecomeInvestorScreen>
    with WidgetsBindingObserver {
  TextEditingController nameController = TextEditingController();
  String name = "";
  String errorName = "";

  TextEditingController nationalIdController = TextEditingController();
  String nationalId = "";
  String errorNationalId = "";

  bool isTermsAccepted = false; // State for checkbox
  bool isDownloadInProgress = false; // Track download state

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Listen for lifecycle events
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Clean up observer
    nameController.dispose();
    nationalIdController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && isDownloadInProgress) {
      // Cancel any lingering dialog when returning to the app
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      isDownloadInProgress = false;
    }
  }

  // Function to show dialog with circular loading indicator
  Future<void> _showDownloadDialog() async {
    bool isCancelled = false;
    isDownloadInProgress = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Downloading Legal PDF"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Downloading the legal contract..."),
              SizedBox(height: 10),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                isCancelled = true; // Mark as cancelled
                isDownloadInProgress = false;
                Navigator.of(dialogContext).pop(); // Close dialog
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );

    try {
      // Load the PDF from assets
      final ByteData data = await DefaultAssetBundle.of(context)
          .load('assets/pdf/amr_elbaroudy_resume.pdf');
      final List<int> bytes = data.buffer.asUint8List();

      // Prepare file path
      final String tempPath = (await getTemporaryDirectory()).path;
      final String filePath = '$tempPath/amr_elbaroudy_resume.pdf';
      final File pdfFile = File(filePath);

      // Simulate download delay (to show indicator and allow cancellation)
      for (int i = 1; i <= 10; i++) {
        if (isCancelled || !isDownloadInProgress) {
          // Clean up if cancelled
          if (await pdfFile.exists()) {
            await pdfFile.delete();
          }
          return; // Exit the function
        }
        await Future.delayed(Duration(milliseconds: 200)); // ~2s total
      }

      // Write the file and open PDF only if not cancelled
      if (!isCancelled && isDownloadInProgress) {
        await pdfFile.writeAsBytes(bytes, flush: true);

        // Open the PDF
        final result = await OpenFile.open(filePath);
        // Close dialog after opening PDF
          Navigator.of(context).pop();

        isDownloadInProgress = false;
        if (result.type != ResultType.done) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error opening PDF: ${result.message}')),
          );
        }
      }
    } catch (e) {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop(); // Close dialog on error
      }
      isDownloadInProgress = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error downloading PDF: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white1,
        surfaceTintColor: AppColors.white1,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.accentColor,
          ),
        ),
        title: Text(
          "Become Investor",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: AppColors.white1,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 30,
          left: screenWidth * 0.06,
          right: screenWidth * 0.06,
        ),
        child: Column(
          spacing: 25,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: nameController,
                  inputColor: AppColors.white2,
                  label: "Full Name",
                  screenWidth: screenWidth,
                  labelColor: Colors.black,
                  type: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      name = value;
                      errorName = Validator.validateUsername(username: name);
                    });
                  },
                ),
                SizedBox(height: 2),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    errorName,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: nationalIdController,
                  inputColor: AppColors.white2,
                  label: "National ID",
                  screenWidth: screenWidth,
                  labelColor: Colors.black,
                  type: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      nationalId = value;
                      errorNationalId =
                          Validator.validateNationalId(nationalId: nationalId);
                    });
                  },
                ),
                SizedBox(height: 2),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    errorNationalId,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            // Terms and Conditions Checkbox and Download Button
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  value: isTermsAccepted,
                  onChanged: (bool? value) {
                    setState(() {
                      isTermsAccepted = value ?? false;
                    });
                  },
                  activeColor: AppColors.accentColor,
                ),
                Expanded(
                  child: Text(
                    "I agree to the terms & conditions",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            CustomButton(
              width: 250,
              height: 50,
              text: "Download the Legal Contract",
              onTap: _showDownloadDialog,
            ),
            // Save Button
            CustomButton(
              width: 150,
              height: 50,
              text: "Save",
              onTap: isTermsAccepted &&
                  errorName.isEmpty &&
                  errorNationalId.isEmpty
                  ? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Details saved successfully')),
                );
              }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}