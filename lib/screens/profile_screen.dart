import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hessa/screens/become_investor_screen.dart';
import 'package:hessa/widgets/custom_intent_icon.dart';
import 'package:hessa/widgets/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/app_colors.dart';
import '../utils/validator.dart';
import '../widgets/custom_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  TextEditingController nameController = TextEditingController();
  String name = "";
  String errorName = "";

  TextEditingController emailAddressController = TextEditingController();
  String emailAddress = "";
  String errorEmailAddress = "";

  TextEditingController phoneController = TextEditingController();
  String phone = "";
  String errorPhone = "";

  TextEditingController messageController = TextEditingController();
  String message = "";
  String errorMessage = "";

  TextEditingController passwordController = TextEditingController();
  String password = "";
  String errorPassword = "";

  TextEditingController walletPasswordController = TextEditingController();
  String walletPassword = "";
  String errorWalletPassword = "";

  File? image;
  ImagePicker imagePicker = ImagePicker();

  Future<void> showChooserBottomSheet(BuildContext context) async {

    TextStyle style = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15
    );

    double iconSize = 40;

    showModalBottomSheet(context: context, builder: (BuildContext bc) {
      return SafeArea(
          child: Container(
            height: 150,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 30
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIntentIcon(
                    title: "Camera",
                    iconSize: iconSize,
                    titleStyle: style,
                    onTap: () {
                      pickImage(ImageSource.camera);
                      Get.back();
                    },
                    icon: Icons.photo_camera,
                  ),
                  SizedBox(width: 100,),
                  CustomIntentIcon(
                    title: "Gallery",
                    iconSize: iconSize,
                    titleStyle: style,
                    onTap: () {
                      pickImage(ImageSource.gallery);
                      Get.back();
                    },
                    icon: Icons.photo_library,
                  ),
                ],
              ),
            ),
          )
      );
    });
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedImage = await imagePicker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
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
          child: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.accentColor,),
        ),
        title: Text("Personal Profile", style: TextStyle(
            fontWeight: FontWeight.bold
        ),),
      ),
      backgroundColor: AppColors.white1,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.06
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 25,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      margin: EdgeInsets.only(
                        top: 30,
                        left: 20,
                        right: 20,
                        bottom: 10
                      ),
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          // color: AppColors.accentColor,
                          borderRadius: BorderRadius.circular(16)
                      ),
                      child: image == null ? 
                        SvgPicture.asset("assets/images/google.svg", fit: BoxFit.cover,)
                        : Image.file(image!, fit: BoxFit.cover,),
                    ),
                    GestureDetector(
                      onTap: () {
                        showChooserBottomSheet(context);
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColors.accentColor,
                        child: Icon(Icons.add_a_photo_rounded, size: 20, color: Colors.white),
                      )
                    ),
                  ],
                )
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: nameController,
                  inputColor: AppColors.white2,
                  label: "Username",
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
                SizedBox(height: 2,),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(errorName, style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),),
                ),
                SizedBox(height: 10,),
                CustomTextField(
                  controller: phoneController,
                  labelColor: Colors.black,
                  inputColor: AppColors.white2,
                  label: "Phone no.",
                  screenWidth: screenWidth,
                  type: TextInputType.phone,
                  obscure: true,
                  onChanged: (value) {
                    setState(() {
                      phone = value;
                      errorPhone = Validator.validatePhone(phone: phone);
                    });
                  },
                ),
                SizedBox(height: 2,),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(errorPhone, style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),),
                ),
                SizedBox(height: 10,),
                CustomTextField(
                  controller: emailAddressController,
                  labelColor: Colors.black,
                  inputColor: AppColors.white2,
                  label: "Email Address",
                  screenWidth: screenWidth,
                  type: TextInputType.emailAddress,
                  onChanged: (value) {
                    setState(() {
                      emailAddress = value;
                      errorEmailAddress = Validator.validateEmailAddress(email: emailAddress);
                    });
                  },
                ),
                SizedBox(height: 2,),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(errorEmailAddress, style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),),
                ),
                SizedBox(height: 10,),
                CustomTextField(
                  controller: passwordController,
                  inputColor: AppColors.white2,
                  label: "Password",
                  labelColor: Colors.black,
                  screenWidth: screenWidth,
                  type: TextInputType.text,
                  obscure: true,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                      errorPassword = Validator.validatePassword(password: password);
                    });
                  },
                ),
                SizedBox(height: 2,),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(errorPassword, style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),),
                ),
                SizedBox(height: 10,),
                CustomTextField(
                  controller: walletPasswordController,
                  inputColor: AppColors.white2,
                  label: "Wallet Password",
                  labelColor: Colors.black,
                  screenWidth: screenWidth,
                  type: TextInputType.text,
                  obscure: true,
                  onChanged: (value) {
                    setState(() {
                      walletPassword = value;
                      errorWalletPassword = Validator.validatePassword(password: password);
                    });
                  },
                ),
                SizedBox(height: 2,),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(errorWalletPassword, style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),),
                ),
              ],
            ),

            CustomButton(
                width: 150,
                height: 50,
                text: "Save",
                onTap: () {}
            ),
            
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  Get.to(BecomeInvestorScreen());
                },
                child: Text("Become Investor with us", style: TextStyle(
                    color: AppColors.accentColor,
                    decoration: TextDecoration.underline,
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                ),),
              ),
            )
          ]
        ),
      ),
    );
  }
}
