import 'package:demo_site/main.dart';
import 'package:flutter/material.dart';

import '../designs.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _emailFieldKey = GlobalKey<FormBuilderFieldState>();
  void onSignUp() async {
    // Validate and save the form values
    _formKey.currentState?.saveAndValidate();
    debugPrint(_formKey.currentState?.value.toString());

    // On another side, can access all field values without saving form with instantValues
    _formKey.currentState?.validate();
    debugPrint(_formKey.currentState?.instantValue.toString());
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      http.Response response = await http.post(
        Uri.parse(
            "http://ec2-13-125-199-181.ap-northeast-2.compute.amazonaws.com:8000/user/register"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "email": _formKey.currentState?.instantValue['full_name'],
          "username": _formKey.currentState?.instantValue['email'],
          "password1": _formKey.currentState?.instantValue['password'],
          "password2": _formKey.currentState?.instantValue['password'],
        }),
      );
      if (response.statusCode == 204) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const MyHomePage(title: "Runner's club")));
      } else {
        const AlertDialog(title: Text("존재하는 이메일 또는 이름입니다"));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage("assets/images/logo.png"),
                  width: 100,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Runner's club",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FormBuilderTextField(
                      key: _emailFieldKey,
                      name: 'email',
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ]),
                    ),
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      name: 'full_name',
                      decoration: const InputDecoration(labelText: 'Full Name'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      name: 'password',
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      name: 'confirm_password',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        suffixIcon: (_formKey.currentState
                                    ?.fields['confirm_password']?.hasError ??
                                false)
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      obscureText: true,
                      validator: (value) =>
                          _formKey.currentState?.fields['password']?.value !=
                                  value
                              ? 'No coinciden'
                              : null,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      //Button to generate according to the contents of the text fields
                      child: Buttons.secondary(
                          context, "Sign up", () => {onSignUp()}),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
