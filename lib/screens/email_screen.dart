import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:get/get.dart";
import "package:hessa/constants/app_colors.dart";
import "package:hessa/widgets/custom_button.dart";
import "package:hessa/widgets/custom_circular_button.dart";
import "package:hessa/widgets/custom_text_field.dart";


class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    TextEditingController emailAddressController = TextEditingController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.secondary,
        body: Expanded(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Expanded(
                 flex: 1,
                 child: Padding(padding: EdgeInsets.symmetric(vertical: screenHeight * 0.1),
               child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   SvgPicture.asset("assets/images/Logo-white.svg"),
                  ],
               )
             )),
             Expanded(
               flex: 2,
                 child: Container(
               width: screenWidth,
               decoration: BoxDecoration(
                 color: AppColors.white1,
                 borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
               ),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Padding(
                     padding: EdgeInsets.only(bottom: screenHeight * 0.1),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         Text("Start your investments now!", style: TextStyle(
                             fontWeight: FontWeight.w900,
                             fontSize: 23
                         ),),
                         //
                         Padding(
                           padding: EdgeInsets.symmetric(vertical: screenHeight * 0.06),
                           child: customTextField(
                             controller: emailAddressController,
                             icon: Icons.email_rounded,
                             iconColor: AppColors.green800,
                             inputColor: AppColors.white2,
                             iconBackgroundColor: AppColors.green100,
                             placeholder: "Enter your email to continue..",
                             screenWidth: screenWidth,
                             type: TextInputType.emailAddress
                           ),),

                         customButton(
                           width: 150,
                           height: 50,
                           text: "Continue",
                           onTap: () {
                             print("email: ${emailAddressController.text}");
                           }
                         ),
                       ],
                     ),),

                   customCircularButton(
                       child: SvgPicture.asset("assets/images/google.svg", width: 30, height: 30,)
                   )

                 ],
               ),
             ))
           ],
         ),
        )
      ),
    );
  }
}
