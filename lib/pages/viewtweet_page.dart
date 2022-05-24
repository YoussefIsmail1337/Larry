import 'package:flutter/material.dart';

import '../NetworkHandler.dart';
import '../UserProfile.dart';
import '../Tweet.dart';

class ViewTweet_Page extends StatefulWidget {
  const ViewTweet_Page({Key? key}) : super(key: key);

  @override
  State<ViewTweet_Page> createState() => _ViewTweet_PageState();
}

class _ViewTweet_PageState extends State<ViewTweet_Page> {
  final TextEditingController commentTextField = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> viewMethod =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

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
                body: SafeArea(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Column(
                        children: [
                          FutureBuilder<Map<String, dynamic>>(
                            future:
                                NetworkHandler.getTweet(viewMethod['tweetID']),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data!['error'] == null) {
                                  if (!viewMethod['viewReplies']) {
                                    Future.delayed(
                                        Duration.zero,
                                        () => scrollController.animateTo(
                                            scrollController
                                                    .position.maxScrollExtent *
                                                1.25,
                                            duration:
                                                const Duration(seconds: 1),
                                            curve: Curves.ease));
                                  }

                                  return Column(
                                    children: [
                                      Tweet(
                                        id: snapshot.data!['id'],
                                        ownerid: snapshot.data!['ownerid'],
                                        avatarURL: snapshot.data!['avatarURL'],
                                        tag: snapshot.data!['tag'],
                                        name: snapshot.data!['name'],
                                        text: snapshot.data!['text'],
                                        postdate: snapshot.data!['postdate'],
                                        replycount:
                                            snapshot.data!['replycount'],
                                        retweetcount:
                                            snapshot.data!['retweetcount'],
                                        likecount: snapshot.data!['likecount'],
                                        liked: snapshot.data!['liked'],
                                        view: TweetView.replying,
                                        tags: snapshot.data!['tags'],
                                        images: snapshot.data!['images'],
                                        embeddedtweet:
                                            snapshot.data!['embeddedtweet'],
                                        embeddedtweetdeleted: snapshot
                                            .data!['embeddedtweetdeleted'],
                                        replies: snapshot.data!['replies'],
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 100),
                                        child: Divider(thickness: 2),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 35,
                                            height: 60,
                                            child: Center(
                                              child: Icon(
                                                Icons.arrow_right_alt,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                size: 40,
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator
                                                        .pushNamedAndRemoveUntil(
                                                            context,
                                                            '/Profile',
                                                            ModalRoute.withName(
                                                                '/Welcome'),
                                                            arguments: {
                                                          'profileID':
                                                              MyProfile.id
                                                        });
                                                  },
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      CircleAvatar(
                                                        foregroundImage: (MyProfile
                                                                .avatarURL
                                                                .isNotEmpty)
                                                            ? NetworkImage(
                                                                MyProfile
                                                                    .avatarURL)
                                                            : null,
                                                        backgroundImage:
                                                            const AssetImage(
                                                                'assets/myavatar.png'),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 5),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              MyProfile
                                                                  .screenName,
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20,
                                                              ),
                                                            ),
                                                            Text(
                                                              '@' +
                                                                  MyProfile.tag,
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12,
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
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 25),
                                                  child: TextFormField(
                                                    controller:
                                                        commentTextField,
                                                    maxLength: 280,
                                                    maxLines: null,
                                                    minLines: null,
                                                    decoration: InputDecoration(
                                                      floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .auto,
                                                      labelText: 'Lar Content',
                                                      labelStyle:
                                                          const TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 16,
                                                      ),
                                                      hintText:
                                                          'Write your Lar here',
                                                      hintStyle:
                                                          const TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 16,
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    child: OutlinedButton(
                                                      onPressed: () async {
                                                        List<String> tags = [];
                                                        for (RegExpMatch match in RegExp(
                                                                r'(\B[@]\w*\b)')
                                                            .allMatches(
                                                                commentTextField
                                                                    .text)) {
                                                          String newTag =
                                                              commentTextField
                                                                  .text
                                                                  .substring(
                                                                      match
                                                                          .start,
                                                                      match
                                                                          .end);
                                                          if (!tags.contains(
                                                              newTag)) {
                                                            tags.add(newTag);
                                                          }
                                                        }

                                                        if (tags.length <= 10) {
                                                          Map<String, dynamic>
                                                              commentInfo =
                                                              await NetworkHandler
                                                                  .createComment(
                                                                      commentTextField
                                                                          .text,
                                                                      tags,
                                                                      snapshot.data![
                                                                          'id']);

                                                          if (commentInfo[
                                                                  'error'] ==
                                                              null) {
                                                            Navigator.pop(
                                                                context);
                                                          } else {
                                                            Future.delayed(
                                                              Duration.zero,
                                                              () => ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                    content: Text(
                                                                        commentInfo[
                                                                            'error'])),
                                                              ),
                                                            );
                                                          }
                                                        }
                                                      },
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        shape:
                                                            const StadiumBorder(),
                                                        minimumSize: Size.zero,
                                                        fixedSize:
                                                            const Size(200, 60),
                                                        tapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                      ),
                                                      child: const Text(
                                                        'Lar',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 40,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                } else {
                                  Future.delayed(
                                    Duration.zero,
                                    () => ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                          content:
                                              Text(snapshot.data!['error'])),
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
                            },
                          ),
                        ],
                      ),
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
