import 'package:call_api/model/get_posts_model.dart';
import 'package:call_api/service/get_posts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API call',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'API call demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<GetPostModel> postList = [];

  getPosts() async {
    postList = await GetPostService().getPosts();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: ListView.builder(itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(postList[index].title.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                Text(postList[index].body.toString(),
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),)
              ],
            ),
          );
        }, itemCount: postList.length,),
      ));
  }
}
