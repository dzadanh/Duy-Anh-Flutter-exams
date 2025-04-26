import 'package:flutter/material.dart';
import 'preference.dart';

class ShowDataPage extends StatefulWidget {
  @override
  _ShowDataPageState createState() => _ShowDataPageState();
}

class _ShowDataPageState extends State<ShowDataPage> {
  final PreferencesService _preferencesService = PreferencesService();
  List<Map<String, dynamic>> _savedData = [];

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  // Tải danh sách dữ liệu từ SharedPreferences
  _loadAllData() async {
    var data = await _preferencesService.loadAllData();
    setState(() {
      _savedData = data;
    });
  }

  void _deleteData(int index) async {
    await _preferencesService.deleteDataAtIndex(index);
    _loadAllData(); // Tải lại danh sách sau khi xóa
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Danh sách Thông Tin')),
      body: _savedData.isEmpty
          ? Center(child: Text('Chưa có thông tin lưu'))
          : ListView.builder(
        itemCount: _savedData.length,
        itemBuilder: (context, index) {
          var item = _savedData[index];
          return ListTile(
            title: Text('Tên: ${item['name']}'),
            subtitle: Text('Email: ${item['email']} - Tuổi: ${item['age']}'),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteData(index),
            ),
          );
        },
      ),
    );
  }
}
