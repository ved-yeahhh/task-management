import 'package:task_mgmt/data/models/task_model.dart';

abstract class TaskEvent {}

class LoadTasks extends TaskEvent {}
class AddTask extends TaskEvent {
  final Task task;
  AddTask(this.task);
}
class DeleteTask extends TaskEvent {
  final String id;
  DeleteTask(this.id);
}
class UpdateTask extends TaskEvent {
  final Task task;
  UpdateTask(this.task);
}


