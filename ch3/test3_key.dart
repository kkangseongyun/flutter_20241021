import 'package:flutter/material.dart';

void main() => runApp(MyListWidget());

class MyListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListState();
  }
}
class ListState extends State<MyListWidget> {
  //위젯 목록..
  List<Widget> widgets = [
    //타입이 다른 위젯.... key 매핑 안한 경우...
    //==>타입으로 식별이 됨으로 widget 과 state 매핑에 문제가 없다..
    // MyItemWidget(Colors.red),
    // MyItemWidget2(Colors.blue),

    //동일 타입, key 매핑 안한 경우..
    //타입으로 식별이 안되는 경우.. 순서 로 매핑시 문제 발생..
    // MyItemWidget(Colors.red),
    // MyItemWidget(Colors.blue),

    //동일 타입, key 를 지정한 경우..
    MyItemWidget(Colors.red, key: UniqueKey(),),
    MyItemWidget(Colors.blue, key: UniqueKey(),),
  ];
  onChange() {
    //event callback..
    setState(() {
      //화면에 출력되는 위젯의 순서를 변경..
      widgets.insert(1, widgets.removeAt(0));
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Key Test'),),
        body: Column(
          children: [
            Row(children: widgets,),
            ElevatedButton(onPressed: onChange, child: Text('toggle'),),
          ],
        ),
      ),
    );
  }
}

class MyItemWidget extends StatefulWidget {
  Color color;
  MyItemWidget(this.color, {Key? key}): super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MyItemState(color);
  }
}
class MyItemState extends State<MyItemWidget> {
  Color color;
  MyItemState(this.color);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          color: color,
          width: 150,
          height: 150,
        ),
    );
  }
}

class MyItemWidget2 extends StatefulWidget {
  Color color;
  MyItemWidget2(this.color);
  @override
  State<StatefulWidget> createState() {
    return MyItemState2(color);
  }
}
class MyItemState2 extends State<MyItemWidget2> {
  Color color;
  MyItemState2(this.color);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: color,
        width: 150,
        height: 150,
      ),
    );
  }
}