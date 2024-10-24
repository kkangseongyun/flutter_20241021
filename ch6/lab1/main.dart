import 'package:flutter/material.dart';
import 'four_screen.dart';
import 'one_screen.dart';
import 'three_screen.dart';
import 'two_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/one',
      routes: {//이름과 Route 를 매핑해서 등록..
        '/one': (context) => OneScreen(),
        '/two': (context) => TwoScreen(),
      },
      //만약 어디선가 화면 전환 요청이 들어왔을때, 전환되는 화면이 동적으로 결정되거나..
      //어떤 업무 처리가 된 후에 전환 되어야 한다면..
      //화면 전환 요청이 들어올 때마다 반복 호출.. 매개변수에 요청 정보 포함.. 전달 데이터 포함
      onGenerateRoute: (setting){
        if(setting.name == '/three'){
         //업무로직 돌렸다고 하고..
         return MaterialPageRoute(
           builder: (context) => ThreeScreen(),
           settings: setting//전달하는 데이터 그대로..
         ) ;
        }else if(setting.name == '/four'){
          return MaterialPageRoute(
              builder: (context) => FourScreen(),
              settings: setting//전달하는 데이터 그대로..
          ) ;
        }
      },
    );
  }
}