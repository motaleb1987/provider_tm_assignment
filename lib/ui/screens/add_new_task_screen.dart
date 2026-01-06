import 'package:flutter/material.dart';
import 'package:task_management/data/services/api_caller.dart';
import 'package:task_management/data/utils/urls.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
import 'package:task_management/ui/widgets/snack_bar.dart';
import 'package:task_management/ui/widgets/tm_app_bar.dart';
class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80,),
                Text('Add New Task', style: Theme.of(context).textTheme.titleLarge,),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Title'
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please enter title';
                    }
                  },
            
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'Description'
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please enter description';
                    }
                  },
                ),
                const SizedBox(height: 20,),
                FilledButton(onPressed: (){
                  if(_formKey.currentState!.validate()){
                    addNewTask();
                  }
            
                }, child: Icon(Icons.arrow_circle_right_outlined, size: 30,))
              ],
            ),
          ),
        ),
      )),
    );
  }

  bool _addTaskProgress = false;

  Future<void> addNewTask()async{
    _addTaskProgress = true;
    setState(() {

    });

    Map<String, dynamic> requestBody = {
      "title":titleController.text,
      "description":descriptionController.text,
      "status":"New"
    };
    
    final ApiResponse response = await ApiCaller.postRequest(
        url: Urls.createTaskUrl,
      body: requestBody,
    );

    _addTaskProgress = false;
    setState(() {

    });

    if(response.isSuccess){
      _clearField();
      Navigator.pushNamedAndRemoveUntil(context, '/main_nav', (predicate)=>false);
      showSnackBarMessage(context, 'New Task Added');
    }else{
      showSnackBarMessage(context, response.errorMessage!);
    }

  }


  _clearField(){
    titleController.clear();
    descriptionController.clear();
  }

}
