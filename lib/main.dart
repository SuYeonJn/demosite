import 'package:demo_site/pages/add_post_page.dart';
import 'package:demo_site/widgets/hotList.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Row(
            children: [
              const Image(
                image: AssetImage("assets/images/logo.png"),
                width: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
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
        body: const TabBarView(children: [
          HotList(),
          Placeholder(),
          Placeholder(),
        ]),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(255, 69, 0, 100),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddPost()));
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
