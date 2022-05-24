import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../NetworkHandler.dart';
import '../ThemeHandler.dart';
import '../UserProfile.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({Key? key}) : super(key: key);

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController usernameTextField = TextEditingController();
  final TextEditingController passwordTextField = TextEditingController();
  bool hidePassword = true;

  final GlobalKey<FormState> resetFormKey = GlobalKey<FormState>();
  final TextEditingController emailTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text(
          'Sign In',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: loginFormKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          controller: usernameTextField,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This is a required field';
                            } else {
                              if (value.contains('@') || value.contains('.')) {
                                List<String> email = value.split('@');
                                if (email.length == 2) {
                                  email.addAll(email[1].split('.'));
                                  email.removeAt(1);
                                  if (email.length > 2) {
                                    for (String emailSection in email) {
                                      if (emailSection.isEmpty) {
                                        return 'This is not a valid Email';
                                      }
                                    }
                                  } else {
                                    return 'This is not a valid Email';
                                  }
                                } else {
                                  return 'This is not a valid Email';
                                }
                              }
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: 'Username | Email',
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          controller: passwordTextField,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This is a required field';
                            }
                            return null;
                          },
                          obscureText: hidePassword,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsetsDirectional.only(end: 5),
                              child: TextButton(
                                onPressed: () {
                                  hidePassword = !hidePassword;
                                  setState(() {});
                                },
                                style: TextButton.styleFrom(
                                  shape: const CircleBorder(),
                                  minimumSize: Size.zero,
                                  padding: const EdgeInsets.all(5),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Icon(
                                  hidePassword
                                      ? Icons.remove_red_eye_outlined
                                      : Icons.remove_red_eye,
                                  size: 28,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Consumer<ThemeNotifier>(
                  builder: (context, notifier, child) => OutlinedButton(
                    onPressed: () async {
                      if (loginFormKey.currentState!.validate()) {
                        Map<String, dynamic> loginInfo =
                            await NetworkHandler.login(
                                usernameTextField.text, passwordTextField.text);

                        if (loginInfo['error'] == null) {
                          MyProfile.userToken = loginInfo['userToken'];
                          MyProfile.adminToken = loginInfo['adminToken'];
                          MyProfile.id = loginInfo['id'];
                          notifier.setTheme(loginInfo['darkMode']);

                          Navigator.pushNamedAndRemoveUntil(context, '/Home',
                              ModalRoute.withName('/Welcome'));
                        } else {
                          Future.delayed(
                            Duration.zero,
                            () => ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(loginInfo['error'])),
                            ),
                          );
                        }
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      minimumSize: Size.zero,
                      fixedSize: const Size(220, 60),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Reset Password'),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Form(
                                key: resetFormKey,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: TextFormField(
                                          controller: emailTextField,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'This is a required field';
                                            } else {
                                              if (value.contains('@') ||
                                                  value.contains('.')) {
                                                List<String> email =
                                                    value.split('@');
                                                if (email.length == 2) {
                                                  email.addAll(
                                                      email[1].split('.'));
                                                  email.removeAt(1);
                                                  if (email.length > 2) {
                                                    for (String emailSection
                                                        in email) {
                                                      if (emailSection
                                                          .isEmpty) {
                                                        return 'This is not a valid Email';
                                                      }
                                                    }
                                                    return null;
                                                  } else {
                                                    return 'This is not a valid Email';
                                                  }
                                                } else {
                                                  return 'This is not a valid Email';
                                                }
                                              }
                                              return 'This is not a valid Email';
                                            }
                                          },
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.auto,
                                            labelText: 'Email',
                                            labelStyle: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            style: TextButton.styleFrom(
                              shape: const StadiumBorder(),
                              minimumSize: Size.zero,
                              padding: const EdgeInsets.all(5),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Reset',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () async {
                              if (resetFormKey.currentState!.validate()) {
                                Map<String, dynamic> resetPasswordInfo =
                                    await NetworkHandler.resetPassword(
                                        emailTextField.text);

                                Navigator.pop(context);

                                if (resetPasswordInfo['error'] == null) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => SimpleDialog(
                                      title: const Text('Success!'),
                                      children: [
                                        Text(resetPasswordInfo['success']),
                                      ],
                                    ),
                                  );
                                } else {
                                  Future.delayed(
                                    Duration.zero,
                                    () => ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                          content:
                                              Text(resetPasswordInfo['error'])),
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              shape: const StadiumBorder(),
                              minimumSize: Size.zero,
                              padding: const EdgeInsets.all(5),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Cancel',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.all(5),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Consumer<ThemeNotifier>(
                  builder: (context, notifier, child) => OutlinedButton(
                    onPressed: () async {
                      //TEMP: IMPLEMENT LOGIN WITH GOOGLE
                      Map<String, dynamic> loginInfo =
                          await NetworkHandler.loginGoogle();

                      if (loginInfo['error'] == null) {
                        MyProfile.userToken = loginInfo['userToken'];
                        MyProfile.adminToken = loginInfo['adminToken'];
                        MyProfile.id = loginInfo['id'];
                        notifier.setTheme(loginInfo['darkMode']);

                        Navigator.pushNamedAndRemoveUntil(
                            context, '/Home', ModalRoute.withName('/Welcome'));
                      } else {
                        Future.delayed(
                          Duration.zero,
                          () => ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(loginInfo['error'])),
                          ),
                        );
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      minimumSize: Size.zero,
                      fixedSize: const Size(220, 60),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Sign in using Google',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
