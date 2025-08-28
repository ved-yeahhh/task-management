import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_mgmt/bloc/task/task_bloc.dart';
import 'package:task_mgmt/bloc/task/task_event.dart';
import 'package:task_mgmt/bloc/task/task_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    context.read<TaskBloc>().add(LoadTasks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MY TASKS'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Handle logout
            },
          ),
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TaskLoaded) {
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return Card(
                  child: ListTile(
                    leading: Checkbox(
                      value: state.tasks[index].isCompleted,
                      onChanged: (_) {
                        setState(() {
                          state.tasks[index].isCompleted =
                              !state.tasks[index].isCompleted;
                          context.read<TaskBloc>().add(
                            UpdateTask(state.tasks[index]),
                          );
                        });
                      },
                    ),
                    title: Text(
                      task.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.description,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          'Date: ${task.date}',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        context.read<TaskBloc>().add(DeleteTask(task.id));
                      },
                    ),
                  ),
                );
              },
            );
          }
          return Center(child: Text("No tasks found"));
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/addTask");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
