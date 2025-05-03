import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'google_state.dart';

class GoogleCubit extends Cubit<GoogleState> {
  GoogleCubit() : super(GoogleInitial());

  Future<void> signInWithGoogle() async {
    emit(GoogleLoading());
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        emit(GoogleFailure(message: "Unauthenticated!"));
      }

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredentials = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      emit(GoogleSuccess(user: userCredentials.user!));
    } catch (e) {
      print("google cubit error: ${e.toString()}");
      emit(GoogleFailure(message: e.toString()));
    }
  }
}
