import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hessa/core/helpers/hive_helper.dart';
import 'package:hessa/core/utils/service_locator.dart';
import 'package:meta/meta.dart';

part 'google_state.dart';

class GoogleCubit extends Cubit<GoogleState> {
  GoogleCubit() : super(GoogleInitial());

  Future<void> signInWithGoogle() async {
    emit(GoogleSignInLoading());
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return;
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

      emit(GoogleSignInSuccess(user: userCredentials.user!));
    } catch (e) {
      print("google cubit error: ${e.toString()}");
      emit(GoogleSignInFailure(message: e.toString()));
    }
  }

  Future<void> signOutWithGoogle() async {
    emit(GoogleSignOutLoading());
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
      getIt.get<HiveHelper>().storeCurrentUser(user: null, tokens: null);
      getIt.get<HiveHelper>().storeIsGoogleAuth(isGoogleAuth: null);
      emit(GoogleSignOutSuccess());
    } catch (e) {
      print("google cubit error: ${e.toString()}");
      emit(GoogleSignOutFailure(message: e.toString()));
    }
  }
}
