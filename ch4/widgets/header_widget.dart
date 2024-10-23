import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//popup menu 구성 문자열..
const List<String> choices = [
  '신고', '알림 설정', '공유'
];

class HeaderWidget extends StatelessWidget {
  void select(String choice){
    //popup menu event callback..
    Fluttertoast.showToast(
        msg: choice,
        //아래 설정은 플랫폼에 따라 적용되지 않을 수도 있다..
        toastLength: Toast.LENGTH_SHORT,//사라지는 시간.. LONG
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //asset 이미지 출력..
        Image.asset('images/lab_instagram_icon_0.jpg'),
        Container(//화면의 영역만 표현하기 위한 위젯, 마진, 패팅, 보더등 설정..
          padding: EdgeInsets.only(left: 16),
          child: Text('instagram', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
        ),
        Spacer(),//여백만 차지하는 위젯..
        PopupMenuButton(
            onSelected: select,
            itemBuilder: (BuildContext context){//popup menu 가 확장 되었을때 각 항목을 만들기 위해서 자동 호출..
              return choices.map<PopupMenuItem<String>>((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            }
        ),
      ],
    );
  }
}