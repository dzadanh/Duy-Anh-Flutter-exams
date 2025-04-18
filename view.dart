import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Item {
  RxString task;
  RxInt quantity;

  Item({required String task, int quantity = 1})
      : this.task = task.obs,
        this.quantity = quantity.obs;
}

class TodoController extends GetxController{
  var Tasks = ['work 1', 'work 2', 'work 3', 'work 4', 'work 5', 'work 6', 'work 7'].obs;
  var todoList = <Item>[].obs;

  void add(String name){
    final exist = todoList.firstWhereOrNull((item) => item.task == name);
    if(exist == null){
      todoList.add(Item(task: name));
    }
    else{
      exist.quantity.value ++;
    }
  }
  void remove(Item name){
    todoList.remove(name);
  }
  void increase(Item name){
    name.quantity.value ++;
  }
  void decrease(Item name){
    if(name.quantity > 1){
      name.quantity.value --;
    }
    else{
      todoList.remove(name);
    }
  }
  void edit(Item name, String newName){
    name.task.value = newName;
  }
}