//material 사용이 필수는 아니다..
//flutter 앱의 화면 구성과 관련된 대부분의 api 를 가지는 패키지..
import 'package:flutter/material.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //필수 오버라이드
  //자동 호출.. 이 함수에서 리턴시킨 Widget 정보대로 화면이 출력된다..
  @override
  Widget build(BuildContext context) {
    //Theme 설정 및 routing 등 앱에 많은 도움을 주는 위젯..
    //root 위젯을 MaterialApp 을 꼭 해야하는 것은 아니지만 대부분...
    return MaterialApp(
      home: Scaffold(//화면의 기본적인 구조(틀)제공 위젯.. 
        appBar: AppBar(//화면의 상단..
          title: Text('My First Test'),
        ),
        body: Column(//여러개를 위아래로 나열하는 위젯..
          children: [
            MyStatelessWidget(),
            MyStatefulWidget(),
          ],
        ),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  bool favorited = false;
  int favoriteCount = 10;

  void toggleFavorite(){
    //event callback 함수..
    //stateless 위젯도 얼마든지 변수 선언할 수 있고, 변수 값을 변경할 수 있다.
    //단지 이 변수가 상태가 아니다...
    //==>변수 값 변경에 의한 화면 갱신이 되지 않는 위젯이다..
    print('stateless, toggleFavorite');
    if(favorited){
      favoriteCount -= 1;
      favorited = false;
    }else {
      favoriteCount += 1;
      favorited = true;
    }
  }
  @override
  Widget build(BuildContext context) {
    print('stateless, build...');
    return Row(//가로로 위젯 여러개를 나열하는 위젯..
      children: [
        IconButton(
            onPressed: toggleFavorite,
            icon: (favorited ? Icon(Icons.star) : Icon(Icons.star_border)),
            color: Colors.red,
        ),
        Text('$favoriteCount')
      ],
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}
class MyState extends State<MyStatefulWidget> {
  bool favorited = false;
  int favoriteCount = 10;

  void toggleFavorite(){
    //event callback 함수..
    print('state, toggleFavorite');
    //state 값 변경에 의해 화면이 갱신되려면..
    //setState() 함수를 호출해야 한다..
    //setState() 는 build() 함수를 다시 호출하는 역할..
    //setState() 매개변수의 함수가 호출이 되고 매개변수 함수 호출이 끝나면
    //build 함수가 자동으로 호출..
    setState(() {
      if(favorited){
        favoriteCount -= 1;
        favorited = false;
      }else {
        favoriteCount += 1;
        favorited = true;
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    print('state, build...');
    return Row(//가로로 위젯 여러개를 나열하는 위젯..
      children: [
        IconButton(
          onPressed: toggleFavorite,
          icon: (favorited ? Icon(Icons.star) : Icon(Icons.star_border)),
          color: Colors.red,
        ),
        Text('$favoriteCount')
      ],
    );
  }
}