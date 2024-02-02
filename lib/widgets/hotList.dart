import 'package:demo_site/pages/add_post_page.dart';
import 'package:demo_site/pages/read_post_page.dart';
import 'package:flutter/material.dart';

class HotList extends StatefulWidget {
  const HotList({super.key});

  @override
  State<HotList> createState() => _HotListState();
}

class _HotListState extends State<HotList> {
  List postData = [
    {
      "postId": 1,
      "title": "등산을 잘하고 싶은 극강의 성능충 팁",
      "category": "등산",
      "content": "등산을 잘하고 싶은 극강의 성능충 팁"
    },
    {
      "postId": 1,
      "title": "등산화 추천 좀",
      "category": "등산",
      "content": "등산을 잘하고 싶은 극강의 성능충 팁",
    },
    {
      "postId": 1,
      "title": "러닝같이하실 분",
      "category": "러닝",
      "content": "등산을 잘하고 싶은 극강의 성능충 팁",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListView.builder(
          itemCount: postData.length,
          itemBuilder: (_, index) {
            return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReadPost(
                              title: postData[index]['title'],
                              content: postData[index]['content'],
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
                    "${postData[index]['category']}",
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color.fromRGBO(74, 74, 74, 0.612),
                    ),
                  ),
                  Text("${postData[index]['title']}"),
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
