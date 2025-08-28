import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_mgmt/data/models/task_model.dart';
import 'package:task_mgmt/data/repository/task_repository.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;

  TaskBloc(this.repository) : super(TaskInitial()) {
    on<LoadTasks>((event, emit) async {
      emit(TaskLoading());
      try {
        repository.getTasks().listen((tasks) {
          add(_TasksUpdated(tasks));
        });
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });

    on<AddTask>((event, emit) async {
      await repository.addTask(event.task);
    });

    on<DeleteTask>((event, emit) async {
      await repository.deleteTask(event.id);
    });

    on<UpdateTask>((event, emit) async {
      await repository.updateTask(event.task);
    });

    on<_TasksUpdated>((event, emit) {
      emit(TaskLoaded(event.tasks));
    });
  }
}

// Internal event to handle live updates
class _TasksUpdated extends TaskEvent {
  final List<Task> tasks;
  _TasksUpdated(this.tasks);
}
