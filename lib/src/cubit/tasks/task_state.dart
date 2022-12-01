part of 'task_cubit.dart';

abstract class TaskState extends Equatable {
  const TaskState();
}

class TaskInitial extends TaskState {
  @override
  List<Object> get props => [];
}


class TaskLoading extends TaskState {
  @override
  List<Object> get props => [];
}


class TaskLoadSuccess extends TaskState {
  final List<TaskModel> taskList;

  TaskLoadSuccess(this.taskList);

  @override
  List<Object> get props => [taskList];
}

class TaskLoadError extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskUpdateSuccess extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskUpdateError extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskCreateSuccess extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskCreateError extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskDeleteSuccess extends TaskState {
  final TaskModel taskModel;

  TaskDeleteSuccess(this.taskModel);

  @override
  List<Object> get props => [taskModel];
}

class TaskDeleteError extends TaskState {
  @override
  List<Object> get props => [];
}
