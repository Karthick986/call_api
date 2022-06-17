import 'dart:convert';

import 'package:call_api/model/get_posts_model.dart';
import 'package:http/http.dart' as http;

class GetPostService {
  Future<List<GetPostModel>> getPosts() async {
    var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var posts = jsonDecode(response.body);

    List<GetPostModel> postApiList = posts.map<GetPostModel>((json) =>
    GetPostModel.fromJson(json)).toList();

    return postApiList;
  }
}