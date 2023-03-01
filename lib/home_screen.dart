import 'dart:convert';

import 'package:api_call_second/model/character_model.dart';
import 'package:api_call_second/model/posts_model.dart';
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
  CharacterModal? characterModal;

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
      // body: characterModal == null
      //     ? const Center(child: CircularProgressIndicator())
      //     : ListView.separated(
      //         itemCount: characterModal!.results!.length,
      //         separatorBuilder: (context, index) => const SizedBox(height: 15),
      //         itemBuilder: (context, index) => ListTile(
      //           tileColor: Colors.green,
      //           leading: Image.network(characterModal!.results![index].image!),
      //           title: Text(characterModal!.results![index].name!),
      //           subtitle: Text(characterModal!.results![index].status!),
      //         ),
      //       ),
      body: Column(
        children: [
          Expanded(
            child: postsList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    itemCount: postsList.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 15),
                    itemBuilder: (context, index) => ListTile(
                      tileColor: Colors.green,
                      title: Text(postsList[index].title!),
                      subtitle: Text(postsList[index].body!),
                    ),
                  ),
          ),
          ElevatedButton(
            onPressed: () {
              setPostsAPI();
            },
            child: const Text("Send Data"),
          ),
        ],
      ),
    );
  }

  getPostsAPI() async {
    Client client = http.Client();
    try {
      Response response = await client.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
      if (response.statusCode == 200) {
        postsList = (jsonDecode(response.body) as List?)!.map((dynamic e) => PostsModal.fromJson(e)).toList();
        // characterModal = CharacterModal.fromJson(jsonDecode(response.body));
        // debugPrint("characterModal -------------->>> ${characterModal!.toJson()}");
        setState(() {});
      } else {
        debugPrint("Status Code -------------->>> ${response.statusCode}");
      }
    } finally {
      client.close();
    }
  }

  setPostsAPI() async {
    Client client = http.Client();
    try {
      Response response = await client.post(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "userId": 11,
          "it": 101,
          "title": "Mohil Thummar",
          "body": "Skill Qode",
        }),
      );
      if (response.statusCode == 200) {
        debugPrint("Response -------------->>> ${jsonDecode(response.body)}");
        setState(() {});
      } else if (response.statusCode == 201) {
        debugPrint("Response -------------->>> ${jsonDecode(response.body)}");
        setState(() {});
      } else {
        debugPrint("Status Code -------------->>> ${response.statusCode}");
      }
    } finally {
      client.close();
    }
  }
}

