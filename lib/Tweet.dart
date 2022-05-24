import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';

import 'NetworkHandler.dart';
import 'UserProfile.dart';

enum TweetView {
  full,
  replying,
  focused,
  comment,
  minimal,
}

class Tweet extends StatefulWidget {
  final String id;
  final String ownerid;
  final String avatarURL;
  final String tag;
  final String name;
  final String text;
  final DateTime postdate;
  final int replycount;
  final int retweetcount;
  final int likecount;
  bool liked;
  final TweetView view;
  final List<Map<String, String>> tags;
  final List<String> images;
  final Map<String, dynamic> embeddedtweet;
  final bool embeddedtweetdeleted;
  final List<Map<String, dynamic>> replies;

  List<int> tagMatches = [];

  Tweet({
    Key? key,
    required this.id,
    required this.ownerid,
    required this.avatarURL,
    required this.tag,
    required this.name,
    required this.text,
    required this.postdate,
    required this.replycount,
    required this.retweetcount,
    required this.likecount,
    required this.liked,
    required this.view,
    required this.tags,
    required this.images,
    required this.embeddedtweet,
    required this.embeddedtweetdeleted,
    required this.replies,
  }) : super(key: key) {
    for (RegExpMatch match in RegExp(r'(\B[@]\w*\b)').allMatches(text)) {
      tagMatches.add(match.start);
      tagMatches.add(match.end);
    }
  }

  @override
  State<Tweet> createState() => _TweetState();
}

