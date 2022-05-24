import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../NetworkHandler.dart';
import '../UserProfile.dart';
import '../Tweet.dart';

enum ProfileView {
  tweets,
  likes,
  media,
}

class Profile_Page extends StatefulWidget {
  const Profile_Page({Key? key}) : super(key: key);

  @override
  State<Profile_Page> createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {
  ProfileView profileView = ProfileView.tweets;
  Duration banDuration = Duration.zero;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> profileMethod =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final TextEditingController reportTextField = TextEditingController();
    final UserProfile? userProfile =
        (profileMethod['profileID'] == MyProfile.id)
            ? null
            : UserProfile(id: profileMethod['profileID']);

    return FutureBuilder<bool>(
        future: (userProfile != null)
            ? userProfile.updateProfile()
            : MyProfile.updateProfile(),
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
                drawer: (userProfile != null)
                    ? null
                    : Drawer(
                        child: SafeArea(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 25),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          '/Profile',
                                          ModalRoute.withName('/Welcome'),
                                          arguments: {
                                            'profileID': MyProfile.id
                                          });
                                    },
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                            foregroundImage:
                                                (MyProfile.avatarURL.isNotEmpty)
                                                    ? NetworkImage(
                                                        MyProfile.avatarURL)
                                                    : null,
                                            backgroundImage: const AssetImage(
                                                'assets/myavatar.png'),
                                            radius: 60),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
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
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    backgroundColor: (ModalRoute.of(context)!
                                                    .settings
                                                    .name ==
                                                ('/Home') ||
                                            ModalRoute.of(context)!
                                                    .settings
                                                    .name ==
                                                ('/Explore') ||
                                            ModalRoute.of(context)!
                                                    .settings
                                                    .name ==
                                                ('/Search') ||
                                            ModalRoute.of(context)!
                                                    .settings
                                                    .name ==
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
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
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          '/Home',
                                          ModalRoute.withName('/Welcome'));
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
                                    backgroundColor: (ModalRoute.of(context)!
                                                .settings
                                                .name ==
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
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
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          '/Profile',
                                          ModalRoute.withName('/Welcome'),
                                          arguments: {
                                            'profileID': MyProfile.id
                                          });
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
                                    backgroundColor: (ModalRoute.of(context)!
                                                .settings
                                                .name ==
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
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
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      backgroundColor: (ModalRoute.of(context)!
                                                  .settings
                                                  .name ==
                                              ('/Admin'))
                                          ? Colors.grey
                                          : null,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: const [
                                        Icon(
                                          Icons.admin_panel_settings,
                                          size: 40,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
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
                                      if (ModalRoute.of(context)!
                                              .settings
                                              .name !=
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
                        backgroundColor: Colors.grey,
                        toolbarHeight: 200,
                        flexibleSpace: FlexibleSpaceBar(
                          background: (userProfile != null)
                              ? (userProfile.bannerURL.isNotEmpty)
                                  ? Image(
                                      image:
                                          NetworkImage(userProfile.bannerURL),
                                      fit: BoxFit.contain,
                                    )
                                  : const Image(
                                      image: AssetImage('assets/logo.png'),
                                      fit: BoxFit.contain,
                                    )
                              : (MyProfile.bannerURL.isNotEmpty)
                                  ? Image(
                                      image: NetworkImage(MyProfile.bannerURL),
                                      fit: BoxFit.contain,
                                    )
                                  : const Image(
                                      image: AssetImage('assets/logo.png'),
                                      fit: BoxFit.contain,
                                    ),
                        ),
                      ),
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        pinned: true,
                        centerTitle: true,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        toolbarHeight: 100,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => SimpleDialog(
                                        title: const Text('Profile'),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CircleAvatar(
                                                        foregroundImage: (userProfile !=
                                                                null)
                                                            ? (userProfile
                                                                    .avatarURL
                                                                    .isNotEmpty)
                                                                ? NetworkImage(
                                                                    userProfile
                                                                        .avatarURL)
                                                                : null
                                                            : (MyProfile
                                                                    .avatarURL
                                                                    .isNotEmpty)
                                                                ? NetworkImage(
                                                                    MyProfile
                                                                        .avatarURL)
                                                                : null,
                                                        backgroundImage: (userProfile !=
                                                                null)
                                                            ? const AssetImage(
                                                                'assets/otheravatar.png')
                                                            : const AssetImage(
                                                                'assets/myavatar.png'),
                                                        radius: 30,
                                                      ),
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                ((userProfile !=
                                                                        null)
                                                                    ? userProfile
                                                                        .screenName
                                                                    : MyProfile
                                                                        .screenName),
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 30,
                                                                ),
                                                              ),
                                                              Text(
                                                                '@' +
                                                                    ((userProfile !=
                                                                            null)
                                                                        ? userProfile
                                                                            .tag
                                                                        : MyProfile
                                                                            .tag),
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            10),
                                                                child: Text(
                                                                  (userProfile != null)
                                                                      ? userProfile
                                                                          .biography
                                                                      : MyProfile
                                                                          .biography,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            10),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        const Icon(
                                                                          Icons
                                                                              .phone,
                                                                          size:
                                                                              16,
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(left: 2),
                                                                          child:
                                                                              Text(
                                                                            (userProfile != null)
                                                                                ? userProfile.phoneNumber
                                                                                : MyProfile.phoneNumber,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontWeight: FontWeight.normal,
                                                                              fontSize: 10,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        const Icon(
                                                                          Icons
                                                                              .link,
                                                                          size:
                                                                              16,
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(left: 2),
                                                                          child:
                                                                              Text(
                                                                            (userProfile != null)
                                                                                ? userProfile.website
                                                                                : MyProfile.website,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontWeight: FontWeight.normal,
                                                                              fontSize: 10,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            10),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    if ((userProfile !=
                                                                            null)
                                                                        ? userProfile
                                                                            .birthdateVisibility
                                                                        : MyProfile
                                                                            .birthdateVisibility) ...[
                                                                      Row(
                                                                        children: [
                                                                          const Icon(
                                                                            Icons.calendar_month,
                                                                            size:
                                                                                16,
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 2),
                                                                            child:
                                                                                Text(
                                                                              DateFormat('EEE, MMMM d, yyyy').format(((userProfile != null) ? userProfile.birthdate : MyProfile.birthdate).toLocal()),
                                                                              style: const TextStyle(
                                                                                fontWeight: FontWeight.normal,
                                                                                fontSize: 10,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                    if ((userProfile !=
                                                                            null)
                                                                        ? userProfile
                                                                            .locationVisibility
                                                                        : MyProfile
                                                                            .locationVisibility) ...[
                                                                      Row(
                                                                        children: [
                                                                          const Icon(
                                                                            Icons.location_city,
                                                                            size:
                                                                                16,
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 2),
                                                                            child:
                                                                                Text(
                                                                              (userProfile != null) ? userProfile.location : MyProfile.location,
                                                                              style: const TextStyle(
                                                                                fontWeight: FontWeight.normal,
                                                                                fontSize: 10,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircleAvatar(
                                        foregroundImage: (userProfile != null)
                                            ? (userProfile.avatarURL.isNotEmpty)
                                                ? NetworkImage(
                                                    userProfile.avatarURL)
                                                : null
                                            : (MyProfile.avatarURL.isNotEmpty)
                                                ? NetworkImage(
                                                    MyProfile.avatarURL)
                                                : null,
                                        backgroundImage: (userProfile != null)
                                            ? const AssetImage(
                                                'assets/otheravatar.png')
                                            : const AssetImage(
                                                'assets/myavatar.png'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              ((userProfile != null)
                                                  ? userProfile.screenName
                                                  : MyProfile.screenName),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              '@' +
                                                  ((userProfile != null)
                                                      ? userProfile.tag
                                                      : MyProfile.tag),
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
                                if (userProfile != null) ...[
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        OutlinedButton(
                                          onPressed: () async {
                                            Map<String, dynamic> followInfo =
                                                await NetworkHandler.followUser(
                                                    MyProfile.id,
                                                    userProfile.id,
                                                    (userProfile.isPrivate)
                                                        ? (userProfile
                                                                .followed ||
                                                            userProfile
                                                                .followPending)
                                                        : (userProfile
                                                            .followed));

                                            if (followInfo['error'] == null) {
                                              if ((userProfile.isPrivate)
                                                  ? ((userProfile.followed ||
                                                          userProfile
                                                              .followPending) ==
                                                      followInfo['followed'])
                                                  : (userProfile.followed ==
                                                      followInfo['followed'])) {
                                                followInfo = await NetworkHandler
                                                    .followUser(
                                                        MyProfile.id,
                                                        userProfile.id,
                                                        (userProfile.isPrivate)
                                                            ? !(userProfile
                                                                    .followed ||
                                                                userProfile
                                                                    .followPending)
                                                            : !(userProfile
                                                                .followed));
                                              }

                                              setState(() {});
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        followInfo['error'])),
                                              );
                                            }
                                          },
                                          style: OutlinedButton.styleFrom(
                                            shape: const CircleBorder(),
                                            minimumSize: Size.zero,
                                            padding: const EdgeInsets.all(5),
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                          ),
                                          child: Icon(
                                            userProfile.followed
                                                ? Icons.person_remove_alt_1
                                                : (userProfile.isPrivate &&
                                                        userProfile
                                                            .followPending)
                                                    ? Icons.person_remove_alt_1
                                                    : Icons.person_add_alt_1,
                                            color: userProfile.followed
                                                ? Colors.red
                                                : (userProfile.isPrivate &&
                                                        userProfile
                                                            .followPending)
                                                    ? Colors.amber
                                                    : Colors.green,
                                            size: 20,
                                          ),
                                        ),
                                        OutlinedButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text('Report?'),
                                                content: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      const Text(
                                                          'Please elaborate on the reason you\'re reporting this user'),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 25),
                                                        child: TextFormField(
                                                          controller:
                                                              reportTextField,
                                                          maxLines: null,
                                                          minLines: null,
                                                          decoration:
                                                              InputDecoration(
                                                            floatingLabelBehavior:
                                                                FloatingLabelBehavior
                                                                    .auto,
                                                            labelText:
                                                                'Report message',
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
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    style: TextButton.styleFrom(
                                                      shape:
                                                          const StadiumBorder(),
                                                      minimumSize: Size.zero,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                    ),
                                                    child: const Text(
                                                      'Report',
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    onPressed: () async {
                                                      Map<String, dynamic>
                                                          reportInfo =
                                                          await NetworkHandler
                                                              .reportUser(
                                                        MyProfile.id,
                                                        userProfile.id,
                                                        reportTextField.text,
                                                      );

                                                      Navigator.pop(context);

                                                      if (reportInfo['error'] ==
                                                          null) {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              SimpleDialog(
                                                            title: const Text(
                                                                'Success!'),
                                                            children: [
                                                              Text(reportInfo[
                                                                  'success']),
                                                            ],
                                                          ),
                                                        );
                                                      } else {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              SimpleDialog(
                                                            title: const Text(
                                                                'Error!'),
                                                            children: [
                                                              Text(reportInfo[
                                                                  'error']),
                                                            ],
                                                          ),
                                                        );
                                                      }
                                                      setState(() {});
                                                    },
                                                  ),
                                                  TextButton(
                                                    style: TextButton.styleFrom(
                                                      shape:
                                                          const StadiumBorder(),
                                                      minimumSize: Size.zero,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                    ),
                                                    child: const Text(
                                                      'Cancel',
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                          style: OutlinedButton.styleFrom(
                                            shape: const CircleBorder(),
                                            minimumSize: Size.zero,
                                            padding: const EdgeInsets.all(5),
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                          ),
                                          child: Stack(
                                            children: const [
                                              Icon(
                                                Icons.flag,
                                                color: Colors.red,
                                                size: 20,
                                              ),
                                              Icon(
                                                Icons.outlined_flag,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (MyProfile
                                            .adminToken.isNotEmpty) ...[
                                          OutlinedButton(
                                            onPressed: () {
                                              showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.now().add(
                                                    const Duration(days: 365)),
                                                helpText:
                                                    'Ban this user until?',
                                                confirmText: 'Confirm',
                                                cancelText: 'Cancel',
                                              ).then(
                                                (chosenDate) async {
                                                  if (chosenDate != null) {
                                                    banDuration = chosenDate
                                                        .difference(DateTime(
                                                            DateTime.now().year,
                                                            DateTime.now()
                                                                .month,
                                                            DateTime.now()
                                                                .day));

                                                    Map<String, dynamic>
                                                        banInfo =
                                                        await NetworkHandler
                                                            .banUser_Admin(
                                                                userProfile.id,
                                                                banDuration
                                                                    .inDays);

                                                    if (banInfo['error'] ==
                                                        null) {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            SimpleDialog(
                                                          title: const Text(
                                                              'Success!'),
                                                          children: [
                                                            Text(banInfo[
                                                                'success']),
                                                          ],
                                                        ),
                                                      );
                                                      setState(() {});
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                            content: Text(
                                                                banInfo[
                                                                    'error'])),
                                                      );
                                                    }
                                                  }
                                                },
                                              );
                                            },
                                            style: OutlinedButton.styleFrom(
                                              shape: const CircleBorder(),
                                              minimumSize: Size.zero,
                                              padding: const EdgeInsets.all(5),
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                            child: const Icon(
                                              Icons.block,
                                              color: Colors.red,
                                              size: 20,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    profileView = ProfileView.tweets;
                                    setState(() {});
                                  },
                                  child: const Text(
                                    'Lars\n?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    profileView = ProfileView.likes;
                                    setState(() {});
                                  },
                                  child: const Text(
                                    'Likes\n?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    profileView = ProfileView.media;
                                    setState(() {});
                                  },
                                  child: const Text(
                                    'Media\n?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (context) => StatefulBuilder(
                                        builder: (context, setState) =>
                                            SimpleDialog(
                                          title: const Text('Followers'),
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                              child: SizedBox(
                                                width: 400,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      if (userProfile == null &&
                                                          MyProfile
                                                              .isPrivate) ...[
                                                        FutureBuilder<
                                                            List<
                                                                Map<String,
                                                                    dynamic>>>(
                                                          future: NetworkHandler
                                                              .getUserFollowRequests(),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              if (snapshot.data!
                                                                  .isNotEmpty) {
                                                                if (snapshot.data![
                                                                            0][
                                                                        'error'] ==
                                                                    null) {
                                                                  return ListView
                                                                      .builder(
                                                                    shrinkWrap:
                                                                        true,
                                                                    physics:
                                                                        const NeverScrollableScrollPhysics(),
                                                                    scrollDirection:
                                                                        Axis.vertical,
                                                                    itemCount:
                                                                        snapshot
                                                                            .data!
                                                                            .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return Column(
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Flexible(
                                                                                child: TextButton(
                                                                                  onPressed: () {
                                                                                    if (snapshot.data![index]['id'] == MyProfile.id) {
                                                                                      Navigator.pushNamedAndRemoveUntil(context, '/Profile', ModalRoute.withName('/Welcome'), arguments: {
                                                                                        'profileID': MyProfile.id
                                                                                      });
                                                                                    } else {
                                                                                      Navigator.pushNamed(context, '/Profile', arguments: {
                                                                                        'profileID': snapshot.data![index]['id']
                                                                                      }).then((value) => setState(() {}));
                                                                                    }
                                                                                  },
                                                                                  child: Row(
                                                                                    children: [
                                                                                      CircleAvatar(
                                                                                        foregroundImage: (snapshot.data![index]['avatarURL'].isNotEmpty) ? NetworkImage(snapshot.data![index]['avatarURL']) : null,
                                                                                        backgroundImage: (snapshot.data![index]['id'] == MyProfile.id) ? const AssetImage('assets/myavatar.png') : const AssetImage('assets/otheravatar.png'),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(left: 5),
                                                                                        child: Column(
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Text(
                                                                                              snapshot.data![index]['screenName'],
                                                                                              style: const TextStyle(
                                                                                                fontWeight: FontWeight.bold,
                                                                                                fontSize: 20,
                                                                                              ),
                                                                                            ),
                                                                                            Text(
                                                                                              '@' + snapshot.data![index]['tag'],
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
                                                                            ],
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(vertical: 5),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                              children: [
                                                                                OutlinedButton(
                                                                                  onPressed: () async {
                                                                                    Map<String, dynamic> followInfo = await NetworkHandler.acceptFollowRequest(snapshot.data![index]['id']);

                                                                                    if (followInfo['error'] == null) {
                                                                                      setState(() {});
                                                                                    } else {
                                                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                                                        SnackBar(content: Text(followInfo['error'])),
                                                                                      );
                                                                                    }
                                                                                  },
                                                                                  style: OutlinedButton.styleFrom(
                                                                                    shape: const CircleBorder(),
                                                                                    minimumSize: Size.zero,
                                                                                    padding: const EdgeInsets.all(5),
                                                                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                                  ),
                                                                                  child: const Icon(
                                                                                    Icons.check,
                                                                                    color: Colors.green,
                                                                                    size: 20,
                                                                                  ),
                                                                                ),
                                                                                OutlinedButton(
                                                                                  onPressed: () async {
                                                                                    Map<String, dynamic> followInfo = await NetworkHandler.declineFollowRequest(snapshot.data![index]['id']);

                                                                                    if (followInfo['error'] == null) {
                                                                                      setState(() {});
                                                                                    } else {
                                                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                                                        SnackBar(content: Text(followInfo['error'])),
                                                                                      );
                                                                                    }
                                                                                  },
                                                                                  style: OutlinedButton.styleFrom(
                                                                                    shape: const CircleBorder(),
                                                                                    minimumSize: Size.zero,
                                                                                    padding: const EdgeInsets.all(5),
                                                                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                                  ),
                                                                                  child: const Icon(
                                                                                    Icons.clear,
                                                                                    color: Colors.red,
                                                                                    size: 20,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          const Padding(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: 50),
                                                                            child:
                                                                                Divider(thickness: 2),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  );
                                                                } else {
                                                                  Future
                                                                      .delayed(
                                                                    Duration
                                                                        .zero,
                                                                    () => ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      SnackBar(
                                                                          content:
                                                                              Text(snapshot.data![0]['error'])),
                                                                    ),
                                                                  );
                                                                  return const Center(
                                                                    child:
                                                                        CircularProgressIndicator(),
                                                                  );
                                                                }
                                                              } else {
                                                                return const Center(
                                                                  child: Text(
                                                                    'No follow requests',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          20,
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                            } else {
                                                              return const Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              );
                                                            }
                                                          },
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10),
                                                          child: Column(
                                                            children: const [
                                                              Divider(
                                                                  thickness: 2),
                                                              Divider(
                                                                  thickness: 2),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                      FutureBuilder<
                                                          List<
                                                              Map<String,
                                                                  dynamic>>>(
                                                        future: NetworkHandler
                                                            .getUserFollowers(
                                                                (userProfile !=
                                                                        null)
                                                                    ? userProfile
                                                                        .id
                                                                    : MyProfile
                                                                        .id),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            if (snapshot.data!
                                                                .isNotEmpty) {
                                                              if (snapshot.data![
                                                                          0][
                                                                      'error'] ==
                                                                  null) {
                                                                return ListView
                                                                    .builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  physics:
                                                                      const NeverScrollableScrollPhysics(),
                                                                  scrollDirection:
                                                                      Axis.vertical,
                                                                  itemCount:
                                                                      snapshot
                                                                          .data!
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return Column(
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Flexible(
                                                                              child: TextButton(
                                                                                onPressed: () {
                                                                                  if (snapshot.data![index]['id'] == MyProfile.id) {
                                                                                    Navigator.pushNamedAndRemoveUntil(context, '/Profile', ModalRoute.withName('/Welcome'), arguments: {
                                                                                      'profileID': MyProfile.id
                                                                                    });
                                                                                  } else {
                                                                                    Navigator.pushNamed(context, '/Profile', arguments: {
                                                                                      'profileID': snapshot.data![index]['id']
                                                                                    }).then((value) => setState(() {}));
                                                                                  }
                                                                                },
                                                                                child: Row(
                                                                                  children: [
                                                                                    CircleAvatar(
                                                                                      foregroundImage: (snapshot.data![index]['avatarURL'].isNotEmpty) ? NetworkImage(snapshot.data![index]['avatarURL']) : null,
                                                                                      backgroundImage: (snapshot.data![index]['id'] == MyProfile.id) ? const AssetImage('assets/myavatar.png') : const AssetImage('assets/otheravatar.png'),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(left: 5),
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Text(
                                                                                            snapshot.data![index]['screenName'],
                                                                                            style: const TextStyle(
                                                                                              fontWeight: FontWeight.bold,
                                                                                              fontSize: 20,
                                                                                            ),
                                                                                          ),
                                                                                          Text(
                                                                                            '@' + snapshot.data![index]['tag'],
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
                                                                          ],
                                                                        ),
                                                                        const Padding(
                                                                          padding:
                                                                              EdgeInsets.symmetric(horizontal: 50),
                                                                          child:
                                                                              Divider(thickness: 2),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                );
                                                              } else {
                                                                Future.delayed(
                                                                  Duration.zero,
                                                                  () => ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                        content:
                                                                            Text(snapshot.data![0]['error'])),
                                                                  ),
                                                                );
                                                                return const Center(
                                                                  child:
                                                                      CircularProgressIndicator(),
                                                                );
                                                              }
                                                            } else {
                                                              return const Center(
                                                                child: Text(
                                                                  'No one follows this user',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        20,
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          } else {
                                                            return const Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Followers\n${(userProfile != null) ? userProfile.followerCount : MyProfile.followerCount}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (context) => SimpleDialog(
                                        title: const Text('Followings'),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            child: SizedBox(
                                              width: 400,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    FutureBuilder<
                                                        List<
                                                            Map<String,
                                                                dynamic>>>(
                                                      future: NetworkHandler
                                                          .getUserFollowings(
                                                              (userProfile !=
                                                                      null)
                                                                  ? userProfile
                                                                      .id
                                                                  : MyProfile
                                                                      .id),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          if (snapshot.data!
                                                              .isNotEmpty) {
                                                            if (snapshot.data![
                                                                        0]
                                                                    ['error'] ==
                                                                null) {
                                                              return ListView
                                                                  .builder(
                                                                shrinkWrap:
                                                                    true,
                                                                physics:
                                                                    const NeverScrollableScrollPhysics(),
                                                                scrollDirection:
                                                                    Axis.vertical,
                                                                itemCount:
                                                                    snapshot
                                                                        .data!
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return Column(
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Flexible(
                                                                            child:
                                                                                TextButton(
                                                                              onPressed: () {
                                                                                if (snapshot.data![index]['id'] == MyProfile.id) {
                                                                                  Navigator.pushNamedAndRemoveUntil(context, '/Profile', ModalRoute.withName('/Welcome'), arguments: {
                                                                                    'profileID': MyProfile.id
                                                                                  });
                                                                                } else {
                                                                                  Navigator.pushNamed(context, '/Profile', arguments: {
                                                                                    'profileID': snapshot.data![index]['id']
                                                                                  }).then((value) => setState(() {}));
                                                                                }
                                                                              },
                                                                              child: Row(
                                                                                children: [
                                                                                  CircleAvatar(
                                                                                    foregroundImage: (snapshot.data![index]['avatarURL'].isNotEmpty) ? NetworkImage(snapshot.data![index]['avatarURL']) : null,
                                                                                    backgroundImage: (snapshot.data![index]['id'] == MyProfile.id) ? const AssetImage('assets/myavatar.png') : const AssetImage('assets/otheravatar.png'),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.only(left: 5),
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Text(
                                                                                          snapshot.data![index]['screenName'],
                                                                                          style: const TextStyle(
                                                                                            fontWeight: FontWeight.bold,
                                                                                            fontSize: 20,
                                                                                          ),
                                                                                        ),
                                                                                        Text(
                                                                                          '@' + snapshot.data![index]['tag'],
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
                                                                        ],
                                                                      ),
                                                                      const Padding(
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: 50),
                                                                        child: Divider(
                                                                            thickness:
                                                                                2),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            } else {
                                                              Future.delayed(
                                                                Duration.zero,
                                                                () => ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                      content: Text(
                                                                          snapshot.data![0]
                                                                              [
                                                                              'error'])),
                                                                ),
                                                              );
                                                              return const Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              );
                                                            }
                                                          } else {
                                                            return const Center(
                                                              child: Text(
                                                                'This user follows no one',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        } else {
                                                          return const Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Following\n${(userProfile != null) ? userProfile.followingCount : MyProfile.followingCount}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        sliver: FutureBuilder<List<Map<String, dynamic>>>(
                          future: (profileView == ProfileView.tweets)
                              ? NetworkHandler.getUserTweets(
                                  (userProfile != null)
                                      ? userProfile.id
                                      : MyProfile.id)
                              : (profileView == ProfileView.likes)
                                  ? NetworkHandler.getUserLikes(
                                      (userProfile != null)
                                          ? userProfile.id
                                          : MyProfile.id)
                                  : (profileView == ProfileView.media)
                                      ? NetworkHandler.getUserMedia(
                                          (userProfile != null)
                                              ? userProfile.id
                                              : MyProfile.id)
                                      : null,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.isNotEmpty) {
                                if (snapshot.data![0]['error'] == null) {
                                  return SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                        return Column(
                                          children: [
                                            Tweet(
                                              id: snapshot.data![index]['id'],
                                              ownerid: snapshot.data![index]
                                                  ['ownerid'],
                                              avatarURL: snapshot.data![index]
                                                  ['avatarURL'],
                                              tag: snapshot.data![index]['tag'],
                                              name: snapshot.data![index]
                                                  ['name'],
                                              text: snapshot.data![index]
                                                  ['text'],
                                              postdate: snapshot.data![index]
                                                  ['postdate'],
                                              replycount: snapshot.data![index]
                                                  ['replycount'],
                                              retweetcount: snapshot
                                                  .data![index]['retweetcount'],
                                              likecount: snapshot.data![index]
                                                  ['likecount'],
                                              liked: snapshot.data![index]
                                                  ['liked'],
                                              view: TweetView.full,
                                              tags: snapshot.data![index]
                                                  ['tags'],
                                              images: snapshot.data![index]
                                                  ['images'],
                                              embeddedtweet:
                                                  snapshot.data![index]
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
                                      childCount: snapshot.data!.length,
                                    ),
                                  );
                                } else {
                                  Future.delayed(
                                    Duration.zero,
                                    () => ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                          content:
                                              Text(snapshot.data![0]['error'])),
                                    ),
                                  );
                                  return SliverList(
                                    delegate: SliverChildListDelegate([
                                      const Center(
                                          child: CircularProgressIndicator())
                                    ]),
                                  );
                                }
                              } else {
                                return SliverList(
                                  delegate: SliverChildListDelegate([
                                    const Center(
                                      child: Text(
                                        'No lars in this profile.',
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
                                      child: CircularProgressIndicator())
                                ]),
                              );
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
