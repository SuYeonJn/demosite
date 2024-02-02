import 'package:flutter/material.dart';
import '../designs.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const TextField(),
            const TextField(),
            Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 100),
                //Button to generate according to the contents of the text fields
                child: Buttons.primary(context, "포스팅 하기", () => null))
          ],
        ),
      ),
    );
  }
}
