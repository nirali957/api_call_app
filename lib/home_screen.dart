import 'dart:convert';

import 'package:api_call_app/model/poste_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostsModal> postsList = [];

  @override
  void initState() {
    // TODO: implement initState
    getPostsAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: ListView.separated(
        itemCount: postsList.length,
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemBuilder: (context, index) => ListTile(
          tileColor: Colors.green,
          title: Text(postsList[index].title!),
          subtitle: Text(postsList[index].body!),
        ),
      ),
    );
  }

  getPostsAPI() async {
    Client client = http.Client();
    try {
      Response response = await client.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
      if (response.statusCode == 200) {
        postsList = (jsonDecode(response.body) as List?)!.map((dynamic e) => PostsModal.fromJson(e)).toList();
        // PostsModal postsModal = PostsModal.fromJson(jsonDecode(response.body));
        setState(() {});
      } else {
        debugPrint("Status Code -------------->>> ${response.statusCode}");
      }
    } finally {
      client.close();
    }
  }
}
