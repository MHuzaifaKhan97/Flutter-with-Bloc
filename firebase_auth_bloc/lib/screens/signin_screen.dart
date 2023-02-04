import 'package:firebase_auth_bloc/cubits/auth_cubit/auth_cubit.dart';
import 'package:firebase_auth_bloc/cubits/auth_cubit/auth_state.dart';
import 'package:firebase_auth_bloc/screens/verify_phone_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              child: Column(
                children: [
                  TextField(
                    controller: phoneController,
                    maxLength: 10,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter number",
                        counterText: ""),
                  ),
                  const SizedBox(height: 12),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthCodeSentState) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => VerifyPhoneNumberScreen())));
                      } else if (state is AuthErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 1),
                            content: Container(
                              child: Text(state.error),
                            )));
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ElevatedButton(
                        onPressed: () {
                          String phoneNumber = "+92${phoneController.text}";
                          BlocProvider.of<AuthCubit>(context)
                              .sendOTP(phoneNumber);
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.85, 45)),
                        child: const Text("Sign In"),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
