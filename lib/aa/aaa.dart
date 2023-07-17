import 'package:flutter/material.dart';

abstract class MyAbstract extends Widget {
  @mustCallSuper
  void doSomething() {
    print("Do Something works");
  }
}

class MyConcreteClass extends MyAbstract {
  @override
  Element createElement() {
    // TODO: implement createElement
    throw UnimplementedError();
  }

}

void main() {
  MyAbstract obj = MyConcreteClass();
}