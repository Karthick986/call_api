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
  List<GetPostModel> filterPostList = [];
  bool showEmpty = false, filterOnOff = false;
  TextEditingController searchController = TextEditingController();

  void onSearchPosts() {
    filterPostList.clear();

    if (searchController.text.isEmpty) {
      filterOnOff = false;
    } else {
      filterOnOff = true;

      filterPostList = postList
          .where((element) => element.title
              .toString()
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    }

    setState(() {});
  }

  Widget buildPosts(List<GetPostModel> postList, index) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            postList[index].title.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            postList[index].body.toString(),
            style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
          )
        ],
      ),
    );
  }

  getPosts() async {
    postList = await GetPostService().getPosts();
    setState(() {
      if (postList.isEmpty) {
        showEmpty = true;
      } else {
        showEmpty = false;
      }
    });
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) => onSearchPosts(),
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                      hintText: "Search here...",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4))),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: showEmpty
                    ? const Center(
                        child: Text("No data available"),
                      )
                    : filterOnOff
                        ? filterPostList.isEmpty
                            ? const Center(
                                child: Text("No data available"),
                              )
                            : Scrollbar(
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return buildPosts(filterPostList, index);
                                  },
                                  itemCount: filterPostList.length,
                                ),
                              )
                        : postList.isEmpty
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Scrollbar(
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return buildPosts(postList, index);
                                  },
                                  itemCount: postList.length,
                                ),
                              ),
              ),
            ],
          ),
        ));
  }
}
