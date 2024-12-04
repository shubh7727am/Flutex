import 'package:flutex_admin/core/utils/local_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutex_admin/core/utils/dimensions.dart';
import 'package:flutex_admin/core/utils/color_resources.dart';
import 'package:flutex_admin/core/utils/images.dart';
import 'package:flutex_admin/core/utils/style.dart';
import 'package:flutex_admin/data/controller/auth/login_controller.dart';
import 'package:flutex_admin/data/repo/auth/login_repo.dart';
import 'package:flutex_admin/data/services/api_service.dart';
import 'package:flutex_admin/view/components/buttons/rounded_button.dart';
import 'package:flutex_admin/view/components/buttons/rounded_loading_button.dart';
import 'package:flutex_admin/view/components/text-form-field/custom_text_field.dart';
import 'package:flutex_admin/view/components/text/default_text.dart';
import 'package:flutex_admin/view/components/will_pop_widget.dart';

import '../../../../core/route/route.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool isLoginPage = true; // Flag to toggle between Login and Signup

  @override
  void initState() {
    super.initState();
    Get.put(LoginController());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: '',
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: GetBuilder<LoginController>(
            builder: (controller) => SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: ColorResources.appBarColor,
                      image: DecorationImage(
                        alignment: Alignment.topCenter,
                        image: AssetImage(MyImages.login),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 140.0, bottom: 30.0),
                          child: Center(
                            child: Image.asset(MyImages.appLogo,
                                color: ColorResources.colorWhite, height: 60),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: Dimensions.space30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isLoginPage
                                      ? 'Login' // Hardcoded text for login
                                      : 'Signup', // Hardcoded text for signup
                                  style: mediumOverLarge.copyWith(
                                      fontSize: Dimensions.fontMegaLarge,
                                      color: Colors.white),
                                ),
                                Text(
                                  isLoginPage
                                      ? 'Enter your credentials to login' // Hardcoded desc for login
                                      : 'Create a new account', // Hardcoded desc for signup
                                  style: regularDefault.copyWith(
                                      fontSize: Dimensions.fontDefault,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              )),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: Dimensions.space20),
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if(!isLoginPage)
                                  CustomTextField(
                                    animatedLabel: true,
                                    needOutlineBorder: true,
                                    controller: controller.nameController,
                                    labelText: 'Name', // Hardcoded label
                                    onChanged: (value) {},
                                    focusNode: controller.nameFocusNode,
                                    nextFocus: controller.emailFocusNode,
                                    textInputType: TextInputType.name,
                                    inputAction: TextInputAction.next,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your name'; // Hardcoded error message
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                const SizedBox(height: Dimensions.space20),
                                CustomTextField(
                                  animatedLabel: true,
                                  needOutlineBorder: true,
                                  controller: controller.emailController,
                                  labelText: 'Email', // Hardcoded label
                                  onChanged: (value) {},
                                  focusNode: controller.emailFocusNode,
                                  nextFocus: controller.passwordFocusNode,
                                  textInputType: TextInputType.emailAddress,
                                  inputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your email'; // Hardcoded error message
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(height: Dimensions.space20),
                                CustomTextField(
                                  animatedLabel: true,
                                  needOutlineBorder: true,
                                  labelText: 'Password', // Hardcoded label
                                  controller: controller.passwordController,
                                  focusNode: controller.passwordFocusNode,
                                  onChanged: (value) {},
                                  isShowSuffixIcon: true,
                                  isPassword: true,
                                  textInputType: TextInputType.text,
                                  inputAction: TextInputAction.done,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your password'; // Hardcoded error message
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(height: Dimensions.space20),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 25,
                                          height: 25,
                                          child: Checkbox(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions
                                                          .defaultRadius)),
                                              activeColor:
                                              ColorResources.primaryColor,
                                              checkColor:
                                              ColorResources.colorWhite,
                                              value: controller.remember,
                                              side: MaterialStateBorderSide
                                                  .resolveWith(
                                                    (states) => BorderSide(
                                                    width: 1.0,
                                                    color: controller.remember
                                                        ? ColorResources
                                                        .getTextFieldEnableBorder()
                                                        : ColorResources
                                                        .getTextFieldDisableBorder()),
                                              ),
                                              onChanged: (value) {
                                                controller.changeRememberMe();
                                              }),
                                        ),
                                        const SizedBox(width: 8),
                                        DefaultText(
                                            text: 'Remember Me', // Hardcoded text
                                            textColor: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .color!
                                                .withOpacity(0.5))
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isLoginPage = !isLoginPage;
                                        });
                                      },
                                      child: DefaultText(
                                          text: isLoginPage
                                              ? 'NewUser?' // Hardcoded text for login
                                              : 'Already have account?', // Hardcoded text for signup
                                          textColor:
                                          ColorResources.secondaryColor),
                                    )
                                  ],
                                ),
                                const SizedBox(height: Dimensions.space20),
                                controller.isSubmitLoading
                                    ? const RoundedLoadingBtn()
                                    : RoundedButton(
                                    text: isLoginPage
                                        ? 'Sign In' // Hardcoded button text for login
                                        : 'Sign Up', // Hardcoded button text for signup
                                    press: () {
                                      if (isLoginPage) {
                                        controller.loginUser();

                                      } else {
                                        controller.signupUser(); // Hardcoded signup logic
                                      }
                                    }),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

