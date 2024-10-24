import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    //add..................................
    return MaterialApp.router(
      routerDelegate: MyDelegate(),
      routeInformationParser: MyParser(),
    );
  }
}
//add...................................
//라우팅을 위해 유지되어야 하는 데이터를 저장하기 위한 클래스..
//개발자 임의 클래스, 데이터, 생성자 필요한 만큼..
class MyRoutePath {
  String? id;
  MyRoutePath.home(): this.id = null;
  MyRoutePath.detail(this.id);
}

//앱 실행 초기 라이팅 조건을 분석
//라이팅이 결정되었을대 상황을 저장
class MyParser extends RouteInformationParser<MyRoutePath> {
  @override
  Future<MyRoutePath> parseRouteInformation(RouteInformation routeInformation) async {
    //앱 실행 초기 호출.. 이곳에서 분석하고.. 분석 결과를 정보 클래스에 담아 리턴하면
    //delegator 에 전달된다..
    Uri uri = routeInformation.uri;
    if(uri.pathSegments.length >= 2){
      var remaining = uri.pathSegments[1];
      return MyRoutePath.detail(remaining);
    }else {
      return MyRoutePath.home();
    }
  }
}

//parser 의 분석 정보를 참조해서 실제 화면 전환을 처리하는 역할..
class MyDelegate extends RouterDelegate<MyRoutePath>
  with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyRoutePath> {

  String? selected;
  var navigatorKey = GlobalKey<NavigatorState>();

  //build 함수가 호출되기 직전에 호출.. 반복 호출..
  //화면 전환 시킬 것인데.. 유지해야 하는 데이터가 있다면 이 함수에서 리턴..
  //parser 의 restorRouteInfomation 함수에 전달..
  @override
  MyRoutePath? get currentConfiguration {
    if(selected != null){
      return MyRoutePath.detail(selected);
    }else {
      return MyRoutePath.home();
    }
  }

  //화면 출력.. 이곳에서 stack 에 page 를 구성하는 대로 화면은 나온다..
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(child: HomeScreen(handlePressed)),
        if(selected != null) MaterialPage(child: DetailScreen(selected))
      ],
      //back이 눌린다면..
      onPopPage: (route, result){
        if(!route.didPop(result)){
          return false;
        }
        selected = null;
        notifyListeners();//이 함수만 호출하면 화면이 변경되어야 한다는 의미, build 가 다시 호출..
        return true;
      },
    );
  }

  //parser 에 의해 정보 분석이 된후 최초에 호출.. parser 정보를 참조해서 자신들의 라우팅 정보를 만드는 역할
  @override
  Future<void> setNewRoutePath(MyRoutePath configuration) async{
    if(configuration.id != null){
      selected = configuration.id;
    }
  }
  //개발자 함수.. 이 delegator 에 의해 결정된 위젯에 전달될 함수.. 위젯에서 호출하는 함수..
  //아래의 HomeScreem 의 onPressed 이 이 함수가 된다..
  handlePressed(String id){
    selected = id;
    notifyListeners();
  }
}

class HomeScreen extends StatelessWidget {
  final ValueChanged<String> onPressed;

  HomeScreen(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.red,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Home Screen',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              ElevatedButton(
                child: Text('go detail with 1'),
                onPressed: () => onPressed('1'),
              ),
              ElevatedButton(
                child: Text('go detail with 2'),
                onPressed: () => onPressed('2'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  String? id;

  DetailScreen(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.green,
        child: Center(
          child: Text(
            'Detail Screen $id',
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
