import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final _key = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: FormBuilder(
              key: _key,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: "email",
                      validator: FormBuilderValidators.required(
                          errorText: "Email is required"),
                      decoration: const InputDecoration(
                          hintText: "Enter email",
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 12),
                    FormBuilderTextField(
                      name: "password",
                      obscureText: true,
                      validator: FormBuilderValidators.required(
                          errorText: "Password is required"),
                      decoration: const InputDecoration(
                          hintText: "Enter password",
                          border: OutlineInputBorder()),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_key.currentState!.saveAndValidate()) {
                            var submittedData =
                                _key.currentState!.value['email'];
                            print(submittedData);
                          }
                        },
                        child: const Text("Submit"))
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
