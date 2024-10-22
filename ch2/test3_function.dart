main(){
  //optional 로 선언하면 외부에서 데이터 전달이 되지 않을 수 있다.. null 인 상황일 수 있다
  //default 값을 주고 non-null 로 선언하던가..
  //nullable 로 선언하던가..
  //required 로 선언해서 필수로 만들던가..
  void some1(bool data1, {String data2 = 'hello', int? data3, required int data4}){

  }
  //옵셔널.. 생략하던가.. 값을 지정할려면 name 을 명시해서 호출, 순서는 의미 없다.
  some1(true, data4: 10);
  some1(true, data4: 10, data2: 'world', data3: 20);

  void some2(bool data1, [String data2 = 'hello', int? data3, int? data4]){

  }
  //순서를 맞추어서 호출... 이름은 명시하지 못한다...
  some2(true);
  some2(true, 'world');
  some2(true, 'world', 20);
}