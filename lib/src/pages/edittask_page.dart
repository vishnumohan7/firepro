import 'package:firepro/src/cubit/tasks/task_cubit.dart';
import 'package:firepro/src/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditTaskPage extends StatefulWidget {
  final TaskModel taskModel;
  const EditTaskPage({Key? key, required this.taskModel}) : super(key: key);

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    _titleController.text = widget.taskModel.title;
    _descriptionController.text = widget.taskModel.description;
    _startDateController.text = widget.taskModel.startDate.toString();
    _endDateController.text = widget.taskModel.endDate.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Create Task"),
          centerTitle: true,
        ),
        body: Form(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) {
                    widget.taskModel.title = value;
                  },
                  controller: _titleController,
                  decoration: InputDecoration(labelText: "Title"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (value) {
                    widget.taskModel.description = value;
                  },
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: "Description"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  readOnly: true,
                  controller: _startDateController,
                  onTap: () async {
                    DateTime? startDateTemp = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030));
                    if (startDateTemp != null) {
                      _startDateController.text = startDateTemp.toString();
                      widget.taskModel.startDate = startDateTemp;
                    }
                  },
                  decoration: InputDecoration(labelText: "Start Date"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  readOnly: true,
                  controller: _endDateController,
                  onTap: () async {
                    DateTime? endDateTemp = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030));
                    if (endDateTemp != null) {
                      _endDateController.text = endDateTemp.toString();
                      widget.taskModel.endDate = endDateTemp;
                    }
                  },
                  decoration: InputDecoration(labelText: "End Date"),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text("is completed"),
                    Switch(value: (widget.taskModel.isCompleted), onChanged: (changedStatus){
                      setState(() {
                        widget.taskModel.isCompleted = changedStatus;
                      });
                    })
                  ],
                ),
                BlocConsumer<TaskCubit, TaskState>(
                  listener: (context, state) {
                    if (state is TaskUpdateSuccess) {
                      Navigator.pop(context);
                    } else if (state is TaskUpdateError) {
                      Fluttertoast.showToast(
                          msg: "Error Updating Task",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if (state is TaskLoading) {
                      return CircularProgressIndicator();
                    }
                    return ElevatedButton(
                        onPressed: () {
                          context
                              .read<TaskCubit>()
                              .updateTask(widget.taskModel);
                        },
                        child: Text("Update Task"));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
