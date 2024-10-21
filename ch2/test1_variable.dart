main(){
  //모든 변수는 객체이다.............
  int data1 = 10;
  print(data1.isEven);

  //casting.... 객체의 캐스팅.. 상하위 관계에서만 논할 수 있다..
  // double data2 = data1;//error
  double data2 = data1.toDouble();
  int data3 = data2.toInt();

  //string <-> int
  String data4 = '10';
  int data5 = int.parse(data4);
  String data6 = data5.toString();

  //var, dynamic.........................
  //var 은 타입 유추기법, 선언과 동시에 대입되는 값에의해 타입이 결정된다..
  var a = 10;
  a = 20;
  // a = 'hello';//error...

  //dynamic... 타입 없다.. 다른 언어에서 any 처럼 모든 타입의 데이터 대입 가능..
  dynamic b = 10;
  b = true;
  b = 'hello';

  //var 은 대입되는 값으로 타입 유추, 선언과 동시에 값 대입이 없다면.. dynamic type 으로 유추..
  var c;
  c = 10;
  c = 'hello';

  //List...................
  //배열처럼 사용...
  List<int> list1 = [10, 20, 30];
  list1[0] = 50;
  //List 를 배열처럼 [] 문법으로 사용이 가능하기는 하지만..
  //List 에 새로운 데이터 추가를 배열문법으로[] 하면 에러..
  // list1[3] = 40;//error..
  //함수를 이용해서..
  list1.add(40);
  list1.forEach((element){
    print(element);
    print(',');
  });

  //사이즈를 지정하고.. 만들고자 할때...
  //filled 라는 생성자를 이용..
  List list2 = List.filled(3, null);
  list2.forEach((item){
    print(item);
  });
  list2[1] = 10;
  //filled 생성자로 만들면서 사이즈를 고정했기 때문에.. 에러..
  // list2.add(20);//error...

  //map...................................
  Map map1 = {1:10, 'one':'hello'};
  print(map1['one']);
}