import 'package:demo_site/pages/add_post_page.dart';
import 'package:demo_site/pages/sign_up_page.dart';
import 'package:demo_site/widgets/list_view.dart';
import 'package:flutter/material.dart';
import '../designs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Runner's club",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(255, 69, 0, 100)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: "Runner's Club"),
    );
  }
}

///Text theme
TextTheme tt(BuildContext context) => Theme.of(context).textTheme;
//Color scheme
ColorScheme cs(BuildContext context) => Theme.of(context).colorScheme;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLogined = false;
  final _formKey = GlobalKey<FormBuilderState>();

  void onLogin() async {
    // Validate and save the form values
    _formKey.currentState?.saveAndValidate();
    debugPrint(_formKey.currentState?.value.toString());

    // On another side, can access all field values without saving form with instantValues
    _formKey.currentState?.validate();
    String inputEmail = _formKey.currentState?.instantValue['email'];
    String password = _formKey.currentState?.instantValue['password'];
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      http.Response response = await http.post(
        Uri.parse(
            "http://ec2-13-125-199-181.ap-northeast-2.compute.amazonaws.com:8000/user/login"),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        },
        body: {
          "username": inputEmail,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MainPage(
                    token: jsonDecode((response.body))["access_token"])));
      }
    }
  }

  void loginSkip() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MainPage(
            token:
                "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ0ZXN0MTIzNEBnbWFpbC5jb20iLCJleHAiOjE3MDY5NzcwNzd9.Nza9B8ZAbtcNCIC2U1W3aUAhn_MgnxFNOrEc51-cgQM"),
      ),
    );
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
                children: [
                  FormBuilderTextField(
                    name: 'email',
                    decoration: const InputDecoration(labelText: 'Email'),
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    //Button to generate according to the contents of the text fields
                    child: Buttons.primary(context, "Login", () => {onLogin()}),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    //Button to generate according to the contents of the text fields
                    child: Buttons.secondary(
                        context,
                        "Sign up",
                        () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUp()))
                            }),
                  ),
                  ///// 삭제해야 함
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    //Button to generate according to the contents of the text fields
                    child: Buttons.secondary(
                        context, "로그인 건너뛰기", () => {loginSkip()}),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