class _TweetState extends State<Tweet> {
  final TextEditingController reportTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onLongPress: () {
        if (widget.view == TweetView.full ||
            widget.view == TweetView.focused ||
            widget.view == TweetView.comment ||
            widget.view == TweetView.minimal) {
          Navigator.pushNamed(context, '/View',
                  arguments: {'tweetID': widget.id, 'viewReplies': true})
              .then((value) => setState(() {}));
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.view == TweetView.comment) ...[
            SizedBox(
              width: 35,
              height: 60,
              child: Center(
                child: Icon(
                  Icons.arrow_right_alt,
                  color: Theme.of(context).colorScheme.primary,
                  size: 40,
                ),
              ),
            )
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        if (widget.ownerid == MyProfile.id) {
                          Navigator.pushNamedAndRemoveUntil(context, '/Profile',
                              ModalRoute.withName('/Welcome'),
                              arguments: {'profileID': MyProfile.id});
                        } else {
                          Navigator.pushNamed(context, '/Profile',
                                  arguments: {'profileID': widget.ownerid})
                              .then((value) => setState(() {}));
                        }
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            foregroundImage: (widget.avatarURL.isNotEmpty)
                                ? NetworkImage(widget.avatarURL)
                                : null,
                            backgroundImage: (widget.ownerid == MyProfile.id)
                                ? const AssetImage('assets/myavatar.png')
                                : const AssetImage('assets/otheravatar.png'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  '@' + widget.tag,
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
                    if (widget.view == TweetView.full ||
                        widget.view == TweetView.replying) ...[
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (widget.ownerid == MyProfile.id) ...[
                              OutlinedButton(
                                onPressed: () async {
                                  Map<String, dynamic> deleteInfo =
                                      await NetworkHandler.deleteTweet(
                                          widget.id);

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
                                child: Stack(
                                  children: const [
                                    Icon(
                                      Icons.delete_forever_outlined,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                    Icon(
                                      Icons.delete_forever,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ] else ...[
                              OutlinedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Report?'),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                                'Please elaborate on the reason you\'re reporting this post'),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 25),
                                              child: TextFormField(
                                                controller: reportTextField,
                                                maxLines: null,
                                                minLines: null,
                                                decoration: InputDecoration(
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .auto,
                                                  labelText: 'Report message',
                                                  labelStyle: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 16,
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
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
                                            shape: const StadiumBorder(),
                                            minimumSize: Size.zero,
                                            padding: const EdgeInsets.all(5),
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                          ),
                                          child: const Text(
                                            'Report',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          onPressed: () async {
                                            Map<String, dynamic> reportInfo =
                                                await NetworkHandler
                                                    .reportTweet(
                                              MyProfile.id,
                                              widget.id,
                                              reportTextField.text,
                                            );

                                            Navigator.pop(context);

                                            if (reportInfo['error'] == null) {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    SimpleDialog(
                                                  title: const Text('Success!'),
                                                  children: [
                                                    Text(reportInfo['success']),
                                                  ],
                                                ),
                                              );
                                            } else {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    SimpleDialog(
                                                  title: const Text('Error!'),
                                                  children: [
                                                    Text(reportInfo['error']),
                                                  ],
                                                ),
                                              );
                                            }
                                            setState(() {});
                                          },
                                        ),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            shape: const StadiumBorder(),
                                            minimumSize: Size.zero,
                                            padding: const EdgeInsets.all(5),
                                            tapTargetSize: MaterialTapTargetSize
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
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  minimumSize: Size.zero,
                                  padding: const EdgeInsets.all(5),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
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
                            ],
                            if (MyProfile.adminToken.isNotEmpty) ...[
                              OutlinedButton(
                                onPressed: () async {
                                  Map<String, dynamic> deleteInfo =
                                      await NetworkHandler.deleteTweet_Admin(
                                          widget.id);

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
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
                if (widget.embeddedtweet.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(
                        Icons.loop,
                        color: Colors.grey,
                        size: 20,
                      ),
                      Text(
                        ' Relar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      if (widget.tagMatches.isNotEmpty) ...[
                        TextSpan(
                          text:
                              widget.text.substring(0, widget.tagMatches.first),
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        for (int i = 0;
                            i < widget.tagMatches.length / 2;
                            ++i) ...[
                          TextSpan(
                            text: widget.text.substring(
                                widget.tagMatches[i * 2],
                                widget.tagMatches[i * 2 + 1]),
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      backgroundColor:
                                          Colors.blueGrey.withOpacity(0.5),
                                    ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Map<String, String> tagInfo = widget.tags
                                    .firstWhere((tag) =>
                                        '@' + tag['tag']! ==
                                        widget.text.substring(
                                            widget.tagMatches[i * 2],
                                            widget.tagMatches[i * 2 + 1]));

                                if (tagInfo['error'] == null) {
                                  Navigator.pushNamed(context, '/Profile',
                                      arguments: {
                                        'profileID': tagInfo['id']
                                      }).then((value) => setState(() {}));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(tagInfo['error']!)),
                                  );
                                }
                              },
                          ),
                          if (i + 1 < widget.tagMatches.length / 2) ...[
                            TextSpan(
                              text: widget.text.substring(
                                  widget.tagMatches[i * 2 + 1],
                                  widget.tagMatches[(i + 1) * 2]),
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ],
                        TextSpan(
                          text: widget.text.substring(widget.tagMatches.last),
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ] else ...[
                        TextSpan(
                          text: widget.text,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ],
                  ),
                ),
                if (widget.images.isNotEmpty) ...[
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 150,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.images.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            if (index != 0) ...[
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Opacity(
                                  opacity: 0.25,
                                  child: Icon(
                                    Icons.arrow_left,
                                    size: 40,
                                  ),
                                ),
                              )
                            ],
                            GestureDetector(
                              child: Image(
                                image: NetworkImage(widget.images[index]),
                                fit: BoxFit.contain,
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => SimpleDialog(
                                    titlePadding: EdgeInsets.zero,
                                    contentPadding: EdgeInsets.zero,
                                    children: [
                                      InteractiveViewer(
                                        child: Image(
                                          image: NetworkImage(
                                              widget.images[index]),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            if (index != widget.images.length - 1) ...[
                              const Align(
                                alignment: Alignment.centerRight,
                                child: Opacity(
                                  opacity: 0.25,
                                  child: Icon(
                                    Icons.arrow_right,
                                    size: 40,
                                  ),
                                ),
                              )
                            ],
                          ],
                        );
                      },
                    ),
                  ),
                ],
                if (widget.embeddedtweet.isNotEmpty) ...[
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Tweet(
                      id: widget.embeddedtweet['id'],
                      ownerid: widget.embeddedtweet['ownerid'],
                      avatarURL: widget.embeddedtweet['avatarURL'],
                      tag: widget.embeddedtweet['tag'],
                      name: widget.embeddedtweet['name'],
                      text: widget.embeddedtweet['text'],
                      postdate: widget.postdate,
                      replycount: 0,
                      retweetcount: widget.embeddedtweet['retweetcount'],
                      likecount: widget.embeddedtweet['likecount'],
                      liked: false,
                      view: TweetView.minimal,
                      tags: widget.embeddedtweet['tags'],
                      images: widget.embeddedtweet['images'],
                      embeddedtweet: const <String, dynamic>{},
                      embeddedtweetdeleted: false,
                      replies: const [],
                    ),
                  ),
                ] else if (widget.embeddedtweetdeleted) ...[
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Icon(
                            Icons.warning,
                            size: 16,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              'This Lar has been deleted by it\'s owner',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                if (widget.view == TweetView.full ||
                    widget.view == TweetView.replying ||
                    widget.view == TweetView.focused ||
                    widget.view == TweetView.comment) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (widget.view == TweetView.full ||
                          widget.view == TweetView.focused ||
                          widget.view == TweetView.comment) ...[
                        Column(
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/View',
                                    arguments: {
                                      'tweetID': widget.id,
                                      'viewReplies': false
                                    }).then((value) => setState(() {}));
                              },
                              style: OutlinedButton.styleFrom(
                                shape: const CircleBorder(),
                                minimumSize: Size.zero,
                                padding: const EdgeInsets.all(5),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Icon(
                                Icons.comment,
                                size: 20,
                              ),
                            ),
                            Text(
                              widget.replycount.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (widget.view == TweetView.full ||
                          widget.view == TweetView.replying ||
                          widget.view == TweetView.focused) ...[
                        Column(
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/Post',
                                        arguments: {'retweetID': widget.id})
                                    .then((value) => setState(() {}));
                              },
                              style: OutlinedButton.styleFrom(
                                shape: const CircleBorder(),
                                minimumSize: Size.zero,
                                padding: const EdgeInsets.all(5),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Icon(
                                Icons.repeat,
                                size: 20,
                              ),
                            ),
                            Text(
                              widget.retweetcount.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                      Column(
                        children: [
                          OutlinedButton(
                            onPressed: () async {
                              Map<String, dynamic> likeInfo =
                                  await NetworkHandler.likeTweet(widget.id);

                              if (likeInfo['error'] == null) {
                                if (widget.liked == likeInfo['liked']) {
                                  likeInfo =
                                      await NetworkHandler.likeTweet(widget.id);
                                }

                                widget.liked = likeInfo['liked'];
                                setState(() {});
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(likeInfo['error'])),
                                );
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              shape: const CircleBorder(),
                              minimumSize: Size.zero,
                              padding: const EdgeInsets.all(5),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Stack(
                              children: [
                                Icon(
                                  Icons.thumb_up,
                                  size: 20,
                                  color:
                                      widget.liked ? Colors.green : Colors.grey,
                                ),
                                const Icon(
                                  Icons.thumb_up_outlined,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            widget.likecount.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        DateFormat(
                                'EEE, MMMM d, yyyy\nhh:mm aaa \'${widget.postdate.toLocal().timeZoneName}\'')
                            .format(widget.postdate.toLocal()),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
                if (widget.view == TweetView.replying) ...[
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: widget.replies.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 160),
                            child: Divider(thickness: 2),
                          ),
                          Tweet(
                            id: widget.replies[index]['id'],
                            ownerid: widget.replies[index]['ownerid'],
                            avatarURL: widget.replies[index]['avatarURL'],
                            tag: widget.replies[index]['tag'],
                            name: widget.replies[index]['name'],
                            text: widget.replies[index]['text'],
                            postdate: widget.replies[index]['postdate'],
                            replycount: widget.replies[index]['replycount'],
                            retweetcount: widget.replies[index]['retweetcount'],
                            likecount: widget.replies[index]['likecount'],
                            liked: widget.replies[index]['liked'],
                            view: TweetView.comment,
                            tags: widget.replies[index]['tags'],
                            images: widget.replies[index]['images'],
                            embeddedtweet: const <String, dynamic>{},
                            embeddedtweetdeleted: false,
                            replies: const [],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
