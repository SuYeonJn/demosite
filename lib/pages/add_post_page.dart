import 'package:demo_site/pages/main_page.dart';
import 'package:flutter/material.dart';
import '../designs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddPost extends StatefulWidget {
  const AddPost({super.key, required this.token});
  final String token;

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> with TickerProviderStateMixin {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _content = TextEditingController();
  bool adClicked = false;
  void _addPost() async {
    setState(() {
      adClicked = true;
    });
    http.Response response = await http.post(
      Uri.parse(
          "http://ec2-13-125-199-181.ap-northeast-2.compute.amazonaws.com:8000/article/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${widget.token}',
      },
      body: jsonEncode(<String, dynamic>{
        "category": categories[categorySelect],
        "title": _title.text.toString(),
        "content": _content.text.toString(),
      }),
    );
    print(response.body);
    print("${_title.text} ${_content.text}");
    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage(token: widget.token)),
      );
    }
  }

  int categorySelect = 0;
  List categories = [
    "hiking",
    "running",
  ];
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "글 쓰기",
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: false,
        ),
        body: Stack(children: [
          if (adClicked)
            Positioned(
              top: MediaQuery.of(context).size.height * 0.3,
              left: MediaQuery.of(context).size.height * 0.3,
              child: CircularProgressIndicator(
                value: controller.value,
              ),
            ),
          Column(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(45, 20, 45, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: SegmentedButton(
                            selected: <dynamic>{categorySelect},
                            onSelectionChanged: (Set newSelection) {
                              setState(() {
                                categorySelect = newSelection.first;
                              });
                            },
                            segments: const [
                              ButtonSegment(
                                value: 0,
                                label: Text("등산"),
                              ),
                              ButtonSegment(
                                value: 1,
                                label: Text("러닝"),
                              )
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: TextField(
                          controller: _title,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "제목",
                          ),
                        ),
                      ),
                      Container(
                        height: 3,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 0.1,
                              color: Color.fromARGB(255, 135, 135, 135),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: TextFormField(
                              controller: _content,
                              minLines: 4,
                              maxLines: 10,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '내용을 입력하세요',
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  //Button to generate according to the contents of the text fields
                  child: Buttons.primary(context, "포스팅 하기", () => {_addPost()}),
                ),
              )
            ],
          ),
        ]));
  }
}
