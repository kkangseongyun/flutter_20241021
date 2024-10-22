class MyClass {
  int no = 0;
  String name = 'kim';

  MyClass(this.no, this.name);

  String sayHello(String name) => 'Hello, $name';
}

//클래스를 상속관계로 이용..
class SubClass extends MyClass {
  SubClass(no, name): super(no, name);
}

//클래스를 인터페이스로 이용...
//클래스를 인터페이스로 이용하면 클래스내에 선언된 멤버를 오버라드 받아야..
//생성자는 제외..
class IntefaceClass implements MyClass {
  int no = 20;
  String name = 'lee';
  String sayHello(String name) => 'Hello';
}

class A {}
//어느 클래스에서 사용하든.. 공통적인 변수, 함수가 중복될때...
mixin MyMixin on A {
  int mixinData = 0;
  void mixinFun(){}
}
class MixinTest extends A with MyMixin {
  void some(){
    mixinData = 30;
    mixinFun();
  }
}