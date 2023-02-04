import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validation_bloc_cubit/screens/signin/bloc/signin_bloc.dart';
import 'package:form_validation_bloc_cubit/screens/signin/bloc/signin_event.dart';
import 'package:form_validation_bloc_cubit/screens/signin/bloc/signin_state.dart';

class SignInScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign In")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            BlocBuilder<SignInBloc, SignInState>(
              builder: (context, state) {
                if (state is SignInErrorState) {
                  return Text(
                    state.error,
                    style: const TextStyle(color: Colors.red),
                  );
                }
                return const SizedBox();
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailController,
              onChanged: ((value) {
                BlocProvider.of<SignInBloc>(context).add(SignInTextChangedEvent(
                    emailController.text, passwordController.text));
              }),
              decoration: InputDecoration(hintText: "Email Address"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passwordController,
              onChanged: (value) {
                BlocProvider.of<SignInBloc>(context).add(SignInTextChangedEvent(
                    emailController.text, passwordController.text));
              },
              obscureText: true,
              decoration: InputDecoration(hintText: "Password"),
            ),
            const SizedBox(height: 20),
            BlocBuilder<SignInBloc, SignInState>(
              builder: (context, state) {
                if (state is SignInLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ElevatedButton(
                  onPressed: () {
                    if (state is SignInValidState) {
                      BlocProvider.of<SignInBloc>(context).add(
                          SignInSubmittedEvent(
                              emailController.text, passwordController.text));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: (state is SignInValidState)
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                      minimumSize:
                          Size(MediaQuery.of(context).size.width * 0.8, 45)),
                  child: const Text("Sign In"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
