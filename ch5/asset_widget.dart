import 'package:flutter/material.dart';
import 'dart:convert';//json parsing...
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AssetWidgett extends StatelessWidget {
  //text asset 파일을 읽어서 widget 을 리턴..
  Widget makeTextAsset(context){
    //파일 로딩.. 시간이 오래 걸릴 수 있다.. 비동기로 처리..
    //flutter 의 비동기의 기본은 Future
    //Future - data, 미래에 발생하는 데이터..
    //함수에서 Future 를 리턴하고.. 비동기로.. 데이터를 획득..
    //FutureBuilder - Future 에서 발생하는 데이터로 화면을 구성하는 위젯..
    return FutureBuilder(
        //loadString 함수가 Future 로 데이터 발생..
        future: DefaultAssetBundle.of(context).loadString('assets/text/my_text.txt'),
        builder: (context, snapshot){//Future 데이터로 화면을 구성하기 위해서 호출되는 함수..
          //두번째 매개변수가 Future 가 실제 발생시킨 데이터..
          //발생한 데이터로 화면 구성 리턴..
          if(snapshot.hasData){
            return Text(
                '${snapshot.data}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: 20,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.red,
                  decorationStyle: TextDecorationStyle.wavy,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
            );
          }
          return Text('');//최초에도 한번 호출.. Future 에 의해 데이터가 발생하기 전 화면
        }
    );
  }

  //json asset 파일을 로딩해서.. 화면을 구성하는 함수..
  Widget makeJsonAsset(context){
    return FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString('assets/text/data.json'),
        builder: (context, snapshot){
          if(snapshot.hasData){
            //json 파싱해서..
            var root = json.decode(snapshot.data.toString());
            return Text('json : ${root[0]['name']}');
          }
          return Text('');
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Image 와 ImageProvider 이용..
        //icon까지만 지칭했다.. 기대치는 icon/2.0x 등의 폴더 이미지가 적용되길..
        Image(image: AssetImage('assets/icon/user.png')),
        Image.asset('assets/icon/user.png'),
        makeTextAsset(context),
        makeJsonAsset(context),
        Icon(Icons.menu),//flutter icon..
        Icon(FontAwesomeIcons.music, size: 30, color: Colors.pink,)
      ],
    );
  }
}