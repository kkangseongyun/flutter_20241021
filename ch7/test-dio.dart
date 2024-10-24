import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  //서버에서 받은 데이터.. 목록 구성 데이터..
  List datas = [];

  //ListView 에 지정할 스크롤 정보를 받기 위한 controller
  //페이징 처리를 위해서..
  ScrollController controller = ScrollController();

  //서버 요청 데이터..
  int page = 1;
  int seed = 1;

  //서버 연동을 위한 함수.. 여러곳에서 호출해서.. 개발자 함수로 분리..
  //서버 요청이다.. 시간이 오래 걸릴 수 있다.. 함수를 호출한 곳을 대기상태로 만들면 안된다.
  //비동기.. Future 로..
  //리턴 타입이 Future 인 함수는 async 로 선언되어야 한다..
  //리턴 타입이 Future 인 함수를 호출하는 곳은 호출하자 마자, 대기하지 않고.. 움직인다..
  //이 함수에서 return 시킨 데이터가 미래에 발생한 데이터..
  Future<List<dynamic>> dioTest() async {
    try {
      var dio = Dio(BaseOptions(
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 5),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json'
        }
      ));

      Response<dynamic> response = await dio.get(
        'https://randomuser.me/api/?seed=${seed}&page=${page}&results=20'
      );
      return response.data['results'];
    }catch(e){
      print(e);
    }
    return [];
  }

  //스크롤 이벤트 콜백 함수..
  scrollListener() async {
    //마지막 항목까지 스크롤 된 것인지 판단..
    if(controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange){
      //마지막까지 스크롤 되었다.. 페이지 번호 증가시켜서.. 서버 요청..
      page++;
      List result = await dioTest();
      setState(() {
        datas.addAll(result);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    //스크롤 이벤트 등록..
    controller.addListener(scrollListener);
    //최초 데이터 서버에 요청..
    dioTest().then((value){
      setState(() {
        datas = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Future<void> _refresh() async {
    page = 1;
    seed++;
    List result = await dioTest();
    setState(() {
      datas = result;
    });
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test'),
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView.separated(
            controller: controller,
            itemCount: datas.length,
            itemBuilder: (BuildContext context, int position) {
              return ListTile(
                contentPadding: EdgeInsets.all(5),
                title: Text(
                    "${datas[position]["name"]["first"]} ${datas[position]["name"]["last"]}"),
                subtitle: Text(datas[position]["email"]),
                leading: CircleAvatar(
                  radius: 25,
                  child: ClipOval(
                    child:
                        Image.network(datas[position]["picture"]['thumbnail']),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int position) {
              return Divider(
                color: Colors.black,
              );
            },
          ),
        ),
      ),
    );
  }
}
