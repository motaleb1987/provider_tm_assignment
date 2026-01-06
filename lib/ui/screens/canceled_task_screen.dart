import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/model/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import '../../providers/task_provider.dart';
import '../widgets/snack_bar.dart';
import '../widgets/task_card.dart';
import '../widgets/task_count_by_status.dart';
import '../widgets/tm_app_bar.dart';
class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {

  Future<void> loadData()async {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    Future.wait([
      taskProvider.fetchTaskStatusCount(),
      taskProvider.fetchTaskListByStatus('Cancelled')
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
                    itemCount: taskProvider.canceledTasks.length,
                    itemBuilder: (context, index) {

                      return TaskCard(
                        taskModel: taskProvider.canceledTasks[index],
                        cardColor: Colors.red.shade500,
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
