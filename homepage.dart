import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'preference.dart';
import 'showdata.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PreferencesService _preferencesService = PreferencesService();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  // Lưu thông tin vào SharedPreferences
  void _saveData() async {
    String name = nameController.text;
    String email = emailController.text;
    int age = int.tryParse(ageController.text) ?? 0;

    if (name.isEmpty || email.isEmpty || age <= 0 || !email.contains('@')) {
      Get.snackbar('Lỗi', 'Vui lòng nhập đầy đủ thông tin',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
      return;
    }

    await _preferencesService.saveListData(name, email, age);
    Get.snackbar('Thành công', 'Thông tin đã được lưu');
  }



  // Chuyển đến trang hiển thị danh sách thông tin đã lưu
  void _showDataPage() {
    Get.to(() => ShowDataPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nhập Thông Tin')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Tên'),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Vui lòng điền tên';
                  }
                },
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value){
                  if(!value!.contains('@')){
                    return 'Email không hợp lệ';
                  }
                },
              ),
              TextField(
                controller: ageController,
                decoration: InputDecoration(labelText: 'Tuổi'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveData,
                child: Text('Lưu Thông Tin'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _showDataPage,
                child: Text('Hiển thị danh sách thông tin'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
