import 'package:flutter/material.dart';
import 'package:insta_kinda_clone/constant.dart';

class ReusableAppBar extends StatefulWidget implements PreferredSizeWidget {
  final screenTitle;
  final rightIcon;
  final function;

  ReusableAppBar(
      {@required this.screenTitle,
      @required this.rightIcon,
      @required this.function})
      : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;
  @override
  _ReusableAppBarState createState() => _ReusableAppBarState();
}

class _ReusableAppBarState extends State<ReusableAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.screenTitle,
        style: kTitleTextStyle,
      ),
      centerTitle: true,
      elevation: .8,
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: widget.function,
        child: Icon(
          Icons.arrow_back_ios,
          color: kOffBlack,
          size: 20,
        ),
      ),
      actions: [
        Icon(
          widget.rightIcon,
          color: kOffBlack,
          size: 25,
        ),
        SizedBox(
          width: 15,
        ),
      ],
    );
  }
}
