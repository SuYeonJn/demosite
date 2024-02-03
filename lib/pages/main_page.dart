import 'package:demo_site/pages/add_post_page.dart';
import 'package:demo_site/pages/sign_up_page.dart';
import 'package:demo_site/widgets/list_view.dart';
import 'package:flutter/material.dart';
import '../designs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../main.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
    required this.token,
  });
  final String token;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Row(
            children: [
              Image(
                image: AssetImage("assets/images/logo.png"),
                width: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Runner's club",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          bottom: const TabBar(
              padding: EdgeInsets.only(left: 20),
              tabAlignment: TabAlignment.start,
              indicatorColor: Color.fromRGBO(255, 69, 0, 100),
              isScrollable: true,
              tabs: [
                Tab(
                  text: "Hot",
                ),
                Tab(
                  text: "러닝",
                ),
                Tab(
                  text: "등산",
                ),
              ]),
        ),
        body: TabBarView(children: [
          ListTab(
            category: "Hot",
            token: widget.token,
          ),
          ListTab(
            category: "running",
            token: widget.token,
          ),
          ListTab(
            category: "hiking",
            token: widget.token,
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(255, 69, 0, 100),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddPost(token: widget.token)));
          },
          child: const Icon(
            Icons.add,
            color: Color.fromRGBO(255, 255, 255, 0.612),
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
