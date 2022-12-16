import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {

  String text;

  NoDataWidget({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/img/waze.png',width: 195,
              height: 130),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50),
            child: Text(text)
          )
        ],
      ),
    );
  }
}
