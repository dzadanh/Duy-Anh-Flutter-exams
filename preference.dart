import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  // Lưu thông tin
  Future<void> saveData(String name, String email, int age) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setInt('age', age);
  }

  // Lấy thông tin
  Future<Map<String, dynamic>> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name') ?? 'Chưa có tên';
    String email = prefs.getString('email') ?? 'Chưa có email';
    int age = prefs.getInt('age') ?? 0;

    return {
      'name': name,
      'email': email,
      'age': age,
    };
  }

  // Lấy danh sách thông tin đã lưu
  Future<List<Map<String, dynamic>>> loadAllData() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedNames = prefs.getStringList('namesList');
    List<String>? savedEmails = prefs.getStringList('emailsList');
    List<int>? savedAges = prefs.getStringList('agesList')?.map((e) => int.tryParse(e) ?? 0).toList();

    savedNames ??= [];
    savedEmails ??= [];
    savedAges ??= [];

    List<Map<String, dynamic>> allData = [];

    for (int i = 0; i < savedNames.length; i++) {
      allData.add({
        'name': savedNames[i],
        'email': savedEmails[i],
        'age': savedAges[i],
      });
    }

    return allData;
  }

  // Lưu danh sách thông tin
  Future<void> saveListData(String name, String email, int age) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? names = prefs.getStringList('namesList') ?? [];
    List<String>? emails = prefs.getStringList('emailsList') ?? [];
    List<String>? ages = prefs.getStringList('agesList') ?? [];

    names.add(name);
    emails.add(email);
    ages.add(age.toString());

    await prefs.setStringList('namesList', names);
    await prefs.setStringList('emailsList', emails);
    await prefs.setStringList('agesList', ages);
  }

  // Xoá dữ liệu tại vị trí chỉ định
  Future<void> deleteDataAtIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> names = prefs.getStringList('namesList') ?? [];
    List<String> emails = prefs.getStringList('emailsList') ?? [];
    List<String> ages = prefs.getStringList('agesList') ?? [];

    if (index < names.length && index < emails.length && index < ages.length) {
      names.removeAt(index);
      emails.removeAt(index);
      ages.removeAt(index);

      await prefs.setStringList('namesList', names);
      await prefs.setStringList('emailsList', emails);
      await prefs.setStringList('agesList', ages);
    }
  }
}
