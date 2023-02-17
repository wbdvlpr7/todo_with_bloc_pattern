// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_with_bloc_pattern/data/storage/todo_model.dart';
import 'package:todo_with_bloc_pattern/modules/todos/bloc/todos_bloc.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({
    Key? key,
    this.todo,
  }) : super(key: key);
  final TodoModel? todo;

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtTag = TextEditingController();

  @override
  Widget build(BuildContext context) {
    txtTitle.text = widget.todo?.title ?? '';
    txtDescription.text = widget.todo?.description ?? '';
    txtTag.text = widget.todo?.tags ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
      ),
      body: buildBody(context),
    );
  }

  buildBody(BuildContext context) {
    return Builder(builder: (c) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: txtTitle,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            TextFormField(
              controller: txtDescription,
              decoration: const InputDecoration(hintText: 'Description'),
            ),
            TextFormField(
              controller: txtTag,
              decoration: const InputDecoration(hintText: 'Tags: tag1, tag2'),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (txtTitle.text.trim().isEmpty ||
                          txtDescription.text.trim().isEmpty ||
                          txtTag.text.trim().isEmpty) {
                        EasyLoading.showError('Please fill all fields!',
                            dismissOnTap: true);
                        return;
                      }
                      context.read<TodosBloc>().add(AddTodo(TodoModel(
                            id: widget.todo == null ? 0 : widget.todo!.id,
                            title: txtTitle.text,
                            description: txtDescription.text,
                            tags: txtTag.text,
                            isCompleted: false,
                          )));
                      context.pop();
                    },
                    child: const Text('Save')),
                const SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () => context.pop(), child: const Text('Back')),
              ],
            ),
          ],
        ),
      );
    });
  }
}
