import 'dart:math';

import 'package:cool_alert/cool_alert.dart';
import 'package:ecomarce/constents/pageName.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../Widgets/fileds/FormInputBox.dart';
import '../../helpers/validateHelper.dart';
import '../../provider/auth/AuthProvider.dart';
import '../../provider/storage/init.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final localStore = LocalDB.instense;

  @override
  Widget build(BuildContext context) {
    var GetAuthprovider = Provider.of<AuthProvider>(context, listen: false);
    getAuth() async {
      if (_formKey.currentState!.validate()) {
        Map response = await GetAuthprovider.login(
            email: emailController.text, pass: passController.text);
        print(response);
        if (response.containsKey('error')) {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            title: "Oh No!",
            text: response['error'].toString(),
          );
        } else if (response.containsKey('success')) {
          bool issave = await localStore
              .setStorege(key: 'auth', data: {"token": response['token']});
          if (!issave) {
            CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              title: "Oops!",
              text: "Sumthing Want Wrong!",
            );
          } else {
            context.pushReplacement("/");
          }
        }
      }
    }

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
              "Find Your Need I Deliver On Your Doorstep on Lower Price",
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
                          onTap: respon.loginLoading ? null : getAuth,
                          child: Container(
                            width: double.infinity,
                            height: 55,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: !respon.loginLoading
                                  ? Text(
                                      'Login',
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
                  GoRouter.of(context).pushNamed(AppPage.signup);
                },
                child: Text("Sign Up")),
          )
        ],
      )),
    );
  }
}
