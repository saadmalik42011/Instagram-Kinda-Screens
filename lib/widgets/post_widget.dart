import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_kinda_clone/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:insta_kinda_clone/screens/screen.dart';

class PostWidget extends StatefulWidget {
  final title;
  final id;
  final postImage;

  const PostWidget({@required this.title, @required this.id, this.postImage});

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  String firstName = '';
  String lastName = '';
  String imageURL = '';
  String bio = '';

  @override
  void initState() {
    super.initState();
    getUserData(
      widget.id.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: isPortrait()
            ? MediaQuery.of(context).size.height / 1.5
            : MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                            firstName: firstName,
                            lastName: lastName,
                            imageURL: imageURL,
                            bio: bio,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              imageURL == '' ? null : NetworkImage(imageURL),
                          backgroundColor: Colors.transparent,
                          radius: 26,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$firstName $lastName',
                              style: kNameTextStyle,
                            ),
                            Text(
                              '20 minutes ago',
                              style: kDurationTextStyle,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Icon(
                    Icons.more_horiz,
                    color: kOffBlack,
                    size: 30,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 26,
                          child: Icon(
                            FontAwesomeIcons.comment,
                            size: 35,
                            color: kOffBlack,
                          ),
                        ),
                        Text(
                          '254',
                          style: kNoDigitsTextStyle,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Icon(
                          Icons.favorite_border,
                          size: 35,
                          color: kFavouriteColor,
                        ),
                        Text(
                          '3456',
                          style: kNoDigitsTextStyle,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.4,
                          child: Text(
                            widget.title,
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Container(
                            width: isPortrait()
                                ? MediaQuery.of(context).size.width / 1.4
                                : MediaQuery.of(context).size.width / 1.2,
                            decoration: buildBoxDecoration(),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void getUserData(String id) async {
    var url = Uri.parse('https://reqres.in/api/users/${id}');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      if (mounted) {
        setState(
          () {
            firstName = jsonDecode(response.body)['data']['first_name'];
            lastName = jsonDecode(response.body)['data']['last_name'];
            imageURL = jsonDecode(response.body)['data']['avatar'];
            bio = jsonDecode(response.body)['support']['text'];
          },
        );
      }
    } else {
      print(response.statusCode);
    }
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.fill,
        image: NetworkImage(widget.postImage),
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    );
  }

  bool isPortrait() {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return true;
    }
    return false;
  }
}
