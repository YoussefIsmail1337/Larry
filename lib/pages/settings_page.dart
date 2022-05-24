import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../NetworkHandler.dart';
import '../ThemeHandler.dart';
import '../UserProfile.dart';

class Settings_Page extends StatefulWidget {
  const Settings_Page({Key? key}) : super(key: key);

  @override
  State<Settings_Page> createState() => _Settings_PageState();
}

class _Settings_PageState extends State<Settings_Page> {
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  final TextEditingController currentTextField = TextEditingController();
  bool hideCurrentPassword = true;
  final TextEditingController newTextField = TextEditingController();
  bool hideNewPassword = true;
  final TextEditingController confirmTextField = TextEditingController();
  bool hideConfirmPassword = true;

  bool newFollowSwitch = false;
  bool newTweetSwitch = false;
  bool newLikeSwitch = false;

  bool privateSwitch = false;
  bool themeSwitch = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: MyProfile.updateProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data! == true) {
              privateSwitch = MyProfile.isPrivate;
              newFollowSwitch = MyProfile.newFollowNotification;
              newTweetSwitch = MyProfile.newTweetNotification;
              newLikeSwitch = MyProfile.newLikeNotification;
              return Scaffold(
                resizeToAvoidBottomInset: true,
                appBar: AppBar(
                  automaticallyImplyLeading: true,
                  centerTitle: true,
                  title: Stack(
                    alignment: Alignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'LA',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox.square(
                            dimension: 40,
                          ),
                          Text(
                            'RY',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox.square(
                        dimension: 80,
                        child: Image(
                          image: AssetImage('assets/logo.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
                drawer: Drawer(
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    '/Profile', ModalRoute.withName('/Welcome'),
                                    arguments: {'profileID': MyProfile.id});
                              },
                              child: Column(
                                children: [
                                  CircleAvatar(
                                      foregroundImage: (MyProfile
                                              .avatarURL.isNotEmpty)
                                          ? NetworkImage(MyProfile.avatarURL)
                                          : null,
                                      backgroundImage: const AssetImage(
                                          'assets/myavatar.png'),
                                      radius: 60),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Column(
                                      children: [
                                        Text(
                                          MyProfile.screenName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24,
                                          ),
                                        ),
                                        Text(
                                          '@' + MyProfile.tag,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: const ContinuousRectangleBorder(),
                              minimumSize: Size.zero,
                              padding: const EdgeInsets.all(5),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              backgroundColor: (ModalRoute.of(context)!
                                              .settings
                                              .name ==
                                          ('/Home') ||
                                      ModalRoute.of(context)!.settings.name ==
                                          ('/Explore') ||
                                      ModalRoute.of(context)!.settings.name ==
                                          ('/Search') ||
                                      ModalRoute.of(context)!.settings.name ==
                                          ('/Notifications'))
                                  ? Colors.grey
                                  : null,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Icon(
                                  Icons.home,
                                  size: 40,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    'Home',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              if (ModalRoute.of(context)!.settings.name !=
                                  ('/Home')) {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    '/Home', ModalRoute.withName('/Welcome'));
                              }
                            },
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: const ContinuousRectangleBorder(),
                              minimumSize: Size.zero,
                              padding: const EdgeInsets.all(5),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              backgroundColor:
                                  (ModalRoute.of(context)!.settings.name ==
                                          ('/Profile'))
                                      ? Colors.grey
                                      : null,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Icon(
                                  Icons.person,
                                  size: 40,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    'Profile',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              if (ModalRoute.of(context)!.settings.name !=
                                  ('/Profile')) {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    '/Profile', ModalRoute.withName('/Welcome'),
                                    arguments: {'profileID': MyProfile.id});
                              }
                            },
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: const ContinuousRectangleBorder(),
                              minimumSize: Size.zero,
                              padding: const EdgeInsets.all(5),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              backgroundColor:
                                  (ModalRoute.of(context)!.settings.name ==
                                          ('/Settings'))
                                      ? Colors.grey
                                      : null,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Icon(
                                  Icons.settings,
                                  size: 40,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    'Settings',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              if (ModalRoute.of(context)!.settings.name !=
                                  ('/Settings')) {
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/Settings',
                                    ModalRoute.withName('/Welcome'));
                              }
                            },
                          ),
                          if (MyProfile.adminToken.isNotEmpty) ...[
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: const ContinuousRectangleBorder(),
                                minimumSize: Size.zero,
                                padding: const EdgeInsets.all(5),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                backgroundColor:
                                    (ModalRoute.of(context)!.settings.name ==
                                            ('/Admin'))
                                        ? Colors.grey
                                        : null,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Icon(
                                    Icons.admin_panel_settings,
                                    size: 40,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      'Admin Panel',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                if (ModalRoute.of(context)!.settings.name !=
                                    ('/Admin')) {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      '/Admin',
                                      ModalRoute.withName('/Welcome'));
                                }
                              },
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.person,
                                size: 36,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 2,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    'Account',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: const ContinuousRectangleBorder(),
                                  minimumSize: Size.zero,
                                  padding: const EdgeInsets.all(5),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Row(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 45, top: 10, bottom: 10),
                                      child: Text(
                                        'Edit profile',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Icon(
                                            Icons.arrow_right,
                                            size: 40,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(
                                          context, '/Settings/EditProfile')
                                      .then((value) => setState(() {}));
                                },
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: const ContinuousRectangleBorder(),
                                  minimumSize: Size.zero,
                                  padding: const EdgeInsets.all(5),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Row(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 45, top: 10, bottom: 10),
                                      child: Text(
                                        'Change password',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Icon(
                                            Icons.arrow_right,
                                            size: 40,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => StatefulBuilder(
                                      builder: (context, setState) =>
                                          AlertDialog(
                                        title: const Text('Change Password'),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Form(
                                                key: passwordFormKey,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 10,
                                                                bottom: 30),
                                                        child: TextFormField(
                                                          controller:
                                                              currentTextField,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return 'This is a required field';
                                                            }
                                                            return null;
                                                          },
                                                          obscureText:
                                                              hideCurrentPassword,
                                                          decoration:
                                                              InputDecoration(
                                                            floatingLabelBehavior:
                                                                FloatingLabelBehavior
                                                                    .auto,
                                                            labelText:
                                                                'Current Password',
                                                            labelStyle:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 16,
                                                            ),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            suffixIcon: Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                          .only(
                                                                      end: 5),
                                                              child: TextButton(
                                                                onPressed: () {
                                                                  hideCurrentPassword =
                                                                      !hideCurrentPassword;
                                                                  setState(
                                                                      () {});
                                                                },
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  shape:
                                                                      const CircleBorder(),
                                                                  minimumSize:
                                                                      Size.zero,
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(5),
                                                                  tapTargetSize:
                                                                      MaterialTapTargetSize
                                                                          .shrinkWrap,
                                                                ),
                                                                child: Icon(
                                                                  hideCurrentPassword
                                                                      ? Icons
                                                                          .remove_red_eye_outlined
                                                                      : Icons
                                                                          .remove_red_eye,
                                                                  size: 28,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 10),
                                                        child: TextFormField(
                                                          controller:
                                                              newTextField,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return 'This is a required field';
                                                            } else {
                                                              if (value.length <
                                                                  6) {
                                                                return 'Password must be at least 6 characters long';
                                                              } else {
                                                                int passwordStrength =
                                                                    0;
                                                                passwordStrength +=
                                                                    (value.length >=
                                                                            12)
                                                                        ? 1
                                                                        : 0;
                                                                passwordStrength +=
                                                                    RegExp(r'''\d''')
                                                                            .hasMatch(value)
                                                                        ? 1
                                                                        : 0;
                                                                passwordStrength +=
                                                                    RegExp(r'''[a-z]''')
                                                                            .hasMatch(value)
                                                                        ? 1
                                                                        : 0;
                                                                passwordStrength +=
                                                                    RegExp(r'''[A-Z]''')
                                                                            .hasMatch(value)
                                                                        ? 1
                                                                        : 0;
                                                                passwordStrength +=
                                                                    RegExp(r'''[\ \!\"\#\$\%\&\'\(\)\*\+\,\-\.\/\:\;\<\=\>\?\@\[\\\]\^\_\`\{\|\}\~]''')
                                                                            .hasMatch(value)
                                                                        ? 1
                                                                        : 0;

                                                                if (passwordStrength <
                                                                    4) {
                                                                  return 'Password is too weak. (Password strength: $passwordStrength/4) \n Password criteria:\n[+1] At least 12 characters\n[+1] At least one digit\n[+1] At least one lowercase letter\n[+1] At least one uppercase letter\n[+1] At least one symbol';
                                                                } else {
                                                                  return null;
                                                                }
                                                              }
                                                            }
                                                          },
                                                          maxLength: 16,
                                                          obscureText:
                                                              hideNewPassword,
                                                          decoration:
                                                              InputDecoration(
                                                            floatingLabelBehavior:
                                                                FloatingLabelBehavior
                                                                    .auto,
                                                            labelText:
                                                                'New Password',
                                                            labelStyle:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 16,
                                                            ),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            suffixIcon: Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                          .only(
                                                                      end: 5),
                                                              child: TextButton(
                                                                onPressed: () {
                                                                  hideNewPassword =
                                                                      !hideNewPassword;
                                                                  setState(
                                                                      () {});
                                                                },
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  shape:
                                                                      const CircleBorder(),
                                                                  minimumSize:
                                                                      Size.zero,
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(5),
                                                                  tapTargetSize:
                                                                      MaterialTapTargetSize
                                                                          .shrinkWrap,
                                                                ),
                                                                child: Icon(
                                                                  hideNewPassword
                                                                      ? Icons
                                                                          .remove_red_eye_outlined
                                                                      : Icons
                                                                          .remove_red_eye,
                                                                  size: 28,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 10),
                                                        child: TextFormField(
                                                          controller:
                                                              confirmTextField,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return 'This is a required field';
                                                            } else {
                                                              if (value !=
                                                                  newTextField
                                                                      .text) {
                                                                return 'Passwords do not match';
                                                              }
                                                            }
                                                            return null;
                                                          },
                                                          maxLength: 16,
                                                          obscureText:
                                                              hideConfirmPassword,
                                                          decoration:
                                                              InputDecoration(
                                                            floatingLabelBehavior:
                                                                FloatingLabelBehavior
                                                                    .auto,
                                                            labelText:
                                                                'Confirm New Password',
                                                            labelStyle:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 16,
                                                            ),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            suffixIcon: Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                          .only(
                                                                      end: 5),
                                                              child: TextButton(
                                                                onPressed: () {
                                                                  hideConfirmPassword =
                                                                      !hideConfirmPassword;
                                                                  setState(
                                                                      () {});
                                                                },
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  shape:
                                                                      const CircleBorder(),
                                                                  minimumSize:
                                                                      Size.zero,
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(5),
                                                                  tapTargetSize:
                                                                      MaterialTapTargetSize
                                                                          .shrinkWrap,
                                                                ),
                                                                child: Icon(
                                                                  hideConfirmPassword
                                                                      ? Icons
                                                                          .remove_red_eye_outlined
                                                                      : Icons
                                                                          .remove_red_eye,
                                                                  size: 28,
                                                                  color: Colors
                                                                      .grey,
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
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              shape: const StadiumBorder(),
                                              minimumSize: Size.zero,
                                              padding: const EdgeInsets.all(5),
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                            child: const Text(
                                              'Change',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            onPressed: () async {
                                              if (passwordFormKey.currentState!
                                                  .validate()) {
                                                Map<String, dynamic>
                                                    changePasswordInfo =
                                                    await NetworkHandler
                                                        .changePassword(
                                                            MyProfile.id,
                                                            currentTextField
                                                                .text,
                                                            newTextField.text);

                                                Navigator.pop(context);

                                                if (changePasswordInfo[
                                                        'error'] ==
                                                    null) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        SimpleDialog(
                                                      title: const Text(
                                                          'Success!'),
                                                      children: [
                                                        Text(changePasswordInfo[
                                                            'success']),
                                                      ],
                                                    ),
                                                  );
                                                } else {
                                                  Future.delayed(
                                                    Duration.zero,
                                                    () => ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                          content: Text(
                                                              changePasswordInfo[
                                                                  'error'])),
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
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
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
                                    ),
                                  );
                                },
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: const ContinuousRectangleBorder(),
                                  minimumSize: Size.zero,
                                  padding: const EdgeInsets.all(5),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          left: 45, top: 10, bottom: 10),
                                      child: Text(
                                        'Private account',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Switch(
                                          value: privateSwitch,
                                          onChanged: (bool value) async {
                                            Map<String, dynamic> isPrivateInfo =
                                                await NetworkHandler
                                                    .setIsPrivate(
                                                        MyProfile.id, value);

                                            if (isPrivateInfo['error'] ==
                                                null) {
                                              setState(() {});
                                            } else {
                                              Future.delayed(
                                                Duration.zero,
                                                () => ScaffoldMessenger.of(
                                                        context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                          isPrivateInfo[
                                                              'error'])),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () async {
                                  Map<String, dynamic> isPrivateInfo =
                                      await NetworkHandler.setIsPrivate(
                                          MyProfile.id, !MyProfile.isPrivate);

                                  if (isPrivateInfo['error'] == null) {
                                    setState(() {});
                                  } else {
                                    Future.delayed(
                                      Duration.zero,
                                      () => ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content:
                                                Text(isPrivateInfo['error'])),
                                      ),
                                    );
                                  }
                                },
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: const ContinuousRectangleBorder(),
                                  minimumSize: Size.zero,
                                  padding: const EdgeInsets.all(5),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Row(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 45, top: 10, bottom: 10),
                                      child: Text(
                                        'Notification settings',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Icon(
                                            Icons.arrow_right,
                                            size: 40,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => StatefulBuilder(
                                      builder: (context, setState) =>
                                          AlertDialog(
                                        title:
                                            const Text('Notification settings'),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 25),
                                                      child: Text(
                                                        'Receive notifications for:',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            const Text(
                                                              'Follows',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            Switch(
                                                              value:
                                                                  newFollowSwitch,
                                                              onChanged: (bool
                                                                  value) async {
                                                                newFollowSwitch =
                                                                    value;
                                                                setState(() {});
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            const Text(
                                                              'Lars',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            Switch(
                                                              value:
                                                                  newTweetSwitch,
                                                              onChanged: (bool
                                                                  value) async {
                                                                newTweetSwitch =
                                                                    value;
                                                                setState(() {});
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            const Text(
                                                              'Likes',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            Switch(
                                                              value:
                                                                  newLikeSwitch,
                                                              onChanged: (bool
                                                                  value) async {
                                                                newLikeSwitch =
                                                                    value;
                                                                setState(() {});
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
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
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                            child: const Text(
                                              'Change',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            onPressed: () async {
                                              Map<String, dynamic>
                                                  notificationsInfo =
                                                  await NetworkHandler
                                                      .changeNotifications(
                                                          MyProfile.id,
                                                          newFollowSwitch,
                                                          newTweetSwitch,
                                                          newLikeSwitch);

                                              Navigator.pop(context);

                                              if (notificationsInfo['error'] ==
                                                  null) {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      SimpleDialog(
                                                    title:
                                                        const Text('Success!'),
                                                    children: [
                                                      Text(notificationsInfo[
                                                          'success']),
                                                    ],
                                                  ),
                                                );
                                              } else {
                                                Future.delayed(
                                                  Duration.zero,
                                                  () => ScaffoldMessenger.of(
                                                          context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        content: Text(
                                                            notificationsInfo[
                                                                'error'])),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              shape: const StadiumBorder(),
                                              minimumSize: Size.zero,
                                              padding: const EdgeInsets.all(5),
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
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
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.color_lens,
                                size: 36,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 2,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    'Appearance',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Consumer<ThemeNotifier>(
                                builder: (context, theme, _) {
                                  themeSwitch = theme.getTheme();
                                  return OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      shape: const ContinuousRectangleBorder(),
                                      minimumSize: Size.zero,
                                      padding: const EdgeInsets.all(5),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 45, top: 10, bottom: 10),
                                          child: Text(
                                            'Dark mode',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Switch(
                                              value: themeSwitch,
                                              onChanged: (bool value) async {
                                                Map<String, dynamic>
                                                    darkModeInfo =
                                                    await NetworkHandler
                                                        .setDarkMode(
                                                            MyProfile.id,
                                                            value);

                                                if (darkModeInfo['error'] ==
                                                    null) {
                                                  theme.setTheme(value);
                                                  setState(() {});
                                                } else {
                                                  Future.delayed(
                                                    Duration.zero,
                                                    () => ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                          content: Text(
                                                              darkModeInfo[
                                                                  'error'])),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    onPressed: () async {
                                      Map<String, dynamic> darkModeInfo =
                                          await NetworkHandler.setDarkMode(
                                              MyProfile.id, !theme.getTheme());

                                      if (darkModeInfo['error'] == null) {
                                        theme.toggleTheme();
                                        setState(() {});
                                      } else {
                                        Future.delayed(
                                          Duration.zero,
                                          () => ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    darkModeInfo['error'])),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.logout,
                                size: 36,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 2,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: const ContinuousRectangleBorder(),
                                  minimumSize: Size.zero,
                                  padding: const EdgeInsets.all(5),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 10, bottom: 10),
                                      child: Text(
                                        'Logout from this device',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () async {
                                  Map<String, dynamic> logoutInfo =
                                      await NetworkHandler.logout();

                                  if (logoutInfo['error'] == null) {
                                    MyProfile.userToken = '';
                                    MyProfile.adminToken = '';
                                    Navigator.popUntil(context,
                                        ModalRoute.withName('/Welcome'));
                                  } else {
                                    Future.delayed(
                                      Duration.zero,
                                      () => ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(logoutInfo['error'])),
                                      ),
                                    );
                                  }
                                },
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: const ContinuousRectangleBorder(),
                                  minimumSize: Size.zero,
                                  padding: const EdgeInsets.all(5),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 10, bottom: 10),
                                      child: Text(
                                        'Logout from all devices',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () async {
                                  Map<String, dynamic> logoutAllInfo =
                                      await NetworkHandler.logoutAll();

                                  if (logoutAllInfo['error'] == null) {
                                    MyProfile.userToken = '';
                                    MyProfile.adminToken = '';
                                    Navigator.popUntil(context,
                                        ModalRoute.withName('/Welcome'));
                                  } else {
                                    Future.delayed(
                                      Duration.zero,
                                      () => ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content:
                                                Text(logoutAllInfo['error'])),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              Future.delayed(
                Duration.zero,
                () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Error: Couldn\'t load profile info')),
                ),
              );

              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
