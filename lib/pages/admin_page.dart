import 'package:flutter/material.dart';

import '../UserProfile.dart';

class Admin_Page extends StatefulWidget {
  const Admin_Page({Key? key}) : super(key: key);

  @override
  State<Admin_Page> createState() => _Admin_PageState();
}

class _Admin_PageState extends State<Admin_Page> {
  @override
  Widget build(BuildContext context) {
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
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/Profile', ModalRoute.withName('/Welcome'),
                          arguments: {'profileID': MyProfile.id});
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                            foregroundImage: (MyProfile.avatarURL.isNotEmpty)
                                ? NetworkImage(MyProfile.avatarURL)
                                : null,
                            backgroundImage:
                                const AssetImage('assets/myavatar.png'),
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
                    backgroundColor:
                        (ModalRoute.of(context)!.settings.name == ('/Home') ||
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
                    if (ModalRoute.of(context)!.settings.name != ('/Home')) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/Home', ModalRoute.withName('/Welcome'));
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
                        (ModalRoute.of(context)!.settings.name == ('/Profile'))
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
                    if (ModalRoute.of(context)!.settings.name != ('/Profile')) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/Profile', ModalRoute.withName('/Welcome'),
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
                        (ModalRoute.of(context)!.settings.name == ('/Settings'))
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
                      Navigator.pushNamedAndRemoveUntil(context, '/Settings',
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
                          (ModalRoute.of(context)!.settings.name == ('/Admin'))
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
                          padding: EdgeInsets.symmetric(horizontal: 10),
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
                      if (ModalRoute.of(context)!.settings.name != ('/Admin')) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/Admin', ModalRoute.withName('/Welcome'));
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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Container(),
          ),
        ),
      ),
    );
  }
}
