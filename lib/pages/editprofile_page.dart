import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../NetworkHandler.dart';
import '../UserProfile.dart';

class EditProfile_Page extends StatefulWidget {
  const EditProfile_Page({Key? key}) : super(key: key);

  @override
  State<EditProfile_Page> createState() => _EditProfile_PageState();
}

class _EditProfile_PageState extends State<EditProfile_Page> {
  bool dataLoaded = false;

  final ImagePicker iamgePicker = ImagePicker();

  final GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  final TextEditingController tagTextField = TextEditingController();
  final TextEditingController usernameTextField = TextEditingController();
  final TextEditingController emailTextField = TextEditingController();
  final TextEditingController birthdateTextField = TextEditingController();
  bool birthdateVisibility = true;
  final TextEditingController locationTextField = TextEditingController();
  bool locationVisibility = true;
  final TextEditingController phoneTextField = TextEditingController();
  final TextEditingController websiteTextField = TextEditingController();
  final TextEditingController biographyTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: MyProfile.updateProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data! == true) {
              if (!dataLoaded) {
                tagTextField.text = MyProfile.tag;
                usernameTextField.text = MyProfile.screenName;
                emailTextField.text = MyProfile.email;
                birthdateTextField.text = DateFormat('EEE, MMMM d, yyyy')
                    .format(MyProfile.birthdate.toLocal());
                birthdateVisibility = MyProfile.birthdateVisibility;
                locationTextField.text = MyProfile.location;
                locationVisibility = MyProfile.locationVisibility;
                phoneTextField.text = MyProfile.phoneNumber;
                websiteTextField.text = MyProfile.website;
                biographyTextField.text = MyProfile.biography;
                dataLoaded = true;
              }
              return Scaffold(
                resizeToAvoidBottomInset: true,
                appBar: AppBar(
                  automaticallyImplyLeading: true,
                  centerTitle: true,
                  title: const Text(
                    'Edit Profile',
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
                        key: editFormKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 300,
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Container(
                                      height: 200,
                                      color: Colors.grey,
                                      child: Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              if (MyProfile
                                                  .bannerURL.isNotEmpty) ...[
                                                Image(
                                                  image: NetworkImage(
                                                      MyProfile.bannerURL),
                                                  fit: BoxFit.contain,
                                                )
                                              ] else ...[
                                                const Image(
                                                  image: AssetImage(
                                                      'assets/logo.png'),
                                                  fit: BoxFit.contain,
                                                ),
                                              ]
                                            ],
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: OutlinedButton(
                                              onPressed: () async {
                                                final XFile? image =
                                                    await iamgePicker.pickImage(
                                                        source: ImageSource
                                                            .gallery);

                                                if (image != null) {
                                                  if (image.path
                                                              .split('.')
                                                              .last
                                                              .toLowerCase() ==
                                                          'jpg' ||
                                                      image.path
                                                              .split('.')
                                                              .last
                                                              .toLowerCase() ==
                                                          'jpeg' ||
                                                      image.path
                                                              .split('.')
                                                              .last
                                                              .toLowerCase() ==
                                                          'png' ||
                                                      image.path
                                                              .split('.')
                                                              .last
                                                              .toLowerCase() ==
                                                          'gif') {
                                                    if ((await image.length()) /
                                                            1048576 <
                                                        1) {
                                                      Map<String, dynamic>
                                                          editInfo =
                                                          await NetworkHandler
                                                              .editBanner(
                                                                  MyProfile.id,
                                                                  File(image
                                                                      .path));

                                                      if (editInfo['error'] ==
                                                          null) {
                                                      } else {
                                                        Future.delayed(
                                                          Duration.zero,
                                                          () => ScaffoldMessenger
                                                                  .of(context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                                content: Text(
                                                                    editInfo[
                                                                        'error'])),
                                                          ),
                                                        );
                                                      }
                                                      setState(() {});
                                                    } else {
                                                      Future.delayed(
                                                        Duration.zero,
                                                        () => ScaffoldMessenger
                                                                .of(context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                              content: Text(
                                                                  'Failed to add file ' +
                                                                      image
                                                                          .name +
                                                                      ': Size is bigger than 1mb limit')),
                                                        ),
                                                      );
                                                    }
                                                  } else {
                                                    Future.delayed(
                                                      Duration.zero,
                                                      () =>
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                        SnackBar(
                                                            content: Text(
                                                                'Failed to add file ' +
                                                                    image.name +
                                                                    ': Not a supported extension')),
                                                      ),
                                                    );
                                                  }
                                                }
                                              },
                                              style: OutlinedButton.styleFrom(
                                                shape: const CircleBorder(),
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                        .withOpacity(0.8),
                                                minimumSize: Size.zero,
                                                padding:
                                                    const EdgeInsets.all(5),
                                                tapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                              ),
                                              child: Icon(
                                                Icons.edit,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: OutlinedButton(
                                              onPressed: () async {
                                                Map<String, dynamic> editInfo =
                                                    await NetworkHandler
                                                        .removeBanner(
                                                  MyProfile.id,
                                                );

                                                if (editInfo['error'] == null) {
                                                } else {
                                                  Future.delayed(
                                                    Duration.zero,
                                                    () => ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                          content: Text(
                                                              editInfo[
                                                                  'error'])),
                                                    ),
                                                  );
                                                }
                                                setState(() {});
                                              },
                                              style: OutlinedButton.styleFrom(
                                                shape: const CircleBorder(),
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                        .withOpacity(0.8),
                                                minimumSize: Size.zero,
                                                padding:
                                                    const EdgeInsets.all(5),
                                                tapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                              ),
                                              child: const Icon(
                                                Icons.clear,
                                                color: Colors.red,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 40,
                                      child: Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          CircleAvatar(
                                              foregroundImage: (MyProfile
                                                      .avatarURL.isNotEmpty)
                                                  ? NetworkImage(
                                                      MyProfile.avatarURL)
                                                  : null,
                                              backgroundImage: const AssetImage(
                                                  'assets/myavatar.png'),
                                              radius: 60),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: OutlinedButton(
                                              onPressed: () async {
                                                final XFile? image =
                                                    await iamgePicker.pickImage(
                                                        source: ImageSource
                                                            .gallery);

                                                if (image != null) {
                                                  if (image.path
                                                              .split('.')
                                                              .last
                                                              .toLowerCase() ==
                                                          'jpg' ||
                                                      image.path
                                                              .split('.')
                                                              .last
                                                              .toLowerCase() ==
                                                          'jpeg' ||
                                                      image.path
                                                              .split('.')
                                                              .last
                                                              .toLowerCase() ==
                                                          'png' ||
                                                      image.path
                                                              .split('.')
                                                              .last
                                                              .toLowerCase() ==
                                                          'gif') {
                                                    if ((await image.length()) /
                                                            1048576 <
                                                        1) {
                                                      Map<String, dynamic>
                                                          editInfo =
                                                          await NetworkHandler
                                                              .editAvatar(
                                                                  MyProfile.id,
                                                                  File(image
                                                                      .path));

                                                      if (editInfo['error'] ==
                                                          null) {
                                                      } else {
                                                        Future.delayed(
                                                          Duration.zero,
                                                          () => ScaffoldMessenger
                                                                  .of(context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                                content: Text(
                                                                    editInfo[
                                                                        'error'])),
                                                          ),
                                                        );
                                                      }
                                                      setState(() {});
                                                    } else {
                                                      Future.delayed(
                                                        Duration.zero,
                                                        () => ScaffoldMessenger
                                                                .of(context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                              content: Text(
                                                                  'Failed to add file ' +
                                                                      image
                                                                          .name +
                                                                      ': Size is bigger than 1mb limit')),
                                                        ),
                                                      );
                                                    }
                                                  } else {
                                                    Future.delayed(
                                                      Duration.zero,
                                                      () =>
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                        SnackBar(
                                                            content: Text(
                                                                'Failed to add file ' +
                                                                    image.name +
                                                                    ': Not a supported extension')),
                                                      ),
                                                    );
                                                  }
                                                }
                                              },
                                              style: OutlinedButton.styleFrom(
                                                shape: const CircleBorder(),
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                        .withOpacity(0.8),
                                                minimumSize: Size.zero,
                                                padding:
                                                    const EdgeInsets.all(5),
                                                tapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                              ),
                                              child: Icon(
                                                Icons.edit,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: OutlinedButton(
                                              onPressed: () async {
                                                Map<String, dynamic> editInfo =
                                                    await NetworkHandler
                                                        .removeAvatar(
                                                            MyProfile.id);

                                                if (editInfo['error'] == null) {
                                                } else {
                                                  Future.delayed(
                                                    Duration.zero,
                                                    () => ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                          content: Text(
                                                              editInfo[
                                                                  'error'])),
                                                    ),
                                                  );
                                                }
                                                setState(() {});
                                              },
                                              style: OutlinedButton.styleFrom(
                                                shape: const CircleBorder(),
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                        .withOpacity(0.8),
                                                minimumSize: Size.zero,
                                                padding:
                                                    const EdgeInsets.all(5),
                                                tapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                              ),
                                              child: const Icon(
                                                Icons.clear,
                                                color: Colors.red,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  controller: tagTextField,
                                  readOnly: true,
                                  maxLength: 16,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto,
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
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
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto,
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
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 30),
                                child: TextFormField(
                                  controller: emailTextField,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto,
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
                                padding: const EdgeInsets.only(top: 10),
                                child: TextFormField(
                                  controller: birthdateTextField,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto,
                                    labelText: 'Birthdate',
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
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        'Show birth date',
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Switch(
                                          value: birthdateVisibility,
                                          onChanged: (bool value) async {
                                            birthdateVisibility = value;
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                ),
                                child: TextFormField(
                                  controller: locationTextField,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto,
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
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        'Show location',
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Switch(
                                          value: locationVisibility,
                                          onChanged: (bool value) async {
                                            locationVisibility = value;
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 30),
                                child: TextFormField(
                                  controller: phoneTextField,
                                  validator: (value) {
                                    if (!RegExp(r'^\d*$')
                                        .hasMatch(value ?? '')) {
                                      return 'Phone Number can only contain digits';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto,
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
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 30),
                                child: TextFormField(
                                  controller: websiteTextField,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto,
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  controller: biographyTextField,
                                  maxLength: 140,
                                  maxLines: null,
                                  minLines: null,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto,
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
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: OutlinedButton(
                                  onPressed: () async {
                                    if (editFormKey.currentState!.validate()) {
                                      Map<String, dynamic> editInfo =
                                          await NetworkHandler.editProfile(
                                              MyProfile.id,
                                              usernameTextField.text,
                                              phoneTextField.text,
                                              websiteTextField.text,
                                              biographyTextField.text);

                                      if (editInfo['error'] == null) {
                                        editInfo =
                                            await NetworkHandler.setBirthdate(
                                          MyProfile.id,
                                          birthdateVisibility,
                                        );

                                        if (editInfo['error'] == null) {
                                          editInfo =
                                              await NetworkHandler.setLocation(
                                            MyProfile.id,
                                            locationTextField.text,
                                            locationVisibility,
                                          );

                                          if (editInfo['error'] == null) {
                                            Navigator.pop(context);
                                          } else {
                                            Future.delayed(
                                              Duration.zero,
                                              () =>
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        editInfo['error'])),
                                              ),
                                            );
                                          }
                                        } else {
                                          Future.delayed(
                                            Duration.zero,
                                            () => ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content:
                                                      Text(editInfo['error'])),
                                            ),
                                          );
                                        }
                                      } else {
                                        Future.delayed(
                                          Duration.zero,
                                          () => ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content:
                                                    Text(editInfo['error'])),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  style: OutlinedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    minimumSize: Size.zero,
                                    fixedSize: const Size(220, 60),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: const Text(
                                    'Save',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
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
