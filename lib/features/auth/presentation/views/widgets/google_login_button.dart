import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hessa/core/widgets/custom_circular_button.dart';
import 'package:hessa/cubits/google/google_cubit.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    void signUpWithGoogle() async {
      await context.read<GoogleCubit>().signInWithGoogle();
    }

    return BlocListener<GoogleCubit, GoogleState>(
      listener: (context, state) {
        if (state is GoogleSignInSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.user.email!),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is GoogleSignInFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: CustomCircularButton(
        onTap: signUpWithGoogle,
        child: SvgPicture.asset(
          "assets/images/google.svg",
          width: 30,
          height: 30,
        ),
      ),
    );
  }
}
