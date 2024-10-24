import 'package:flutter/material.dart';
import './asset_widget.dart';
import './form_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int selectedIndex = 0;//선택된 탭 버튼 정보..

  List<Widget> widgets = [
    AssetWidgett(),
    FormWidget(),
  ];

  //tab button 이벤트 콜백..
  void onItemTapped(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,//디버그 띠 사라지게..
      theme: ThemeData(
        primarySwatch: Colors.pink,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.black,
        )
      ),
      home: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(48.0),
              child: Container(
                height: 48.0,
                alignment: Alignment.center,
                child: Text('AppBar Bottom Text'),
              ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/big.jpeg'),
                  fit: BoxFit.fill,
              ),
            ),
          ),
          title: Text('Widget Test'),
          actions: [//메뉴.. 유저 이벤트
            IconButton(onPressed: (){}, icon: Icon(Icons.add_alert),),
            IconButton(onPressed: (){}, icon: Icon(Icons.navigate_before),),
          ],
        ),
        body: Center(
          child: widgets.elementAt(selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
            //shifting - 탭 버튼 클릭시, 탭 버튼 부분이 애니메이션 효과에 의해..
            type: BottomNavigationBarType.shifting,//fixed - 애니메이션 효과 없고..
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'first',
                backgroundColor: Colors.green,//이 탭 버튼이 눌리면 bar 전체가 이 칼라로..
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  label: 'second',
                  backgroundColor: Colors.red,
              ),
            ],
            currentIndex: selectedIndex,
            selectedItemColor: Colors.amber,//현재 선택된 탭 버튼의 색상..
            onTap: onItemTapped,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(//상단 부분..
                  child: Text('Drawer Header'),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: (){},
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: (){},
              ),
              ListTile(
                title: Text('Item 3'),
                onTap: (){},
              )
            ],
          ),
        ),
      ),
    );
  }
}

