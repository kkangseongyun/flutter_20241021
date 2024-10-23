import 'package:flutter/material.dart';

class ContentWidget extends StatelessWidget {
  int count = 100;
  String id = 'instagram';
  String content = '동해불과 백두산이 마르고 닳도록 하나님이 보우아사 우리나라 만세.. 동해불과 백두산이 마르고 닳도록 하나님이 보우아사 우리나라 만세..동해불과 백두산이 마르고 닳도록 하나님이 보우아사 우리나라 만세..동해불과 백두산이 마르고 닳도록 하나님이 보우아사 우리나라 만세..동해불과 백두산이 마르고 닳도록 하나님이 보우아사 우리나라 만세..동해불과 백두산이 마르고 닳도록 하나님이 보우아사 우리나라 만세..동해불과 백두산이 마르고 닳도록 하나님이 보우아사 우리나라 만세..';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('좋아요 $count'),
        Text('$id $content'),
      ],
    );
  }
}