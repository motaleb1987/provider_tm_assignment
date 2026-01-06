import 'package:flutter/cupertino.dart';
import 'package:task_management/core/enums/api_state.dart';
import 'package:task_management/data/model/task_model.dart';
import 'package:task_management/data/model/task_status_count_model.dart';

import '../data/services/api_caller.dart';
import '../data/utils/urls.dart';

class TaskProvider extends ChangeNotifier{
  List<TaskModel> _newTasks =[];
  List<TaskModel> _progressTasks =[];
  List<TaskModel> _completeTasks =[];
  List<TaskModel> _canceledTasks =[];

  List<TaskStatusCountModel> _taskStatusCount =[];

  ApiState _taskListState = ApiState.initial;
  ApiState _taskCountState = ApiState.initial;
  String ? _errorMessage;

  List<TaskModel> get newTask => _newTasks;
  List<TaskModel> get progressTasks => _progressTasks;
  List<TaskModel> get completeTasks => _completeTasks;
  List<TaskModel> get canceledTasks => _canceledTasks;
  List<TaskStatusCountModel> get taskStatusCount => _taskStatusCount;


  Future<void> fetchTaskStatusCount()async {
    _taskCountState = ApiState.loading;
    notifyListeners();

    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.taskCountUrl,
    );
    if(response.isSuccess){
      _taskStatusCount =[];
        for (Map<String, dynamic> jsonData in response.responseData['data']) {
          _taskStatusCount.add(TaskStatusCountModel.formJson(jsonData));
        }
        _taskCountState = ApiState.success;
        _errorMessage = null;
    }else{
      _taskCountState = ApiState.error;
      _errorMessage = response.errorMessage ?? 'Failed to fetch Task Count';
    }

    notifyListeners();
  }

  Future<void> fetchTaskListByStatus(String status)async {
    _taskListState = ApiState.loading;
    notifyListeners();

    String url;

    switch(status){
      case ('New'):
        url = Urls.newTaskUrl;
        break;
      case ('Completed'):
        url = Urls.completedTaskUrl;
        break;

      case ('Progress'):
        url = Urls.progressTaskUrl;
        break;
      case ('Cancelled'):
        url = Urls.canceledTaskUrl;
        break;
      default:
        url = Urls.newTaskUrl;
    }


    final ApiResponse response = await ApiCaller.getRequest(url: url);
    if(response.isSuccess){
      List<TaskModel> task = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        task.add(TaskModel.fromJson(jsonData));
      }

      switch(status){
        case ('New'):
          _newTasks = task;
          break;
        case ('Completed'):
          _completeTasks = task;
          break;

        case ('Progress'):
          _progressTasks = task;
          break;
        case ('Cancelled'):
          _canceledTasks = task;
          break;
        default:
          _newTasks = task;
      }

      _taskListState = ApiState.success;
      _errorMessage = null;
    }else{
      _taskCountState = ApiState.error;
      _errorMessage = response.errorMessage ?? 'Failed to fetch Task List';
    }

    notifyListeners();
  }

}