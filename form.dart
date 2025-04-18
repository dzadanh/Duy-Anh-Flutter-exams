import 'package:exam/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormController extends GetxController{
  var name = ''.obs;
  var email = ''.obs;
  var pass = ''.obs;
  var remember = false.obs;

  void updateName(String value) => name.value = value;
  void updateEmail(String value) => email.value = value;
  void updatePass(String value) => pass.value = value;
  void updateRemember(bool value) => remember.value = value ?? false;
}

class FormPage extends StatelessWidget{
  final FormController controller = Get.put(FormController());

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Thông tin cá nhân'), backgroundColor: Colors.cyan,),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          child: ListView(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Họ và Tên',labelStyle: TextStyle(fontSize: 19)),
                onChanged: controller.updateName,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email',labelStyle: TextStyle(fontSize: 19)),
                onChanged: controller.updateEmail,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'không được để Email trống';
                  }
                  if(!value.contains('@') || (!value.contains('.com') && !value.contains('.vn'))){
                    return 'Email không hợp lệ';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mật khẩu',labelStyle: TextStyle(fontSize: 19)),
                onChanged: controller.updatePass,
                validator: (value){
                  if(value == null || value.length < 8){
                    return 'Mật khẩu ít nhất 8 kí tự';
                  }
                  return null;
                },
              ),
              Obx(() => CheckboxListTile(
                title: Text('Ghi nhớ đăng nhập'),
                  value: controller.remember.value,
                  onChanged: (value) => controller.updateRemember(value!),
              )),
              Divider(height: 30,),
              Text('Thông tin người dùng:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Họ và Tên: ${controller.name.value}'),
                  SizedBox(height: 7,),
                  Text('Email: ${controller.email.value}'),
                  SizedBox(height: 7,),
                  Text('Mật khẩu: ${'*' * controller.pass.value.length}'),
                  SizedBox(height: 7,),
                  Text('Ghi nhớ đăng nhập: ${controller.remember.value}')
                ],
              ))
            ],
          ),
        ),
      )
    );
  }
}