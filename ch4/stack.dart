import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Layout Test'),
        ),
        body: Stack(
          children: [
            Container(
              color: Colors.pink,
            ),
            Align(
              alignment: Alignment(0.0, 0.0),
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('images/lab_lotte_1.jpg', width: 350,),
                      Container(
                        width: 350,
                        height: 100,
                        color: Colors.white,
                        padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('롯데웨딩워크', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                            Spacer(),
                            Text('각 지점 본 매장'),
                            Text('1월1일(월) ~ 1월7일(일)')
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    left: 30,
                    bottom: 90,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.black,
                      child: Text('111', style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

