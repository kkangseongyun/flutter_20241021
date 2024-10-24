import 'package:flutter/material.dart';

//유저 입력 데이터 저장...vo
class User {
  String? firstName = '';
  String? lastName = '';
}

class FormWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormWidgetState();
  }
}

class FormWidgetState extends State<FormWidget> {
  //Form 에 설정할 키 값..
  //키를 이용해 해당 위젯의 State 객체를 획득할 수 있다..
  //키를 이용해 State 를 획득하려면 GlobalKey 로 만들어야..
  var formKey = GlobalKey<FormState>();
  var user = User();

  //데이터 저장을 위해서 호출..
  save() {
    print('save()... ${user.firstName}, ${user.lastName}');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //TextField 와 매개변수는 동일, 단지 Form 과 연동 준비가 되어 있는 위젯..
          TextFormField(
            decoration: InputDecoration(labelText: 'First Name'),
            validator: (value){
              //유효성 검증을 위해 자동 호출.. Form 의 state 의 validate() 함수가
              //호출되는 순간, Form 의 모든 Field 의 validator 함수가 자동 호출..
              //매개변수는 현 시점 유저가 입력한 데이터..
              if(value?.isEmpty ?? false){
                //문자열이 리턴되면 invalid.. 리턴시킨 문자열이 에러 메시지..
                return 'please enter your first name';
              }
              return null;//valid
            },
            //Form 의 state 의 save() 함수 호출 시점에 Form 하위의 모든 Field 의
            //onSaved() 함수 호출..
            //매개변수가 현 시점 유저 입력 데이터..
            onSaved: (value) => setState(() {
              user.firstName = value;
            }),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Last Name'),
            validator: (value){
              if(value?.isEmpty ?? false){
                return 'please enter your last name';
              }
              return null;//valid
            },
            onSaved: (value) => setState(() {
              user.lastName = value;
            }),
          ),
          ElevatedButton(
              onPressed: (){
                //key 로 Form 의 state 획득..
                var form = formKey.currentState;
                //모든 field 에서 null 리턴하면 validate() 의 리턴 값은 true
                //하나 이상이 문자열을 리턴하면 false
                if(form?.validate() ?? false){
                  form?.save();
                  save();
                }
              },
              child: Text('save'),
          ),
        ],
      ),
    );
  }

}