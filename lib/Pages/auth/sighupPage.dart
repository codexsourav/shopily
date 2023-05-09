// ignore_for_file: use_build_context_synchronously
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../Widgets/fileds/FormInputBox.dart';
import '../../constents/pageName.dart';
import '../../helpers/validateHelper.dart';
import '../../provider/auth/AuthProvider.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
        children: [
          Center(
            child: Image.asset(
              'assets/hero.png',
              width: MediaQuery.of(context).size.width - 120,
            ),
          ),
          const Text(
            "Welcome To Shopily",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Text(
              "Craeet Your New Account And Start Shoping",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  formInputBox(
                    hint: 'Name',
                    keybordtype: TextInputType.name,
                    controller: nameController,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Name';
                      } else if (ValidateHelper.chackLength(value, min: 5)) {
                        return 'Name Min Length 5';
                      }
                      return null;
                    },
                  ),
                  formInputBox(
                    hint: 'Email ID',
                    keybordtype: TextInputType.name,
                    controller: emailController,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Email ID';
                      } else if (!ValidateHelper.isValidEmail(value)) {
                        return 'Invalid Email ID';
                      }
                      return null;
                    },
                  ),
                  formInputBox(
                    hint: 'Password',
                    keybordtype: TextInputType.name,
                    obscureText: true,
                    controller: passController,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Password';
                      } else if (ValidateHelper.chackLength(value, min: 5)) {
                        return 'Password Min Length 5';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Consumer<AuthProvider>(
                      builder: (context, respon, child) {
                        return GestureDetector(
                          onTap: respon.signupLoading
                              ? null
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    Map response = await respon.signup(
                                        name: nameController.text,
                                        email: emailController.text,
                                        pass: passController.text);
                                    if (response.containsKey('error')) {
                                      await CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.warning,
                                        title: "Oops!",
                                        text: response['error'].toString(),
                                      );
                                    } else {
                                      await CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.success,
                                        title: "Account Created",
                                        text:
                                            "Your Account is Successfully Craeted",
                                        confirmBtnText: "Login",
                                        onConfirmBtnTap: () {
                                          context.pop();
                                        },
                                      );
                                    }
                                  }
                                },
                          child: Container(
                            width: double.infinity,
                            height: 55,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: !respon.signupLoading
                                  ? Text(
                                      'Signup',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  : SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
                onPressed: () {
                  GoRouter.of(context).pushNamed(AppPage.login);
                },
                child: Text("Login")),
          )
        ],
      )),
    );
  }
}
