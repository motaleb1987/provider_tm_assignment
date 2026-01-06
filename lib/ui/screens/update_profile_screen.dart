import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:task_management/data/model/user_model.dart';
import 'package:task_management/data/services/api_caller.dart';
import 'package:task_management/data/utils/urls.dart';
import 'package:task_management/providers/auth_provider.dart';
import 'package:task_management/ui/controller/auth_controller.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
import 'package:task_management/ui/widgets/snack_bar.dart';
import 'package:task_management/ui/widgets/tm_app_bar.dart';

import '../widgets/photo_picker.dart';
class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {


TextEditingController emailController = TextEditingController();
TextEditingController firstNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();
TextEditingController mobileController = TextEditingController();
TextEditingController passwordController = TextEditingController();

GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  XFile ? _selectedImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final UserModel user = authProvider.userModel!;
      if(user != null){
        emailController.text = user.email;
        firstNameController.text = user.firstName;
        lastNameController.text = user.lastName;
        mobileController.text = user.mobile;
      }
    });
  }

  Future<void> _pickImage() async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if(image !=null){
      _selectedImage = image;
      setState(() {

      });
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 70,),
              Text('Update Profile',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10,),
              PhotoPicker(onTap: _pickImage, selectedPhoto: _selectedImage,),
              const SizedBox(height: 10,),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    hintText: 'Email'
                ),
                validator: (String ? value){
                  if(value == null || value.isEmpty){
                    return 'Please enter your email';
                  }
                  final emailRegExp = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );
                  if (!emailRegExp.hasMatch(value)) {
                    return 'Please entry valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(
                    hintText: 'First Name'
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your first name';
                  }
                  if (value.trim().length < 2) {
                    return 'Enter first name at least 2 character';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(
                    hintText: 'Last Name'
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your last name';
                  }
                  if (value.trim().length < 2) {
                    return 'Enter last name at least 2 character';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: mobileController,
                decoration: InputDecoration(
                    hintText: 'Mobile'
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your Mobile number';
                  }
                  if (value.trim().length != 11) {
                    return 'Enter valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10,),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Password'
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty && value.length < 6) {
                    return 'Enter a password more than 6 letters';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 10,),

              FilledButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
                      updateProfile();
                    }
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPasswordVerifyOtpScreen()));
                  },
                  child: Icon(Icons.arrow_circle_right_outlined, size: 30,)),
              const SizedBox(
                height: 35,
              ),

            ],
          ),
        ),
      )),
    );
  }

  bool isLoading = false;
  Future<void> updateProfile()async {
    isLoading = true;
    setState(() {

    });
    Map<String, dynamic> requestBody = {
      'email': emailController.text,
      'firstName': firstNameController.text,
      'lastName': lastNameController.text,
      'mobile': mobileController.text
    };

    if(passwordController.text.isNotEmpty){
     requestBody['password'] = passwordController.text;
    }

    String ? encodedPhoto;
    if(_selectedImage !=null){
      List<int>bytes = await _selectedImage!.readAsBytes();
      encodedPhoto = jsonEncode(bytes);
      requestBody['photo'] = encodedPhoto;
    }

    final ApiResponse response = await ApiCaller.postRequest(url: Urls.updateProfileUrl, body: requestBody);
    isLoading = false;
    setState(() {

    });

    if(response.isSuccess){
      UserModel model = UserModel(
          id: AuthController.userModel!.id,
          email: emailController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          mobile: mobileController.text,
          photo: encodedPhoto ?? AuthController.userModel!.photo
      );

      AuthController.updateUserData(model);
      showSnackBarMessage(context, 'Profile updated');

    }else{
      showSnackBarMessage(context, response.errorMessage.toString());
    }


  }

}


