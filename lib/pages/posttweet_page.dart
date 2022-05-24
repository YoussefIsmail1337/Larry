import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../NetworkHandler.dart';
import '../UserProfile.dart';
import '../Tweet.dart';

class PostTweet_Page extends StatefulWidget {
  const PostTweet_Page({Key? key}) : super(key: key);

  @override
  State<PostTweet_Page> createState() => _PostTweet_PageState();
}

class _PostTweet_PageState extends State<PostTweet_Page> {
  final TextEditingController tweetTextField = TextEditingController();

  final ImagePicker imagePicker = ImagePicker();
  List<XFile> images = [];

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> postMethod =
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  '/Profile', ModalRoute.withName('/Welcome'),
                                  arguments: {'profileID': MyProfile.id});
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  foregroundImage:
                                      (MyProfile.avatarURL.isNotEmpty)
                                          ? NetworkImage(MyProfile.avatarURL)
                                          : null,
                                  backgroundImage:
                                      const AssetImage('assets/myavatar.png'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        MyProfile.screenName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        '@' + MyProfile.tag,
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25),
                            child: TextFormField(
                              controller: tweetTextField,
                              maxLength: 280,
                              maxLines: null,
                              minLines: null,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                labelText: 'Lar Content',
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                ),
                                hintText: 'Write your Lar here',
                                hintStyle: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          if (postMethod['retweetID'] == '') ...[
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
                                itemCount: images.length,
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
                                        child: Image.file(
                                          File(images[index].path),
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
                                                  child: Image.file(
                                                    File(images[index].path),
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      if (index != images.length - 1) ...[
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
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            images.removeAt(index);
                                            setState(() {});
                                          },
                                          style: OutlinedButton.styleFrom(
                                            shape: const CircleBorder(),
                                            minimumSize: Size.zero,
                                            padding: const EdgeInsets.all(5),
                                            tapTargetSize: MaterialTapTargetSize
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
                                  );
                                },
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    minimumSize: Size.zero,
                                    fixedSize: const Size(120, 60),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 40,
                                  ),
                                  onPressed: () async {
                                    List<XFile>? selectedImages =
                                        await imagePicker.pickMultiImage();

                                    if (selectedImages != null) {
                                      for (XFile image in selectedImages) {
                                        if (images.length < 4) {
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
                                              images.add(image);
                                            } else {
                                              Future.delayed(
                                                Duration.zero,
                                                () => ScaffoldMessenger.of(
                                                        context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                          'Failed to add file ' +
                                                              image.name +
                                                              ': Size is bigger than 1mb limit')),
                                                ),
                                              );
                                            }
                                          } else {
                                            Future.delayed(
                                              Duration.zero,
                                              () =>
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        'Failed to add file ' +
                                                            image.name +
                                                            ': Not a supported extension')),
                                              ),
                                            );
                                          }
                                        } else {
                                          Future.delayed(
                                            Duration.zero,
                                            () => ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'Failed to add files: 4 Images limit reached')),
                                            ),
                                          );
                                          break;
                                        }
                                      }
                                    }
                                    setState(() {});
                                  },
                                ),
                              ),
                            )
                          ],
                          if (postMethod['retweetID'] != '') ...[
                            Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: FutureBuilder<Map<String, dynamic>>(
                                future: NetworkHandler.getTweet(
                                    postMethod['retweetID']),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data!['error'] == null) {
                                      return Tweet(
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
                                        view: TweetView.minimal,
                                        tags: snapshot.data!['tags'],
                                        images: snapshot.data!['images'],
                                        embeddedtweet:
                                            snapshot.data!['embeddedtweet'],
                                        embeddedtweetdeleted: snapshot
                                            .data!['embeddedtweetdeleted'],
                                        replies: snapshot.data!['replies'],
                                      );
                                    } else {
                                      Future.delayed(
                                        Duration.zero,
                                        () => ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  snapshot.data!['error'])),
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
                            ),
                          ],
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: OutlinedButton(
                                onPressed: () async {
                                  List<String> tags = [];
                                  for (RegExpMatch match
                                      in RegExp(r'(\B[@]\w*\b)')
                                          .allMatches(tweetTextField.text)) {
                                    String newTag = tweetTextField.text
                                        .substring(match.start, match.end);
                                    if (!tags.contains(newTag)) {
                                      tags.add(newTag);
                                    }
                                  }

                                  if (tags.length <= 10) {
                                    List<File> imageFiles = [];
                                    for (XFile image in images) {
                                      imageFiles.add(File(image.path));
                                    }

                                    if (postMethod['retweetID'] == '') {
                                      Map<String, dynamic> postInfo =
                                          await NetworkHandler.createPost(
                                              tweetTextField.text,
                                              tags,
                                              imageFiles);

                                      if (postInfo['error'] == null) {
                                        Navigator.pop(context);
                                      } else {
                                        Future.delayed(
                                          Duration.zero,
                                          () => ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content:
                                                    Text(postInfo['error'])),
                                          ),
                                        );
                                      }
                                    } else {
                                      Map<String, dynamic> repostInfo =
                                          await NetworkHandler.createRepost(
                                              tweetTextField.text,
                                              tags,
                                              postMethod['retweetID']);

                                      if (repostInfo['error'] == null) {
                                        Navigator.pop(context);
                                      } else {
                                        Future.delayed(
                                          Duration.zero,
                                          () => ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content:
                                                    Text(repostInfo['error'])),
                                          ),
                                        );
                                      }
                                    }
                                  } else {
                                    Future.delayed(
                                      Duration.zero,
                                      () => ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('10 tag limit reached')),
                                      ),
                                    );
                                  }
                                },
                                style: OutlinedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  minimumSize: Size.zero,
                                  fixedSize: const Size(200, 60),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text(
                                  'Lar',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                  ),
                                ),
                              ),
                            ),
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
