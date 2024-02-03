import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReadPost extends StatefulWidget {
  const ReadPost({
    super.key,
    required this.title,
    required this.content,
    required this.articleId,
    required this.token,
    required this.postDatas,
  });
  final String title;
  final String content;
  final int articleId;
  final String token;
  final Map postDatas;

  @override
  State<ReadPost> createState() => _ReadPostState();
}

class _ReadPostState extends State<ReadPost> {
  void _deletePost() async {
    await http.delete(
      Uri.parse(
          "http://ec2-13-125-199-181.ap-northeast-2.compute.amazonaws.com:8000/article/${widget.articleId}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${widget.token}',
      },
      body: jsonEncode(<String, dynamic>{
        "article_id": widget.articleId,
      }),
    );
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  _deletePost();
                },
                icon: const Icon(Icons.delete))
          ],
          shape: const Border(
              bottom: BorderSide(
                  style: BorderStyle.solid,
                  width: 0.1,
                  color: Color.fromARGB(255, 135, 135, 135))),
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 30, 50, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("등산", style: TextStyle(fontSize: 12)),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(widget.title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold,)),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Text(
                          "by",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "익명의 러너",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(255, 69, 0, 100),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const BorderLine(),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(widget.content),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Column(
                  children: [
                    const BorderLine(),
                    if (widget.postDatas['banner_link'] != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.network(
                              widget.postDatas['banner_link'],
                              width: MediaQuery.of(context).size.width * 0.25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                            child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 5,
                                          strutStyle:
                                              const StrutStyle(fontSize: 16.0),
                                          text: TextSpan(
                                              text: widget
                                                  .postDatas['banner_slogan'],
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      'NanumSquareRegular')),
                                        )),
                                      ],
                                    )),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                            child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 5,
                                          strutStyle:
                                              const StrutStyle(fontSize: 16.0),
                                          text: TextSpan(
                                              text: widget
                                                  .postDatas['banner_desc'],
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  height: 1.4,
                                                  fontSize: 12.0,
                                                  fontFamily:
                                                      'NanumSquareRegular')),
                                        )),
                                      ],
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    const BorderLine(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class BorderLine extends StatelessWidget {
  const BorderLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.1,
            color: Color.fromARGB(255, 135, 135, 135),
          ),
        ),
      ),
    );
  }
}
