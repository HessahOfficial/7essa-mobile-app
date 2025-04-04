import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../utils/validator.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {

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

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.accentColor,
        backgroundColor: AppColors.accentColor,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white,),
        ),
      ),
      backgroundColor: AppColors.accentColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: screenHeight * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.white1,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)
                  )
              ),
              width: screenWidth,
              height: screenHeight,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  right: screenWidth * 0.06,
                  left: screenWidth * 0.06
                ),
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text("Contact Us", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25
                        ),),
                      ),
                      SizedBox(height: 20,),
                      CustomTextField(
                        controller: nameController,
                        icon: Icons.person,
                        iconSize: 20,
                        iconColor: AppColors.orange950,
                        inputColor: AppColors.white2,
                        iconBackgroundColor: AppColors.lightOrange,
                        placeholder: "Full Name",
                        screenWidth: screenWidth,
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
                        controller: emailAddressController,
                        icon: Icons.email_rounded,
                        iconColor: AppColors.green800,
                        inputColor: AppColors.white2,
                        iconBackgroundColor: AppColors.green100,
                        placeholder: "Email Address",
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
                        controller: phoneController,
                        icon: Icons.phone,
                        iconColor: AppColors.purple950,
                        inputColor: AppColors.white2,
                        iconBackgroundColor: AppColors.purple100,
                        placeholder: "Phone No (20...)",
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
                        controller: messageController,
                        inputColor: AppColors.white2,
                        placeholder: "Message",
                        screenWidth: screenWidth,
                        type: TextInputType.multiline,
                        maxLines: 5,
                        maxLenght: 500,
                        onChanged: (value) {
                          setState(() {
                            message = value;
                            errorMessage = Validator.validateMessage(message: message);
                          });
                        },
                      ),
                      SizedBox(height: 2,),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(errorMessage, style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),),
                      ),
                      SizedBox(height: 10,),
                      CustomButton(
                          width: double.infinity,
                          height: 50,
                          text: "Send",
                          onTap: () {}
                      )
                    ],
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
