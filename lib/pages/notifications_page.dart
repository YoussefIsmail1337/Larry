import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../NetworkHandler.dart';
import '../UserProfile.dart';

class Notifications_Page extends StatefulWidget {
  const Notifications_Page({Key? key}) : super(key: key);

  @override
  State<Notifications_Page> createState() => _Notifications_PageState();
}

class _Notifications_PageState extends State<Notifications_Page> {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: NetworkHandler.getNotifications(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isNotEmpty) {
                  if (snapshot.data![0]['error'] == null) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: OutlinedButton(
                                onPressed: () async {
                                  Map<String, dynamic> deleteInfo =
                                      await NetworkHandler.deleteNotification(
                                          snapshot.data![index]['id']);

                                  if (deleteInfo['error'] == null) {
                                    setState(() {});
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(deleteInfo['error'])),
                                    );
                                  }
                                },
                                style: OutlinedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  minimumSize: Size.zero,
                                  padding: const EdgeInsets.all(5),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 175,
                                  height: 100,
                                  child: TextButton(
                                    onPressed: () {
                                      if (snapshot.data![index]['ownerid'] ==
                                          MyProfile.id) {
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            '/Profile',
                                            ModalRoute.withName('/Welcome'),
                                            arguments: {
                                              'profileID': MyProfile.id
                                            });
                                      } else {
                                        Navigator.pushNamed(context, '/Profile',
                                            arguments: {
                                              'profileID': snapshot.data![index]
                                                  ['ownerid']
                                            }).then((value) => setState(() {}));
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          foregroundImage: (snapshot
                                                  .data![index]['avatarURL']
                                                  .isNotEmpty)
                                              ? NetworkImage(snapshot
                                                  .data![index]['avatarURL'])
                                              : null,
                                          backgroundImage:
                                              (snapshot.data![index]
                                                          ['ownerid'] ==
                                                      MyProfile.id)
                                                  ? const AssetImage(
                                                      'assets/myavatar.png')
                                                  : const AssetImage(
                                                      'assets/otheravatar.png'),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Column(
                                            children: [
                                              Text(
                                                snapshot.data![index]['name'],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                '@' +
                                                    snapshot.data![index]
                                                        ['tag'],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
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
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: Text(
                                          snapshot.data![index]['text'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              DateFormat(
                                                      'EEE, MMMM d, yyyy\nhh:mm aaa \'${snapshot.data![index]['receiveddate'].toLocal().timeZoneName}\'')
                                                  .format(snapshot.data![index]
                                                          ['receiveddate']
                                                      .toLocal()),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 100),
                              child: Divider(thickness: 2),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    Future.delayed(
                      Duration.zero,
                      () => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(snapshot.data![0]['error'])),
                      ),
                    );
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                } else {
                  return const Center(
                    child: Text(
                      'You have not received any notifications yet.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: const ContinuousRectangleBorder(),
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.all(5),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  backgroundColor:
                      (ModalRoute.of(context)!.settings.name == ('/Home'))
                          ? Colors.grey
                          : null,
                ),
                child: const Icon(
                  Icons.view_stream,
                  size: 40,
                ),
                onPressed: () {
                  if (ModalRoute.of(context)!.settings.name == ('/Home')) {
                    setState(() {});
                  } else {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/Home', ModalRoute.withName('/Welcome'));
                  }
                },
              ),
            ),
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: const ContinuousRectangleBorder(),
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.all(5),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  backgroundColor:
                      (ModalRoute.of(context)!.settings.name == ('/Explore'))
                          ? Colors.grey
                          : null,
                ),
                child: const Icon(
                  Icons.travel_explore,
                  size: 40,
                ),
                onPressed: () {
                  if (ModalRoute.of(context)!.settings.name == ('/Explore')) {
                    setState(() {});
                  } else {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/Explore', ModalRoute.withName('/Welcome'));
                  }
                },
              ),
            ),
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: const ContinuousRectangleBorder(),
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.all(5),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  backgroundColor:
                      (ModalRoute.of(context)!.settings.name == ('/Search'))
                          ? Colors.grey
                          : null,
                ),
                child: const Icon(
                  Icons.search,
                  size: 40,
                ),
                onPressed: () {
                  if (ModalRoute.of(context)!.settings.name == ('/Search')) {
                    setState(() {});
                  } else {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/Search', ModalRoute.withName('/Welcome'));
                  }
                },
              ),
            ),
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: const ContinuousRectangleBorder(),
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.all(5),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  backgroundColor: (ModalRoute.of(context)!.settings.name ==
                          ('/Notifications'))
                      ? Colors.grey
                      : null,
                ),
                child: const Icon(
                  Icons.notifications,
                  size: 40,
                ),
                onPressed: () {
                  if (ModalRoute.of(context)!.settings.name ==
                      ('/Notifications')) {
                    setState(() {});
                  } else {
                    Navigator.pushNamedAndRemoveUntil(context, '/Notifications',
                        ModalRoute.withName('/Welcome'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
