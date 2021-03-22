import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_kinda_clone/widgets/widgets.dart';
import 'package:insta_kinda_clone/constant.dart';
import 'package:flutter/widgets.dart';

class ProfileScreen extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String imageURL;
  final String bio;

  const ProfileScreen({this.firstName, this.lastName, this.imageURL, this.bio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar(
        screenTitle: 'Profile',
        rightIcon: Icons.more_horiz,
        function: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(imageURL),
                  radius: 35,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '$firstName $lastName',
                  style: kUserNameStyle,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Text(
                    bio,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                ),
                buildInfoWidget(),
                Divider(
                  thickness: 1,
                ),
                buildButtons(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Photos',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.listUl,
                              size: 25,
                              color: Colors.black26,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.grid_view,
                              size: 30,
                              color: Colors.black26,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  child: GridViewWidget(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildInfoWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ReusableDetailWidget(
              upperTitle: '438',
              lowerTitle: 'Posts',
            ),
            ReusableDetailWidget(
              upperTitle: '298',
              lowerTitle: 'Following',
            ),
            ReusableDetailWidget(
              upperTitle: '321K',
              lowerTitle: 'Followers',
            ),
          ],
        ),
      ),
    );
  }

  Container buildButtons() {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ReusableButton(
            title: 'Follow',
            textColor: koffWhite,
            backgroundColor: kBlueishColor,
            border: null,
          ),
          ReusableButton(
            title: 'Message',
            textColor: Colors.black87,
            backgroundColor: null,
            border: Border.all(color: kBlueishColor),
          ),
        ],
      ),
    );
  }
}
