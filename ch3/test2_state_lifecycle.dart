import 'package:flutter/material.dart';
//상위 위젯의 데이터를 하위에 전파시키기 위해서..
import 'package:provider/provider.dart';

void main() => runApp(ParentWidget());

//화면을 구성하는 최 상위의 위젯을 StatefulWidget 으로 만드는 것은 권장할 만 하지 않다.. 테스트를 위해서..
class ParentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ParentState();
  }
}
class ParentState extends State<ParentWidget> {
  int _counter = 0;//상위에서 유지되는 데이터.. 하위에 전파되는 데이터로 가정..

  void increment() {
    //event callback..
    //데이터 변경 후, 화면 갱신..
    setState(() {
      _counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Lifecycle Test'),),
        body: Provider.value(//이곳에서 명시한 value 가 하위에서 이용..
            value: _counter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('I am parent Widget $_counter'),
                ElevatedButton(
                    onPressed: increment,
                    child: Text('increment'),
                ),
                ChildWidget(),
              ],
            ),
        ),
      ),
    );
  }
}

class ChildWidget extends StatefulWidget {
  ChildWidget(){
    print('ChildWidget... constructor..');
  }
  @override
  State<StatefulWidget> createState() {
    return ChildState();
  }
}
//WidgetsBindingObserver - app 의 lifecycle 을 위해서..
class ChildState extends State<ChildWidget> with WidgetsBindingObserver{
  int _counter = 0;

  ChildState(){
    print('ChildState... constructor...');
  }
  @override
  void initState() {
    super.initState();
    print('ChildState... initState...');
    //일반적으로.. state 의 초기화, 이벤트 등록 역할..
    //app 의 lifecycle 이벤트를 처리하겠다..
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void dispose() {
    super.dispose();
    //initState 에서 등록한 이벤트 해제..
    WidgetsBinding.instance.removeObserver(this);
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //initState 호출후 바로 호출된다.
    //상위의 상태 데이터가 변경된경우, 상위의 위젯 트리 구조가 변경된 경우.. 이를 하위에서 간파하기 위해서..
    _counter = Provider.of<int>(context);//상위의 데이터 획득..
    print('ChildState... didChangeDependencies... ');
  }
  @override
  Widget build(BuildContext context) {
    print('ChildState... build...');
    return Text('I am child widget, $_counter');
  }
  //앱의 라이프사이클 변경 이벤트시 호출.. 매개변수로 어떤 상태로 변경된 것인지 알려준다.. resume, pause 등..
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('Current app State, $state');
  }
}

//최초
//I/flutter (20786): ChildWidget... constructor..
// I/flutter (20786): ChildState... constructor...
// I/flutter (20786): ChildState... initState...
// I/flutter (20786): ChildState... didChangeDependencies...
// I/flutter (20786): ChildState... build...

//상위의 상태가 변경되었을 때..
//==>위젯은 불변이다.. stateful 위젯도 화면 갱신이 되면 매번 생성된다.
//단지 state 만 메모리에 지속되어 이용..
//I/flutter (20786): ChildWidget... constructor..
// I/flutter (20786): ChildState... didChangeDependencies...
// I/flutter (20786): ChildState... build...

//app lifecycle 변경..
// Current app State, AppLifecycleState.inactive
// Current app State, AppLifecycleState.hidden
// Current app State, AppLifecycleState.paused

//Current app State, AppLifecycleState.resumed