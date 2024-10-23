import 'package:flutter/material.dart';

// import './widgets/header_widget.dart';//상대경로..
//절대경로... 패키지명 => lib 폴더..
import 'package:flutter_lab/ch4/widgets/header_widget.dart'; //절대경로..
import './widgets/image_widget.dart';
import './widgets/icon_widget.dart';
import './widgets/content_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Layout Test'),
        ),
        //위젯으로 화면을 구성하다가.. 가로 혹은 세로방향으로 화면을 벗어나게 되면..
        //경고 패턴이 자동으로 출력.. 스크롤을 준비하지 않았다는 의미..
        //스크롤 될 수 있게 준비를 해주어야 한다..
        //SingleChildScrollView - 단일 위젯을 스크롤 시키고자 할때..
        //ListView - 여러 위젯을 스크롤 시키고자 할때..
        body: SingleChildScrollView(
          child: Column(
            children: [
              HeaderWidget(),
              ImageWidget(),
              IconWidget(),
              ContentWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
