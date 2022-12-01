import 'package:firepro/src/cubit/tasks/task_cubit.dart';
import 'package:firepro/src/models/task_model.dart';
import 'package:firepro/src/pages/createTask_page.dart';
import 'package:firepro/src/pages/edittask_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit()..getAllTasks(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => CreateTaskPage()))
                .then((value) {
              context.read<TaskCubit>().getAllTasks();
            });
          },
          child: Icon(Icons.add),
        ),
        body: Container(
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              if (state is TaskLoading) {
                return CircularProgressIndicator();
              } else if (state is TaskLoadSuccess) {
                return _buildTaskUI(state.taskList);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  _buildTaskUI(List<TaskModel> taskList) {
    return ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          TaskModel item = taskList[index];
          return Card(
            elevation: 10,
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title),
                  Text(item.description),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("StartDate:${item.startDate.toString()}"),
                  Text("EndDate:${item.endDate.toString()}"),
                  Text("isCompleted:${item.isCompleted.toString()}")
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditTaskPage(taskModel: item)));
                  }, icon: Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        context.read<TaskCubit>().deleteTask(item);
                      },
                      icon: Icon(Icons.delete))
                ],
              ),
            ),
          );
        });
  }
}
