import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'todoApp.dart';
import 'form.dart';

void main(){
  runApp(GetMaterialApp(home: MyHomePage()));
}

class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Home'),), backgroundColor: Colors.cyan,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(17),
            child: InkWell(
              onTap: (){
                Get.to(TodoApp());
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: Colors.blueGrey.withOpacity(0.5)),
                child: Row(
                  children: [
                    Text('To-do-list', style: TextStyle(fontSize: 27),),
                    SizedBox(width: 150,),
                    Icon(Icons.arrow_forward, size: 30,),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(17),
            child: InkWell(
              onTap: (){
                Get.to(FormPage());
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: Colors.blueGrey.withOpacity(0.5)),
                child: Row(
                  children: [
                    Text('FormPage', style: TextStyle(fontSize: 27),),
                    SizedBox(width: 150,),
                    Icon(Icons.arrow_forward, size: 30,),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}