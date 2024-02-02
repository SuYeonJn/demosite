import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReadPost extends StatefulWidget {
  const ReadPost({super.key, required this.title, required this.content});
  final String title;
  final String content;
  @override
  State<ReadPost> createState() => _ReadPostState();
}

class _ReadPostState extends State<ReadPost> {
  void readPost() async {
    http.Response response = await http.get(
      Uri.parse(
          "http://ec2-13-125-199-181.ap-northeast-2.compute.amazonaws.com:8000/article/"),
    );
    print(response);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //readPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ),
        body: Column(
          children: [
            Text(widget.title),
            Text(widget.content),
          ],
        ));
  }
}
