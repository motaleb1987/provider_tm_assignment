import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/core/enums/api_state.dart';
import 'package:task_management/data/model/user_model.dart';
import 'package:task_management/data/services/api_caller.dart';

class AuthProvider extends ChangeNotifier{
  String ? _accessToken;
  String ? _errorMessage;
  UserModel ? _userModel;
  static String _accessTokenKey = 'token';
  static String _userModelkey ='user-data';

  ApiState _authState = ApiState.initial;

  String ? get accessToken => _accessToken;
  String ? get errorMessage => _errorMessage;
  UserModel ? get userModel => _userModel;
  ApiState ? get authState => _authState;
  bool get isLoggedIn => _accessToken !=null;


   Future saveUserData(UserModel model, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    await sharedPreferences.setString(_userModelkey, jsonEncode(model.toJson()));
    _accessToken = token;
    _userModel = model;
    ApiCaller.accessToken = token;
    notifyListeners();
  }

   Future loadUserData () async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String ? token = sharedPreferences.getString(_accessTokenKey);
    if(token !=null){
      _accessToken = token;
      ApiCaller.accessToken = token;
      String ? userData = sharedPreferences.getString(_userModelkey);
      _userModel = UserModel.formJson(jsonDecode(userData!));
    }
    notifyListeners();
  }

   Future<void> updateUserData(UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userModelkey, jsonEncode(model.toJson()));
    notifyListeners();
  }


  static Future<bool> checkLoginStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String ? token = sharedPreferences.getString(_accessTokenKey);
    return token !=null;
  }

   Future<void> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    _accessToken = null;
    _userModel = null;
    _authState = ApiState.initial;
    ApiCaller.accessToken = null;
    notifyListeners();
  }

  void setLoading(){
     _authState = ApiState.loading;
     notifyListeners();
  }

  void setSuccess(){
    _authState = ApiState.success;
    notifyListeners();
  }

  void setError(){
    _authState = ApiState.error;
    notifyListeners();
  }

  void resetState(){
    _authState = ApiState.initial;
    _errorMessage = null;
    notifyListeners();
  }

}