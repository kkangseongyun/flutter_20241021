import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

//항목 데이터 VO
class Article {
  String autor;
  String title;
  String description;
  String urlToImage;
  String publishedAt;

  Article(this.autor, this.title, this.description, this.urlToImage,
      this.publishedAt);
}

//데이터 획득이 끝난후 List 화면 구성
Widget getWidget(List<Article> datas) {
  return ListView.builder(
    itemCount: datas.length,
    itemBuilder: (BuildContext context, int position) {
      Column resultWidget=Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              child: Text(datas[position].title, style: TextStyle(fontWeight: FontWeight.bold),)
          ),
          Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              child: Text(datas[position].publishedAt, style: TextStyle(color: Colors.grey),)
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Text(datas[position].description, ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Image.network(datas[position].urlToImage),
          ),

        ],
      );
      if(position!=datas.length-1){
        resultWidget.children.add(Container(
            height: 15,
            color: Colors.grey
        ));
      }
      return resultWidget;
    },
  );
}



String _url =
    'https://newsapi.org/v2/everything?q=travel&apiKey=079dac74a5f94ebdb990ecf61c8854b7&pageSize=3';

Future<List<Article>> getServerData(String page) async {
  String url = _url + '&page=${page}';
  print('.............url : $url');
  http.Response response = await http.get(Uri.parse(url));
  print(response.body.toString());
  List datas = json.decode(response.body)['articles'];
  List<Article> result = [];
  datas.forEach((item) => {
    result.add(Article(item['source']['name'], item['title'],
        item['description'], item['urlToImage'], item['publishedAt']))
  });
  return result;
}

class FutureWidget extends StatelessWidget {


}


class StreamWidget extends StatefulWidget {
  @override
  StreamState createState() => StreamState();
}

class StreamState extends State<StreamWidget> {
  List<Article> list = [];


}


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    FutureWidget(),
    StreamWidget()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    getServerData('1');
    return MaterialApp(
      home: (Scaffold(
        appBar: AppBar(
          title: Text('Future Stream Test'),
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Future',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Stream',
            )
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      )),
    );
  }
}
