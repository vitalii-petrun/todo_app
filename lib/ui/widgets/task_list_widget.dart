import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/ui/screens/task_screen.dart';

///Widget which displays list of tasks.
class TaskListWidget extends StatelessWidget {
  ///List of tasks to display.
  final List<Task> tasks;
  static const _doneStatusStyle =
      TextStyle(decoration: TextDecoration.lineThrough);

  ///Widget receives list of tasks and display them.
  TaskListWidget({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context, listen: false);

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Slidable(
          key: UniqueKey(),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(
              onDismissed: () {
                provider.delete(tasks[index].id as int);
              },
            ),
            children: [
              SlidableAction(
                onPressed: (_) {
                  provider.delete(tasks[index].id as int);
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Consumer<TaskProvider>(
            builder: (context, data, child) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) {
                        return TaskScreen(task: tasks[index]);
                      },
                    ),
                  );
                },
                leading: InkWell(
                  splashColor: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    provider.changeStatus(tasks[index]);
                  },
                  child: tasks[index].isDone
                      ? const Icon(Icons.done)
                      : const Icon(Icons.circle_outlined),
                ),
                title: Text(
                  tasks[index].title,
                  style: tasks[index].isDone ? _doneStatusStyle : null,
                ),
                subtitle: Text(
                  tasks[index].description ?? "",
                  style: tasks[index].isDone ? _doneStatusStyle : null,
                ),
              );
            },
          ),
        );
      },
    );
  }
}