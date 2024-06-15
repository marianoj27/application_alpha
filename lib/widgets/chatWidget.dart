import 'package:application_alpha/widgets/textWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../sharedPreferencesHelper.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.msg, required this.chatIndex});

  final String msg;
  final int chatIndex;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: chatIndex == 0 ? Colors.white: Colors.teal,
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  chatIndex == 0 ? "assets/profile_icon.png" :"assets/user_icon.png",
                  width: 30,
                  height: 30,),
                SizedBox(width: 10,),
                Expanded(
                    child:
                    TextWidget(label: msg,)
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
