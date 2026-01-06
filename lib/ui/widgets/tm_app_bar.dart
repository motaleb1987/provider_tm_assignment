import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/providers/auth_provider.dart';
import 'package:task_management/ui/controller/auth_controller.dart';
import 'package:task_management/ui/screens/update_profile_screen.dart';
class TMAppBar extends StatelessWidget implements PreferredSizeWidget{
  const TMAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
   // final profilePhoto = AuthController.userModel!.photo;
    final authProvider = Provider.of<AuthProvider>(context,listen: false);
    final userModel = authProvider.userModel;

    final profilePhoto = userModel?.photo ?? '';

    return AppBar(
      backgroundColor: Colors.green[400],
      title: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateProfileScreen()));
        },
        child: Row(
          spacing: 6,
          children: [
            CircleAvatar(
              radius: 25,
             child: profilePhoto.isNotEmpty ? Image.memory(jsonDecode(profilePhoto)) : Icon(Icons.person),
             // backgroundImage: AssetImage('assets/images/playstore-icon.png'),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${userModel!.firstName} ${userModel!.lastName}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(userModel.email, style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.white
                ),),
              ],
            )
          ],
        ),
      ),
      actions: [
        IconButton(onPressed: (){
         // AuthController.clearUserData();
          authProvider.logout();
          Navigator.pushNamedAndRemoveUntil(context, '/login', (predicate)=>false);
        }, icon: Icon(Icons.logout, color: Colors.white,))
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}