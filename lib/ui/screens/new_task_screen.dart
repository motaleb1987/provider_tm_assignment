import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/data/model/task_model.dart';
import 'package:task_management/data/model/task_status_count_model.dart';
import 'package:task_management/data/services/api_caller.dart';
import 'package:task_management/data/utils/urls.dart';
import 'package:task_management/providers/task_provider.dart';
import 'package:task_management/ui/screens/add_new_task_screen.dart';
import 'package:task_management/ui/widgets/snack_bar.dart';

import '../widgets/task_card.dart';
import '../widgets/task_count_by_status.dart';
import '../widgets/tm_app_bar.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {

  Future<void> loadData()async {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
  await  Future.wait([
    taskProvider.fetchTaskStatusCount(),
    taskProvider.fetchTaskListByStatus('New')
    ]);
  }






  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: TMAppBar(),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return Column(
            children: [
              SizedBox(height: 15),
              SizedBox(
                height: 90,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: taskProvider.taskStatusCount.length,
                  itemBuilder: (context, index) {
                    final counts = taskProvider.taskStatusCount;
                    return TaskCountByStatus(
                        title: counts[index].status,
                        count: counts[index].count
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 4);
                  },
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: taskProvider.newTask.length,
                  itemBuilder: (context, index) {

                    return TaskCard(
                        taskModel: taskProvider.newTask[index],
                        cardColor: Colors.blue,
                        refreshParent: () async {
                         await loadData();
                        },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 4);
                  },
                ),
              ),
            ],
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNewTaskScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
