import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_bloc/cubits/auth_cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;
  AuthCubit() : super(AuthInitialState()) {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      // Logged In
      emit(AuthLoggedInState(currentUser));
    } else {
      // Logged out
      emit(AuthLoggedOutState());
    }
  }

  void sendOTP(String phoneNumber) async {
    emit(AuthLoadingState());
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: ((phoneAuthCredential) {
          signInWithPhone(phoneAuthCredential);
        }),
        codeSent: ((verificationId, forceResendingToken) {
          _verificationId = verificationId;
          emit(AuthCodeSentState());
        }),
        verificationFailed: ((error) {
          emit(AuthErrorState(error.message.toString()));
        }),
        codeAutoRetrievalTimeout: ((verificationId) {
          _verificationId = verificationId;
        }));
  }

  void verifyOTP(String otp) async {
    emit(AuthLoadingState());

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: otp);
    signInWithPhone(credential);
  }

  void signInWithPhone(PhoneAuthCredential credential) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        emit(AuthLoggedInState(userCredential.user!));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(e.message.toString()));
    }
  }

  void loggedOut() async {
    await _auth.signOut();
    emit(AuthLoggedOutState());
  }
}
