import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:task_management/app.dart';
import 'package:task_management/providers/auth_provider.dart';
import 'package:task_management/providers/network_provider.dart';
import 'package:task_management/providers/task_provider.dart';

void main() {
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_)=>AuthProvider()),
            ChangeNotifierProvider(create: (_)=>NetworkProvider()),
            ChangeNotifierProvider(create: (_)=>TaskProvider())
          ],
          child: TaskManagerApp()
      ),
  );
}
