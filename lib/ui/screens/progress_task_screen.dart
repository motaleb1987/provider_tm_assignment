import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/data/model/task_model.dart';

import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import '../../providers/task_provider.dart';
import '../widgets/snack_bar.dart';
import '../widgets/task_card.dart';
import '../widgets/task_count_by_status.dart';
import '../widgets/tm_app_bar.dart';
class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {

  Future<void> loadData()async {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    await  Future.wait([
      taskProvider.fetchTaskStatusCount(),
      taskProvider.fetchTaskListByStatus('Progress')
    ]);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
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
                    itemCount: taskProvider.progressTasks.length,
                    itemBuilder: (context, index) {

                      return TaskCard(
                        taskModel: taskProvider.progressTasks[index],
                        cardColor: Colors.orange.shade500,
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
    );
  }
}
