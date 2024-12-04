import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutex_admin/assignment_work/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutex_admin/core/helper/shared_preference_helper.dart';
import 'package:flutex_admin/core/route/route.dart';
import 'package:flutex_admin/data/model/auth/login/login_response_model.dart';
import 'package:flutex_admin/data/model/global/response_model/response_model.dart';
import 'package:flutex_admin/data/repo/auth/login_repo.dart';
import 'package:flutex_admin/view/components/snack_bar/show_custom_snackbar.dart';

class LoginController extends GetxController {
  LoginRepo? loginRepo;

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode nameFocusNode = FocusNode();

  TextEditingController emailController =
      TextEditingController(text: 'admin@demo.com');
  TextEditingController passwordController =
      TextEditingController(text: '123456');
  TextEditingController nameController =
  TextEditingController(text: 'shubham');

  List<String> errors = [];
  String? email;
  String? password;
  String? name;
  bool remember = false;


  LoginController({this.loginRepo});

  Future<void> checkAndGotoNextStep(LoginResponseModel responseModel) async {
    // if (remember) {
    //   await loginRepo.apiClient.sharedPreferences
    //       .setBool(SharedPreferenceHelper.rememberMeKey, true);
    // } else {
    //   await loginRepo.apiClient.sharedPreferences
    //       .setBool(SharedPreferenceHelper.rememberMeKey, false);
    // }
    //
    // await loginRepo.apiClient.sharedPreferences.setString(
    //     SharedPreferenceHelper.userIdKey,
    //     responseModel.data?.staff!.staffId.toString() ?? '-1');
    // await loginRepo.apiClient.sharedPreferences.setString(
    //     SharedPreferenceHelper.accessTokenKey,
    //     responseModel.data?.accessToken.toString() ?? '');
    // await loginRepo.apiClient.sharedPreferences.setString(
    //     SharedPreferenceHelper.accessSessionKey,
    //     responseModel.data?.session.toString() ?? '');
    //
    // Get.offAndToNamed(RouteHelper.dashboardScreen);
    //
    // if (remember) {
    //   changeRememberMe();
    // }
  }

  bool isSubmitLoading = false;

  void loginUser() async {

    var user = await AuthService().loginUserWithEmailAndPassword(emailController.text.toString(),passwordController.text.toString());
    if(user !=  null){

      Get.offAndToNamed(RouteHelper.dashboardScreen);

    }
    else{


    }
    // isSubmitLoading = true;
    // update();
    //
    // ResponseModel model = await loginRepo.loginUser(
    //     emailController.text.toString(), passwordController.text.toString());
    //
    //
    //
    // if (model.statusCode == 200) {
    //   LoginResponseModel loginModel =
    //       LoginResponseModel.fromJson(jsonDecode(model.responseJson));
    //   if (loginModel.status!) {
    //     checkAndGotoNextStep(loginModel);
    //   } else {
    //     CustomSnackBar.error(errorList: [loginModel.message!]);
    //   }
    // } else {
    //
    //
    //
    //   CustomSnackBar.error(errorList: [model.message.tr]);
    // }
    // isSubmitLoading = false;
    // update();
  }

  void signupUser()async{
    await AuthService().createUserWithEmailAndPassword(emailController.text.toString(), passwordController.text.toString(), nameController.text.toString()).then((value) {
      Get.offAndToNamed(RouteHelper.dashboardScreen);
    });

  }

  changeRememberMe() {
    remember = !remember;
    update();
  }

  void clearTextField() {
    passwordController.text = '';
    emailController.text = '';
    if (remember) {
      remember = false;
    }
    update();
  }
}
