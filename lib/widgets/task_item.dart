import 'package:flutter/material.dart';
import 'package:note_app_firebase/provider/task.dart';
import 'package:note_app_firebase/provider/tasks.dart';
import 'package:provider/provider.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    final taskData = Provider.of<Tasks>(context);
    final products = taskData.items;
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        // builder: (c) => products[i],
        value: products[i],
        child: TaskDetails(
            // products[i].id,
            // products[i].title,
            // products[i].imageUrl,
            ),
      ),
    );
  }
}

class TaskDetails extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final task = Provider.of<Task>(context, listen: false);
    var sc = ScaffoldMessenger.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ListTile(
        // isThreeLine: true,
        title: Text(
          task.title,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          task.description,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.pushNamed(context, 'addtask', arguments: task.id);
                },
                color: Theme.of(context).primaryColor,
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  try {
                    await Provider.of<Tasks>(context, listen: false)
                        .deleteTask(task.id);
                  } catch (e) {
                    sc.showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
                color: Theme.of(context).errorColor,
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, 'addtask', arguments: task.id);
        },
      ),
    );
  }
}
