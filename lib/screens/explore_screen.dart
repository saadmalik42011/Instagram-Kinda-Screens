import 'dart:math';

import 'package:flutter/material.dart';
import 'package:insta_kinda_clone/Model/post.dart';
import 'package:insta_kinda_clone/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExploreScreen extends StatefulWidget {
  final myPost;
  const ExploreScreen({this.myPost});

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<Post> myPost = [];

  @override
  void initState() {
    super.initState();
    getPostData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar(
        screenTitle: 'Explore',
        rightIcon: Icons.search,
        function: () {},
      ),
      body: ListView.separated(
          itemBuilder: (context, i) => PostWidget(
                title: myPost == null ? 'Loading...' : myPost[i].title,
                id: myPost[i].userId,
                //picture with id 86 does not exist so i hard coded it
                postImage:
                    'https://picsum.photos/id/${i + 1 == 86 ? 102 : i + 1}/200/300',
              ),
          separatorBuilder: (context, i) => Divider(),
          itemCount: myPost.length),
    );
  }

  void getPostData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      myPost = (json.decode(response.body) as List)
          .map(
            (i) => Post.fromJson(i),
          )
          .toList();

      setState(() {});
    } else {
      print(response.statusCode);
    }
  }
}
