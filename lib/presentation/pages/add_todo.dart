import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_care/presentation/providers/user_data_provider.dart';
import 'package:self_care/presentation/providers/todo_data_provider.dart';

class TodoData {
  final TextEditingController taskName = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController dueDate = TextEditingController();
  final TextEditingController type = TextEditingController();
  final TextEditingController time = TextEditingController();
}

final todoDataProviders = Provider((ref) => TodoData());

class TodoAddPage extends ConsumerWidget {
  const TodoAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(todoDataProvider, (previous, next) {
      Navigator.of(context).pop();
    });
    final todoData = ref.read(todoDataProviders);
    final email = ref.watch(userDataProvider).value?.email;

    return WillPopScope(
      onWillPop: () async {
        todoData.taskName.clear();
        todoData.description.clear();
        todoData.dueDate.clear();
        todoData.type.clear();
        todoData.time.clear();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Add New Task",
            style: GoogleFonts.inter(fontWeight: FontWeight.w500),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF16697A),
                  Color(0xFF82C0CC),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Task Name',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    prefixIcon: const Icon(Icons.task_alt_outlined),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                  controller: todoData.taskName,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Task Name is not valid';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    prefixIcon: const Icon(Icons.description_outlined),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                  controller: todoData.description,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Due Date',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    prefixIcon: const Icon(Icons.date_range_outlined),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                  controller: todoData.dueDate,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Due Date is not valid';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Type',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    prefixIcon: const Icon(Icons.task_alt_outlined),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                  controller: todoData.type,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Type is not valid';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Time',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    prefixIcon: const Icon(Icons.timer_outlined),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                  controller: todoData.time,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Time is not valid';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () async {
                      final taskName = todoData.taskName.text;
                      final description = todoData.description.text;
                      final dueDate = todoData.dueDate.text;
                      final type = todoData.type.text;
                      final time = todoData.time.text;

                      await ref.watch(todoDataProvider.notifier).addTodo(
                            taskName,
                            description,
                            dueDate,
                            type,
                            time,
                            email!,
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: const Color(0xFF16687E),
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      textStyle: GoogleFonts.roboto(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    child: const Text("Add"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
