import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firepro/src/cubit/tasks/task_repository.dart';
import 'package:firepro/src/models/task_model.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  TaskRepository _repository = TaskRepository();

  createTask(TaskModel taskModel) async {
    emit(TaskLoading());
    try {
      await _repository.createTask(taskModel);
      emit(TaskCreateSuccess());
    } catch (ex) {
      emit(TaskCreateError());
    }
  }

  getAllTasks() async {
    emit(TaskLoading());
    try {
      QuerySnapshot snapshot = await _repository.getAllTasks();
      List<TaskModel> taskList = snapshot.docs.map<TaskModel>((e) {
        Map<String, dynamic> dx = e.data() as Map<String, dynamic>;
        String id = e.id;
        TaskModel taskModel = TaskModel.fromJson(dx);
        taskModel.id = id;
        return taskModel;
      }).toList();
      emit(TaskLoadSuccess(taskList));
    } catch (ex) {
      emit(TaskLoadError());
    }
  }

  updateTask(TaskModel updatedTask) async {
    emit(TaskLoading());
    try {
      await _repository.editTask(updatedTask);
      emit(TaskUpdateSuccess());
      await Future.delayed(Duration(seconds: 2));
      getAllTasks();
    } catch (ex) {
      emit(TaskUpdateError());
    }
  }

  deleteTask(TaskModel taskModel) async {
    emit(TaskLoading());

    try {
      await _repository.deleteTask(taskModel);
      emit(TaskDeleteSuccess(taskModel));
      await Future.delayed(Duration(seconds: 2));
      getAllTasks();
    } catch (ex) {
      emit(TaskDeleteError());
    }
  }
}
