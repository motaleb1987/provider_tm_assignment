import 'package:flutter/material.dart';
import 'package:task_management/ui/screens/canceled_task_screen.dart';
import 'package:task_management/ui/screens/completed_task_screen.dart';
import 'package:task_management/ui/screens/new_task_screen.dart';
import 'package:task_management/ui/screens/progress_task_screen.dart';

class MainNavBarHolderScreen extends StatefulWidget {
  const MainNavBarHolderScreen({super.key});

  @override
  State<MainNavBarHolderScreen> createState() => _MainNavBarHolderScreenState();
}

class _MainNavBarHolderScreenState extends State<MainNavBarHolderScreen> {
  int _selectedIndex = 0;
  List<Widget> _screens = [
    NewTaskScreen(),
    ProgressTaskScreen(),
    CompletedTaskScreen(),
    CanceledTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          _selectedIndex = index;
          setState(() {});
        },

        destinations: [
          NavigationDestination(
            icon: Icon(Icons.text_snippet_rounded),
            label: 'New Task',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_alt_outlined),
            label: 'Progress',
          ),
          NavigationDestination(icon: Icon(Icons.done_all), label: 'Completed'),
          NavigationDestination(
            icon: Icon(Icons.cancel_presentation),
            label: 'Cancelled',
          ),
        ],
      ),
    );
  }
}
