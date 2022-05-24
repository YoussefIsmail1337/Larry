import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../NetworkHandler.dart';

class SignUp_Page extends StatefulWidget {
  const SignUp_Page({Key? key}) : super(key: key);

  @override
  State<SignUp_Page> createState() => _SignUp_PageState();
}

class _SignUp_PageState extends State<SignUp_Page> {
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final TextEditingController tagTextField = TextEditingController();
  final TextEditingController usernameTextField = TextEditingController();
  final TextEditingController emailTextField = TextEditingController();
  final TextEditingController passwordTextField = TextEditingController();
  bool hideNewPassword = true;
  final TextEditingController confirmTextField = TextEditingController();
  bool hideConfirmPassword = true;
  final TextEditingController birthdateTextField = TextEditingController();
  String birthdate = '';

  bool hideAdvancedOptions = true;

  final TextEditingController locationTextField = TextEditingController();
  final TextEditingController phoneTextField = TextEditingController();
  final TextEditingController websiteTextField = TextEditingController();
  final TextEditingController biographyTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text(
          'Sign Up',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Form(
              key: signupFormKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        controller: tagTextField,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This is a required field';
                          } else {
                            if (!RegExp(r'^\w*$').hasMatch(value)) {
                              return 'Tag can only contain letters, digits, and underscores';
                            } else {
                              return null;
                            }
                          }
                        },
                        maxLength: 16,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          labelText: 'Tag',
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
                        controller: usernameTextField,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This is a required field';
                          } else {
                            return null;
                          }
                        },
                        maxLength: 16,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          labelText: 'Username',
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
                      padding: const EdgeInsets.only(top: 10, bottom: 30),
                      child: TextFormField(
                        controller: emailTextField,
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
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          labelText: 'Email',
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
                          } else {
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            } else {
                              int passwordStrength = 0;
                              passwordStrength += (value.length >= 12) ? 1 : 0;
                              passwordStrength +=
                                  RegExp(r'''\d''').hasMatch(value) ? 1 : 0;
                              passwordStrength +=
                                  RegExp(r'''[a-z]''').hasMatch(value) ? 1 : 0;
                              passwordStrength +=
                                  RegExp(r'''[A-Z]''').hasMatch(value) ? 1 : 0;
                              passwordStrength +=
                                  RegExp(r'''[\ \!\"\#\$\%\&\'\(\)\*\+\,\-\.\/\:\;\<\=\>\?\@\[\\\]\^\_\`\{\|\}\~]''')
                                          .hasMatch(value)
                                      ? 1
                                      : 0;

                              if (passwordStrength < 4) {
                                return 'Password is too weak. (Password strength: $passwordStrength/4) \n Password criteria:\n[+1] At least 12 characters\n[+1] At least one digit\n[+1] At least one lowercase letter\n[+1] At least one uppercase letter\n[+1] At least one symbol';
                              } else {
                                return null;
                              }
                            }
                          }
                        },
                        maxLength: 16,
                        obscureText: hideNewPassword,
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
                                hideNewPassword = !hideNewPassword;
                                setState(() {});
                              },
                              style: TextButton.styleFrom(
                                shape: const CircleBorder(),
                                minimumSize: Size.zero,
                                padding: const EdgeInsets.all(5),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Icon(
                                hideNewPassword
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        controller: confirmTextField,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This is a required field';
                          } else {
                            if (value != passwordTextField.text) {
                              return 'Passwords do not match';
                            }
                          }
                          return null;
                        },
                        maxLength: 16,
                        obscureText: hideConfirmPassword,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          labelText: 'Confirm Password',
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
                                hideConfirmPassword = !hideConfirmPassword;
                                setState(() {});
                              },
                              style: TextButton.styleFrom(
                                shape: const CircleBorder(),
                                minimumSize: Size.zero,
                                padding: const EdgeInsets.all(5),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Icon(
                                hideConfirmPassword
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
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 30),
                      child: TextFormField(
                        controller: birthdateTextField,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This is a required field';
                          } else {
                            return null;
                          }
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          labelText: 'Birthdate',
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
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now()
                                      .subtract(const Duration(days: 18 * 365)),
                                  firstDate: DateTime.now().subtract(
                                      const Duration(days: 100 * 365)),
                                  lastDate: DateTime.now(),
                                  helpText: 'Chose your birthdate',
                                  confirmText: 'Confirm',
                                  cancelText: 'Cancel',
                                ).then(
                                  (chosenDate) async {
                                    if (chosenDate != null) {
                                      birthdate = DateTime(chosenDate.year,
                                              chosenDate.month, chosenDate.day)
                                          .toString();
                                      birthdateTextField.text =
                                          DateFormat('EEE, MMMM d, yyyy')
                                              .format(chosenDate.toLocal());
                                    }
                                  },
                                );
                              },
                              style: TextButton.styleFrom(
                                shape: const CircleBorder(),
                                minimumSize: Size.zero,
                                padding: const EdgeInsets.all(5),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Icon(
                                Icons.calendar_month,
                                size: 28,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (!hideAdvancedOptions) ...[
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 30),
                        child: TextFormField(
                          controller: locationTextField,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: 'Location',
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
                        padding: const EdgeInsets.only(top: 10, bottom: 30),
                        child: TextFormField(
                          controller: phoneTextField,
                          validator: (value) {
                            if (!RegExp(r'^\d*$').hasMatch(value ?? '')) {
                              return 'Phone Number can only contain digits';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: 'Phone Number',
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
                        padding: const EdgeInsets.only(top: 10, bottom: 30),
                        child: TextFormField(
                          controller: websiteTextField,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: 'Website',
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
                          controller: biographyTextField,
                          maxLength: 140,
                          maxLines: null,
                          minLines: null,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: 'Biography',
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
                    ],
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: OutlinedButton(
                        onPressed: () async {
                          if (signupFormKey.currentState!.validate()) {
                            Map<String, dynamic> signupInfo =
                                await NetworkHandler.signUp(
                                    tagTextField.text,
                                    usernameTextField.text,
                                    emailTextField.text,
                                    passwordTextField.text,
                                    birthdate,
                                    locationTextField.text,
                                    phoneTextField.text,
                                    websiteTextField.text,
                                    biographyTextField.text);

                            if (signupInfo['error'] == null) {
                              Navigator.pop(context);

                              showDialog(
                                context: context,
                                builder: (context) => const SimpleDialog(
                                  title:
                                      Text('Success! Please check your Email.'),
                                  children: [
                                    Text(
                                        'Success!\nYour new account will be ready as soon as you verify your Email address.\nJust click the link.'),
                                  ],
                                ),
                              );
                            } else {
                              Future.delayed(
                                Duration.zero,
                                () =>
                                    ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(signupInfo['error'])),
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
                          'Sign up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextButton(
                        onPressed: () {
                          hideAdvancedOptions = !hideAdvancedOptions;
                          setState(() {});
                        },
                        style: TextButton.styleFrom(
                          shape: const StadiumBorder(),
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.all(5),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              (hideAdvancedOptions)
                                  ? Icons.keyboard_double_arrow_down
                                  : Icons.keyboard_double_arrow_up,
                              size: 20,
                            ),
                            Text(
                              (hideAdvancedOptions)
                                  ? 'Show advanced options'
                                  : 'Hide advanced options',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
