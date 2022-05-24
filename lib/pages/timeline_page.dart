import 'package:flutter/material.dart';

import '../NetworkHandler.dart';
import '../UserProfile.dart';
import '../Tweet.dart';

class Timeline_Page extends StatefulWidget {
  const Timeline_Page({Key? key}) : super(key: key);

  @override
  State<Timeline_Page> createState() => _Timeline_PageState();
}

class _Timeline_PageState extends State<Timeline_Page> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: MyProfile.updateProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data! == true) {
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
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: NetworkHandler.getTimeline(),
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
                                      Tweet(
                                        id: snapshot.data![index]['id'],
                                        ownerid: snapshot.data![index]
                                            ['ownerid'],
                                        avatarURL: snapshot.data![index]
                                            ['avatarURL'],
                                        tag: snapshot.data![index]['tag'],
                                        name: snapshot.data![index]['name'],
                                        text: snapshot.data![index]['text'],
                                        postdate: snapshot.data![index]
                                            ['postdate'],
                                        replycount: snapshot.data![index]
                                            ['replycount'],
                                        retweetcount: snapshot.data![index]
                                            ['retweetcount'],
                                        likecount: snapshot.data![index]
                                            ['likecount'],
                                        liked: snapshot.data![index]['liked'],
                                        view: TweetView.focused,
                                        tags: snapshot.data![index]['tags'],
                                        images: snapshot.data![index]['images'],
                                        embeddedtweet: snapshot.data![index]
                                            ['embeddedtweet'],
                                        embeddedtweetdeleted:
                                            snapshot.data![index]
                                                ['embeddedtweetdeleted'],
                                        replies: snapshot.data![index]
                                            ['replies'],
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 100),
                                        child: Divider(thickness: 2),
                                      )
                                    ],
                                  );
                                },
                              );
                            } else {
                              Future.delayed(
                                Duration.zero,
                                () =>
                                    ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text(snapshot.data![0]['error'])),
                                ),
                              );
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          } else {
                            return const Center(
                              child: Text(
                                'No lars in your timeline.\n\nConsider following people to see their lars here.',
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
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/Post',
                            arguments: {'retweetID': ''})
                        .then((value) => setState(() {}));
                  },
                  child: const Icon(
                    Icons.add,
                    size: 20,
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
                                (ModalRoute.of(context)!.settings.name ==
                                        ('/Home'))
                                    ? Colors.grey
                                    : null,
                          ),
                          child: const Icon(
                            Icons.view_stream,
                            size: 40,
                          ),
                          onPressed: () {
                            if (ModalRoute.of(context)!.settings.name ==
                                ('/Home')) {
                              setState(() {});
                            } else {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  '/Home', ModalRoute.withName('/Welcome'));
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
                                (ModalRoute.of(context)!.settings.name ==
                                        ('/Explore'))
                                    ? Colors.grey
                                    : null,
                          ),
                          child: const Icon(
                            Icons.travel_explore,
                            size: 40,
                          ),
                          onPressed: () {
                            if (ModalRoute.of(context)!.settings.name ==
                                ('/Explore')) {
                              setState(() {});
                            } else {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  '/Explore', ModalRoute.withName('/Welcome'));
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
                                (ModalRoute.of(context)!.settings.name ==
                                        ('/Search'))
                                    ? Colors.grey
                                    : null,
                          ),
                          child: const Icon(
                            Icons.search,
                            size: 40,
                          ),
                          onPressed: () {
                            if (ModalRoute.of(context)!.settings.name ==
                                ('/Search')) {
                              setState(() {});
                            } else {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  '/Search', ModalRoute.withName('/Welcome'));
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
                                (ModalRoute.of(context)!.settings.name ==
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
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/Notifications',
                                  ModalRoute.withName('/Welcome'));
                            }
                          },
                        ),
                      ),
                    ],
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
