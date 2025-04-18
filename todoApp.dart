import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view.dart';

class TodoApp extends StatelessWidget{
  final TodoController controller = Get.put(TodoController());
  final TextEditingController editController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('To-do-List'), backgroundColor: Colors.cyan,),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Danh sách có sẵn:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Obx(() => Wrap(
              spacing: 8,
              children: controller.Tasks.map((task) => ElevatedButton(
                onPressed: () => controller.add(task),
                child: Text(task),
              )).toList(),
            )),
            Divider(height: 30,),
            Text("To-do list:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: controller.todoList.length,
                itemBuilder: (_,index){
                  final item = controller.todoList[index];
                  return Obx(() => Card(
                    child: ListTile(
                      title: Row(
                        children: [
                          Expanded(child: Text(item.task.value)),
                          SizedBox(width: 20,),
                          IconButton(
                              onPressed: (){
                                editController.text = item.task.value;
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text("Chỉnh sửa"),
                                    content: TextField(
                                      controller: editController,
                                      decoration: InputDecoration(hintText: "Nhập tên mới"),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          controller.edit(item, editController.text);
                                          Get.back();
                                        },
                                        child: Text("Lưu"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: Icon(Icons.edit)
                          ),
                        ],
                      ),
                      subtitle: Text('Số lượng: ${item.quantity.value}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () => controller.decrease(item),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () => controller.increase(item),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => controller.remove(item),
                          ),
                        ],
                      ),
                    ),
                  ),
                  );
                },
              )),
            )
          ],
        ),
      ),
    );
  }
}