import 'package:demo_site/pages/add_post_page.dart';
import 'package:demo_site/pages/read_post_page.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ListTab extends StatefulWidget {
  const ListTab({super.key, required this.category, required this.token});

  final String category;
  final String token;
  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  late List postData = [];
  Future<void> readPost() async {
    await http
        .get(
      Uri.parse(
          "http://ec2-13-125-199-181.ap-northeast-2.compute.amazonaws.com:8000/article/"),
    )
        .then((value) {
      setState(() {
        postData = jsonDecode(utf8.decode(value.bodyBytes));
        print(postData);
      });
    });

    _category();
  }

  List _postList = [];
  Map categoryMatch = {
    "running": "러닝",
    "hiking": "등산",
  };
  void _category() {
    for (var element in postData) {
      if (element['category'] == widget.category) {
        setState(() {
          _postList.add(element);
        });
      } else if (widget.category == "Hot") {
        setState(() {
          _postList = postData;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readPost();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListView.builder(
          itemCount: _postList.length,
          itemBuilder: (_, index) {
            return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReadPost(
                              title: _postList[index]['title'],
                              content: _postList[index]['content'],
                              articleId: _postList[index]['id'],
                              postDatas: _postList[index],
                              token: widget.token,
                            )));
              },
              shape: const Border(
                bottom: BorderSide(
                    color: Color.fromARGB(255, 173, 173, 173), width: 0.2),
              ),
              contentPadding: const EdgeInsets.fromLTRB(30, 5, 20, 5),
              isThreeLine: true,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${categoryMatch[_postList[index]['category']]}",
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color.fromRGBO(74, 74, 74, 0.612),
                    ),
                  ),
                  Text("${_postList[index]['title']}"),
                ],
              ),
              subtitle: const Row(
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
            );
          }),
    );
  }
}
