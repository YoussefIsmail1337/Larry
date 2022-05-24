import 'package:flutter/material.dart';

import '../NetworkHandler.dart';
import '../UserProfile.dart';
import '../Tweet.dart';

class Search_Page extends StatefulWidget {
  const Search_Page({Key? key}) : super(key: key);

  @override
  State<Search_Page> createState() => _Search_PageState();
}

class _Search_PageState extends State<Search_Page> {
  final TextEditingController searchTextField = TextEditingController();
  String searchType = 'Tweet';
  bool followersOnly = false;
  bool searched = true;

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
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        pinned: true,
                        centerTitle: true,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        toolbarHeight: 100,
                        title: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            controller: searchTextField,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              labelText: 'Search',
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(start: 5),
                                child: TextButton(
                                  onPressed: () {
                                    if (searchTextField.text.isNotEmpty) {
                                      searched = false;
                                    } else {
                                      Future.delayed(
                                        Duration.zero,
                                        () => ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Error: Search field is empty')),
                                        ),
                                      );
                                    }
                                    setState(() {});
                                  },
                                  style: TextButton.styleFrom(
                                    shape: const CircleBorder(),
                                    minimumSize: Size.zero,
                                    padding: const EdgeInsets.all(5),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: const Icon(
                                    Icons.search,
                                    size: 28,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              suffixIcon: Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        followersOnly = !followersOnly;
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
                                        (followersOnly == true)
                                            ? Icons.group
                                            : Icons.group_off,
                                        size: 28,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        searchType = (searchType == 'Tweets')
                                            ? 'Users'
                                            : 'Tweets';
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
                                        (searchType == 'Tweets')
                                            ? Icons.manage_search
                                            : Icons.person_search,
                                        size: 28,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        sliver: (searched == false)
                            ? (searchType == 'Tweets')
                                ? FutureBuilder<List<Map<String, dynamic>>>(
                                    future: NetworkHandler.searchTweets(
                                        searchTextField.text, followersOnly),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data!.isNotEmpty) {
                                          if (snapshot.data![0]['error'] ==
                                              null) {
                                            searched = true;
                                            return SliverList(
                                              delegate:
                                                  SliverChildBuilderDelegate(
                                                (context, index) {
                                                  return Column(
                                                    children: [
                                                      Tweet(
                                                        id: snapshot
                                                            .data![index]['id'],
                                                        ownerid: snapshot
                                                                .data![index]
                                                            ['ownerid'],
                                                        avatarURL: snapshot
                                                                .data![index]
                                                            ['avatarURL'],
                                                        tag: snapshot
                                                                .data![index]
                                                            ['tag'],
                                                        name: snapshot
                                                                .data![index]
                                                            ['name'],
                                                        text: snapshot
                                                                .data![index]
                                                            ['text'],
                                                        postdate: snapshot
                                                                .data![index]
                                                            ['postdate'],
                                                        replycount: snapshot
                                                                .data![index]
                                                            ['replycount'],
                                                        retweetcount: snapshot
                                                                .data![index]
                                                            ['retweetcount'],
                                                        likecount: snapshot
                                                                .data![index]
                                                            ['likecount'],
                                                        liked: snapshot
                                                                .data![index]
                                                            ['liked'],
                                                        view: TweetView.full,
                                                        tags: snapshot
                                                                .data![index]
                                                            ['tags'],
                                                        images: snapshot
                                                                .data![index]
                                                            ['images'],
                                                        embeddedtweet: snapshot
                                                                .data![index]
                                                            ['embeddedtweet'],
                                                        embeddedtweetdeleted:
                                                            snapshot.data![
                                                                    index][
                                                                'embeddedtweetdeleted'],
                                                        replies: snapshot
                                                                .data![index]
                                                            ['replies'],
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    100),
                                                        child: Divider(
                                                            thickness: 2),
                                                      )
                                                    ],
                                                  );
                                                },
                                                childCount:
                                                    snapshot.data!.length,
                                              ),
                                            );
                                          } else {
                                            Future.delayed(
                                              Duration.zero,
                                              () =>
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                SnackBar(
                                                    content: Text(snapshot
                                                        .data![0]['error'])),
                                              ),
                                            );
                                            return SliverList(
                                              delegate:
                                                  SliverChildListDelegate([
                                                const Center(
                                                    child:
                                                        CircularProgressIndicator())
                                              ]),
                                            );
                                          }
                                        } else {
                                          return SliverList(
                                            delegate: SliverChildListDelegate([
                                              const Center(
                                                child: Text(
                                                  'No lars found.',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          );
                                        }
                                      } else {
                                        return SliverList(
                                          delegate: SliverChildListDelegate([
                                            const Center(
                                                child:
                                                    CircularProgressIndicator())
                                          ]),
                                        );
                                      }
                                    },
                                  )
                                : FutureBuilder<List<Map<String, dynamic>>>(
                                    future: NetworkHandler.searchUsers(
                                        searchTextField.text, followersOnly),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data!.isNotEmpty) {
                                          if (snapshot.data![0]['error'] ==
                                              null) {
                                            searched = true;
                                            return SliverList(
                                              delegate:
                                                  SliverChildBuilderDelegate(
                                                (context, index) {
                                                  return Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Flexible(
                                                            child: TextButton(
                                                              onPressed: () {
                                                                if (snapshot.data![
                                                                            index]
                                                                        [
                                                                        'id'] ==
                                                                    MyProfile
                                                                        .id) {
                                                                  Navigator.pushNamedAndRemoveUntil(
                                                                      context,
                                                                      '/Profile',
                                                                      ModalRoute.withName('/Welcome'),
                                                                      arguments: {
                                                                        'profileID':
                                                                            MyProfile.id
                                                                      });
                                                                } else {
                                                                  Navigator.pushNamed(
                                                                      context,
                                                                      '/Profile',
                                                                      arguments: {
                                                                        'profileID':
                                                                            snapshot.data![index]['id']
                                                                      }).then(
                                                                      (value) =>
                                                                          setState(
                                                                              () {}));
                                                                }
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  CircleAvatar(
                                                                    foregroundImage: (snapshot
                                                                            .data![index][
                                                                                'avatarURL']
                                                                            .isNotEmpty)
                                                                        ? NetworkImage(snapshot.data![index]
                                                                            [
                                                                            'avatarURL'])
                                                                        : null,
                                                                    backgroundImage: (snapshot.data![index]['id'] ==
                                                                            MyProfile
                                                                                .id)
                                                                        ? const AssetImage(
                                                                            'assets/myavatar.png')
                                                                        : const AssetImage(
                                                                            'assets/otheravatar.png'),
                                                                    radius: 40,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          snapshot.data![index]
                                                                              [
                                                                              'screenName'],
                                                                          style:
                                                                              const TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                24,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          '@' +
                                                                              snapshot.data![index]['tag'],
                                                                          style:
                                                                              const TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                16,
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    100),
                                                        child: Divider(
                                                            thickness: 2),
                                                      ),
                                                    ],
                                                  );
                                                },
                                                childCount:
                                                    snapshot.data!.length,
                                              ),
                                            );
                                          } else {
                                            Future.delayed(
                                              Duration.zero,
                                              () =>
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                SnackBar(
                                                    content: Text(snapshot
                                                        .data![0]['error'])),
                                              ),
                                            );
                                            return SliverList(
                                              delegate:
                                                  SliverChildListDelegate([
                                                const Center(
                                                    child:
                                                        CircularProgressIndicator())
                                              ]),
                                            );
                                          }
                                        } else {
                                          return SliverList(
                                            delegate: SliverChildListDelegate([
                                              const Center(
                                                child: Text(
                                                  'No users found.',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          );
                                        }
                                      } else {
                                        return SliverList(
                                          delegate: SliverChildListDelegate([
                                            const Center(
                                                child:
                                                    CircularProgressIndicator())
                                          ]),
                                        );
                                      }
                                    },
                                  )
                            : null,
                      ),
                    ],
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
