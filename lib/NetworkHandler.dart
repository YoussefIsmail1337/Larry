import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http;

import 'UserProfile.dart';

class NetworkHandler {
  static const String baseURL =
      'http://larry-env.eba-u6mbx2gb.us-east-1.elasticbeanstalk.com/api';

  static bool mocked = false;

  static final http.Client _client = http.Client();
  static final http.Client _mockClient =
      http.MockClient((http.Request request) async {
    String requestURL = (request.url.toString()).substring(baseURL.length);
    Map<String, dynamic> requestbody = json.decode(request.body);

    http.Response response;

    //TEMP: FINISH MOCK SERVER
    switch (requestURL) {
      case '/user/login':
        {
          if (requestbody['email_or_username'] == 'Admin' &&
              requestbody['password'] == 'Admin') {
            response = http.Response(
                json.encode({
                  'user': {
                    '_id': '625dc6a5e9ead7eb1d687ddb',
                    'screenName': 'user117',
                    'tag': '3omda',
                    'birthDate': '1970-01-01T00:00:00.000Z',
                    'isPrivate': false,
                    'verified': true,
                    'profileAvater': null,
                    'banner': null,
                    'followercount': 0,
                    'followingcount': 0,
                    'createdAt': '2022-04-18T20:14:29.769Z',
                    'updatedAt': '2022-04-18T20:18:58.122Z',
                    '__v': 0,
                    'id': '625dc6a5e9ead7eb1d687ddb'
                  },
                  'token': {
                    'token':
                        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MjVkYzZhNWU5ZWFkN2ViMWQ2ODdkZGIiLCJpYXQiOjE2NTAzMTMxNjR9.ezkXPC4cbseKar9MZvLUyiyHs7Tr9qyKO4XhEk9tEaY',
                    'ownerId': '625dc6a5e9ead7eb1d687ddb',
                    '_id': '625dc7cce9ead7eb1d687de6',
                    'createdAt': '2022-04-18T20:19:24.222Z',
                    'updatedAt': '2022-04-18T20:19:24.222Z',
                    '__v': 0,
                    'id': '625dc7cce9ead7eb1d687de6'
                  }
                }),
                200);
          } else {
            response = http.Response(
                json.encode({
                  'error': 'Error: unable to login',
                }),
                400);
          }
          break;
        }

      case '/user/signup':
        {
          if (requestbody['tag'] == 'Admin') {
            response = http.Response(
                json.encode({
                  'error': 'Error: User already exists',
                }),
                400);
          } else {
            response = http.Response(
                json.encode({
                  'status': 'success',
                }),
                201);
          }
          break;
        }

      default:
        {
          response = http.Response(
              json.encode({
                'error': 'Error: Bad Request',
              }),
              400);
          break;
        }
    }

    return response;
  });

  //TEMP: CREATE FUNCTIONS
  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    http.Request request = http.Request(
      'POST',
      Uri.parse('$baseURL/user/login'),
    );
    request.body = json.encode({
      'email_or_username': username,
      'password': password,
    });
    request.headers.addAll({
      'Content-Type': 'application/json',
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'id': responsebody['user']['user']['_id'],
        'userToken': responsebody['token']['token'],
        'adminToken': (responsebody['user']['adminToken'] != null)
            ? responsebody['user']['adminToken']['token']
            : '',
        'darkMode': responsebody['user']['user']['darkMode'],
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<Map<String, dynamic>> loginGoogle() async {
    http.Request request = http.Request(
      'GET',
      Uri.parse('$baseURL/user/auth/google'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'id': responsebody['user']['user']['_id'],
        'userToken': responsebody['token']['token'],
        'adminToken': (responsebody['user']['adminToken'] != null)
            ? responsebody['user']['adminToken']['token']
            : '',
        'darkMode': responsebody['user']['user']['darkMode'],
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<Map<String, dynamic>> resetPassword(String email) async {
    http.Request request = http.Request(
      'POST',
      Uri.parse('$baseURL/user/forgotpassword'),
    );
    request.body = json.encode({
      'email': email,
    });
    request.headers.addAll({
      'Content-Type': 'application/json',
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': responsebody['success'],
      };
    } else {
      return {
        'error': responsebody['success'],
      };
    }
  }

  static Future<Map<String, dynamic>> signUp(
      String tag,
      String screenName,
      String email,
      String password,
      String birthdate,
      String location,
      String phoneNumber,
      String website,
      String biography) async {
    http.Request request = http.Request(
      'POST',
      Uri.parse('$baseURL/user/signup'),
    );
    request.body = json.encode({
      'tag': tag,
      'screenName': screenName,
      'email': email,
      'password': password,
      'birth': {'date': birthdate, 'visability': true},
      'location': {'place': location, 'visability': true},
      'phoneNumber': phoneNumber,
      'website': website,
      'Biography': biography,
    });
    request.headers.addAll({
      'Content-Type': 'application/json',
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 201) {
      return {
        'success': responsebody['status'],
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<Map<String, dynamic>> likeTweet(String id) async {
    http.Request request = http.Request(
      'PUT',
      Uri.parse('$baseURL/tweet/$id/like'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 201) {
      return {
        'liked': responsebody['isliked'],
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<Map<String, dynamic>> reportTweet(
      String reporter, String reported, String message) async {
    http.Request request = http.Request(
      'POST',
      Uri.parse('$baseURL/user/report'),
    );
    request.body = json.encode({
      'type': 'Tweet',
      'reporterId': reporter,
      'reportedId': reported,
      'msg': message,
    });
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 201) {
      return {
        'success': 'success',
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<Map<String, dynamic>> deleteTweet(String id) async {
    http.Request request = http.Request(
      'DELETE',
      Uri.parse('$baseURL/tweet/$id'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': responsebody['DeletedTweetStatus'],
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<Map<String, dynamic>> deleteTweet_Admin(String id) async {
    http.Request request = http.Request(
      'DELETE',
      Uri.parse('$baseURL/tweet/$id'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.adminToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': responsebody['DeletedTweetStatus'],
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<Map<String, dynamic>> profileTagToID(String tag) async {
    http.Request request = http.Request(
      'GET',
      Uri.parse('$baseURL/profile/tag/$tag'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'tag': tag,
        'id': responsebody['user']['_id'],
      };
    } else {
      return {
        'tag': tag,
        'error': responsebody['error'],
      };
    }
  }

  static Future<Map<String, dynamic>> getTweet(String id) async {
    http.Request request = http.Request(
      'GET',
      Uri.parse('$baseURL/tweet/$id'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      List<Map<String, String>> tags = [];
      for (Map<String, dynamic> tag in responsebody['tags']) {
        tags.add((await profileTagToID(tag['tag'].substring(1)))
            .map((key, value) => MapEntry(key, value as String)));
      }

      List<String> images = [];
      for (Map<String, dynamic> image in responsebody['gallery']) {
        images.add(image['photo']);
      }

      Map<String, dynamic> embeddedtweet = {};
      if (responsebody['retweetedTweet']['tweetId'] != null) {
        List<Map<String, String>> tags = [];
        for (Map<String, dynamic> tag in responsebody['retweetedTweet']
            ['tweetId']['tags']) {
          tags.add((await profileTagToID(tag['tag'].substring(1)))
              .map((key, value) => MapEntry(key, value as String)));
        }

        List<String> images = [];
        for (Map<String, dynamic> image in responsebody['retweetedTweet']
            ['tweetId']['gallery']) {
          images.add(image['photo']);
        }

        embeddedtweet = {
          'id': responsebody['retweetedTweet']['tweetId']['_id'],
          'ownerid': responsebody['retweetedTweet']['tweetId']['authorId']
              ['_id'],
          'avatarURL': responsebody['retweetedTweet']['tweetId']['authorId']
                  ['profileAvater']['url'] ??
              '',
          'tag': responsebody['retweetedTweet']['tweetId']['authorId']['tag'],
          'name': responsebody['retweetedTweet']['tweetId']['authorId']
              ['screenName'],
          'text': responsebody['retweetedTweet']['tweetId']['text'] ?? '',
          'retweetcount': responsebody['retweetedTweet']['tweetId']
              ['retweetCount'],
          'likecount': responsebody['retweetedTweet']['tweetId']['likeCount'],
          'tags': tags,
          'images': images,
        };
      }

      List<Map<String, dynamic>> replies = [];
      for (Map<String, dynamic> reply in responsebody['reply']) {
        List<Map<String, String>> tags = [];
        for (Map<String, dynamic> tag in reply['tags']) {
          tags.add((await profileTagToID(tag['tag'].substring(1)))
              .map((key, value) => MapEntry(key, value as String)));
        }

        List<String> images = [];
        for (Map<String, dynamic> image in reply['gallery']) {
          images.add(image['photo']);
        }

        replies.add({
          'id': reply['_id'],
          'ownerid': reply['authorId']['_id'],
          'avatarURL': reply['authorId']['profileAvater']['url'] ?? '',
          'tag': reply['authorId']['tag'],
          'name': reply['authorId']['screenName'],
          'text': reply['text'] ?? '',
          'postdate': DateTime.parse(reply['createdAt']),
          'replycount': reply['replyCount'],
          'retweetcount': reply['retweetCount'],
          'likecount': reply['likeCount'],
          'liked': reply['isliked'],
          'tags': tags,
          'images': images,
        });
      }

      return {
        'id': responsebody['_id'],
        'ownerid': responsebody['authorId']['_id'],
        'avatarURL': responsebody['authorId']['profileAvater']['url'] ?? '',
        'tag': responsebody['authorId']['tag'],
        'name': responsebody['authorId']['screenName'],
        'text': responsebody['text'] ?? '',
        'postdate': DateTime.parse(responsebody['createdAt']),
        'replycount': responsebody['replyCount'],
        'retweetcount': responsebody['retweetCount'],
        'likecount': responsebody['likeCount'],
        'liked': responsebody['isliked'],
        'tags': tags,
        'images': images,
        'embeddedtweet': embeddedtweet,
        'embeddedtweetdeleted': responsebody['retweetedTweet']['tweetExisted'],
        'replies': replies,
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<Map<String, dynamic>> createComment(
      String text, List<String> tags, String tweetID) async {
    http.Request request = http.Request(
      'POST',
      Uri.parse('$baseURL/reply'),
    );

    Map<String, dynamic> tagsMap = {};
    tagsMap.addEntries(tags.map((tag) => MapEntry('tag', tag)));

    request.body = json.encode({
      'text': text,
      'tags': tagsMap,
      'replyingTo': tweetID,
    });
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': responsebody['AddedTweetStatus'],
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<List<Map<String, dynamic>>> getTimeline() async {
    http.Request request = http.Request(
      'GET',
      Uri.parse('$baseURL/timeline'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    if (response.statusCode == 200) {
      List<dynamic> responsebody = json.decode(response.body);

      List<Map<String, dynamic>> list = [];
      for (Map<String, dynamic> item in responsebody) {
        List<Map<String, String>> tags = [];
        for (Map<String, dynamic> tag in item['tags']) {
          tags.add((await profileTagToID(tag['tag'].substring(1)))
              .map((key, value) => MapEntry(key, value as String)));
        }

        List<String> images = [];
        for (Map<String, dynamic> image in item['gallery']) {
          images.add(image['photo']);
        }

        Map<String, dynamic> embeddedtweet = {};
        if (item['retweetedTweet']['tweetId'] != null) {
          List<Map<String, String>> tags = [];
          for (Map<String, dynamic> tag in item['retweetedTweet']['tweetId']
              ['tags']) {
            tags.add((await profileTagToID(tag['tag'].substring(1)))
                .map((key, value) => MapEntry(key, value as String)));
          }

          List<String> images = [];
          for (Map<String, dynamic> image in item['retweetedTweet']['tweetId']
              ['gallery']) {
            images.add(image['photo']);
          }

          embeddedtweet = {
            'id': item['retweetedTweet']['tweetId']['_id'],
            'ownerid': item['retweetedTweet']['tweetId']['authorId']['_id'],
            'avatarURL': item['retweetedTweet']['tweetId']['authorId']
                    ['profileAvater']['url'] ??
                '',
            'tag': item['retweetedTweet']['tweetId']['authorId']['tag'],
            'name': item['retweetedTweet']['tweetId']['authorId']['screenName'],
            'text': item['retweetedTweet']['tweetId']['text'] ?? '',
            'retweetcount': item['retweetedTweet']['tweetId']['retweetCount'],
            'likecount': item['retweetedTweet']['tweetId']['likeCount'],
            'tags': tags,
            'images': images,
          };
        }

        List<Map<String, dynamic>> replies = [];

        list.add({
          'id': item['_id'],
          'ownerid': item['authorId']['_id'],
          'avatarURL': item['authorId']['profileAvater']['url'] ?? '',
          'tag': item['authorId']['tag'],
          'name': item['authorId']['screenName'],
          'text': item['text'] ?? '',
          'postdate': DateTime.parse(item['createdAt']),
          'replycount': item['replyCount'],
          'retweetcount': item['retweetCount'],
          'likecount': item['likeCount'],
          'liked': item['isliked'],
          'tags': tags,
          'images': images,
          'embeddedtweet': embeddedtweet,
          'embeddedtweetdeleted': item['retweetedTweet']['tweetExisted'],
          'replies': replies,
        });
      }

      return list;
    } else {
      Map<String, dynamic> responsebody = json.decode(response.body);

      return [
        {'error': responsebody['error']}
      ];
    }
  }

  static Future<List<Map<String, dynamic>>> getExplore() async {
    http.Request request = http.Request(
      'GET',
      Uri.parse('$baseURL/explore'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    if (response.statusCode == 200) {
      List<dynamic> responsebody = json.decode(response.body);

      List<Map<String, dynamic>> list = [];
      for (Map<String, dynamic> item in responsebody) {
        List<Map<String, String>> tags = [];
        for (Map<String, dynamic> tag in item['tags']) {
          tags.add((await profileTagToID(tag['tag'].substring(1)))
              .map((key, value) => MapEntry(key, value as String)));
        }

        List<String> images = [];
        for (Map<String, dynamic> image in item['gallery']) {
          images.add(image['photo']);
        }

        Map<String, dynamic> embeddedtweet = {};
        if (item['retweetedTweet']['tweetId'] != null) {
          List<Map<String, String>> tags = [];
          for (Map<String, dynamic> tag in item['retweetedTweet']['tweetId']
              ['tags']) {
            tags.add((await profileTagToID(tag['tag'].substring(1)))
                .map((key, value) => MapEntry(key, value as String)));
          }

          List<String> images = [];
          for (Map<String, dynamic> image in item['retweetedTweet']['tweetId']
              ['gallery']) {
            images.add(image['photo']);
          }

          embeddedtweet = {
            'id': item['retweetedTweet']['tweetId']['_id'],
            'ownerid': item['retweetedTweet']['tweetId']['authorId']['_id'],
            'avatarURL': item['retweetedTweet']['tweetId']['authorId']
                    ['profileAvater']['url'] ??
                '',
            'tag': item['retweetedTweet']['tweetId']['authorId']['tag'],
            'name': item['retweetedTweet']['tweetId']['authorId']['screenName'],
            'text': item['retweetedTweet']['tweetId']['text'] ?? '',
            'retweetcount': item['retweetedTweet']['tweetId']['retweetCount'],
            'likecount': item['retweetedTweet']['tweetId']['likeCount'],
            'tags': tags,
            'images': images,
          };
        }

        List<Map<String, dynamic>> replies = [];

        list.add({
          'id': item['_id'],
          'ownerid': item['authorId']['_id'],
          'avatarURL': item['authorId']['profileAvater']['url'] ?? '',
          'tag': item['authorId']['tag'],
          'name': item['authorId']['screenName'],
          'text': item['text'] ?? '',
          'postdate': DateTime.parse(item['createdAt']),
          'replycount': item['replyCount'],
          'retweetcount': item['retweetCount'],
          'likecount': item['likeCount'],
          'liked': item['isliked'],
          'tags': tags,
          'images': images,
          'embeddedtweet': embeddedtweet,
          'embeddedtweetdeleted': item['retweetedTweet']['tweetExisted'],
          'replies': replies,
        });
      }

      return list;
    } else {
      Map<String, dynamic> responsebody = json.decode(response.body);

      return [
        {'error': responsebody['error']}
      ];
    }
  }

  static Future<List<Map<String, dynamic>>> getSuggestions() async {
    http.Request request = http.Request(
      'GET',
      Uri.parse('$baseURL/profile/suggestedAccounts'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> list = [];

      for (Map<String, dynamic> item in responsebody['suggestedAccounts']) {
        list.add({
          'id': item['_id'],
          'screenName': item['screenName'],
          'tag': item['tag'],
          'avatarURL': item['profileAvater']['url'] ?? '',
        });
      }

      return list;
    } else {
      return [
        {'error': responsebody['error']}
      ];
    }
  }

  static Future<Map<String, dynamic>> createPost(
      String text, List<String> tags, List<File> images) async {
    http.MultipartRequest request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseURL/tweet'),
    );
    request.fields.addAll({
      'text': text,
      'imageCheck': images.isNotEmpty.toString(),
    });
    for (String tag in tags) {
      request.fields.addAll({'tags': tag});
    }
    for (File image in images) {
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': responsebody['AddedTweetStatus'],
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<Map<String, dynamic>> createRepost(
      String text, List<String> tags, String retweetID) async {
    http.Request request = http.Request(
      'POST',
      Uri.parse('$baseURL/retweet'),
    );

    Map<String, dynamic> tagsMap = {};
    tagsMap.addEntries(tags.map((tag) => MapEntry('tag', tag)));

    request.body = json.encode({
      'text': text,
      'tags': tagsMap,
      'retweetedTweet': retweetID,
    });
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': responsebody['AddedTweetStatus'],
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<Map<String, dynamic>> getMyProfile(String id) async {
    http.Request request = http.Request(
      'GET',
      Uri.parse('$baseURL/profile/$id/me'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'id': responsebody['_id'],
        'screenName': responsebody['screenName'],
        'tag': responsebody['tag'],
        'email': responsebody['email'] ?? '',
        'avatarURL': responsebody['profileAvater']['url'] ?? '',
        'bannerURL': responsebody['banner']['url'] ?? '',
        'biography': responsebody['Biography'] ?? '',
        'phoneNumber': responsebody['phoneNumber'] ?? '',
        'website': responsebody['website'] ?? '',
        'birthdate': (responsebody['birth'] != null)
            ? DateTime.parse(responsebody['birth']['date'] ?? '')
            : DateTime.now(),
        'birthdateVisibility': (responsebody['birth'] != null)
            ? responsebody['birth']['visability'] ?? true
            : true,
        //'location': (responsebody['location'] != null) ? responsebody['location']['place'] ?? '' : '',
        //'locationVisibility': (responsebody['location'] != null) ? responsebody['location']['visability'] ?? true : true,
        'isPrivate': responsebody['isPrivate'],
        'followerCount': responsebody['followercount'],
        'followingCount': responsebody['followingcount'],
        'newFollowNotification': responsebody['Notificationssetting']
            ['newfollow'],
        'newTweetNotification': responsebody['Notificationssetting']
            ['newtweet'],
        'newLikeNotification': responsebody['Notificationssetting']
            ['liketweet'],
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<Map<String, dynamic>> getUserProfile(String id) async {
    http.Request request = http.Request(
      'GET',
      Uri.parse('$baseURL/profile/$id'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'id': responsebody['user']['_id'],
        'screenName': responsebody['user']['screenName'],
        'tag': responsebody['user']['tag'],
        'email': responsebody['user']['email'] ?? '',
        'avatarURL': responsebody['user']['profileAvater']['url'] ?? '',
        'bannerURL': responsebody['user']['banner']['url'] ?? '',
        'biography': responsebody['user']['Biography'] ?? '',
        'phoneNumber': responsebody['user']['phoneNumber'] ?? '',
        'website': responsebody['user']['website'] ?? '',
        'birthdate': (responsebody['user']['birth'] != null)
            ? DateTime.parse(responsebody['user']['birth']['date'] ?? '')
            : DateTime.now(),
        'birthdateVisibility': (responsebody['user']['birth'] != null)
            ? responsebody['user']['birth']['visability'] ?? true
            : true,
        //'location': (responsebody['user']['location'] != null) ? responsebody['user']['location']['place'] ?? '' : '',
        //'locationVisibility': (responsebody['user']['location'] != null) ? responsebody['user']['location']['visability'] ?? true : true,
        'isPrivate': responsebody['user']['isPrivate'],
        'followerCount': responsebody['user']['followercount'],
        'followingCount': responsebody['user']['followingcount'],
        'followed': responsebody['isfollowing'] ?? false,
        'followPending': responsebody['ispending'] ?? false,
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<Map<String, dynamic>> followUser(
      String followerID, String followingID, bool isFollowing) async {
    http.Request request = http.Request(
      'POST',
      Uri.parse(
          '$baseURL/user/$followerID/${(isFollowing) ? 'unfollow' : 'follow'}/$followingID'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'followed': !isFollowing,
      };
    } else {
      if ((isFollowing &&
              responsebody['error'] ==
                  'Error: you already unfollow that user') ||
          (!isFollowing &&
                  (responsebody['error'] ==
                      'Error: you already follow the user') ||
              responsebody['error'] ==
                  'Error: you already request the PrivateRequest')) {
        return {
          'followed': isFollowing,
        };
      } else {
        return {
          'error': responsebody['error'],
        };
      }
    }
  }

  static Future<Map<String, dynamic>> reportUser(
      String reporter, String reported, String message) async {
    http.Request request = http.Request(
      'POST',
      Uri.parse('$baseURL/user/report'),
    );
    request.body = json.encode({
      'type': 'User',
      'reporterId': reporter,
      'reportedId': reported,
      'msg': message,
    });
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 201) {
      return {
        'success': 'success',
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<Map<String, dynamic>> banUser_Admin(
      String id, int duration) async {
    http.Request request = http.Request(
      'POST',
      Uri.parse('$baseURL/admin/ban/$id'),
    );
    request.body = json.encode({
      'duration': duration,
    });
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.adminToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': 'success',
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<List<Map<String, dynamic>>> getUserTweets(String id) async {
    http.Request request = http.Request(
      'GET',
      Uri.parse('$baseURL/tweet/user/$id'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    if (response.statusCode == 200) {
      List<dynamic> responsebody = json.decode(response.body);

      List<Map<String, dynamic>> list = [];
      for (Map<String, dynamic> item in responsebody) {
        List<Map<String, String>> tags = [];
        for (Map<String, dynamic> tag in item['tags']) {
          tags.add((await profileTagToID(tag['tag'].substring(1)))
              .map((key, value) => MapEntry(key, value as String)));
        }

        List<String> images = [];
        for (Map<String, dynamic> image in item['gallery']) {
          images.add(image['photo']);
        }

        Map<String, dynamic> embeddedtweet = {};
        if (item['retweetedTweet']['tweetId'] != null) {
          List<Map<String, String>> tags = [];
          for (Map<String, dynamic> tag in item['retweetedTweet']['tweetId']
              ['tags']) {
            tags.add((await profileTagToID(tag['tag'].substring(1)))
                .map((key, value) => MapEntry(key, value as String)));
          }

          List<String> images = [];
          for (Map<String, dynamic> image in item['retweetedTweet']['tweetId']
              ['gallery']) {
            images.add(image['photo']);
          }

          embeddedtweet = {
            'id': item['retweetedTweet']['tweetId']['_id'],
            'ownerid': item['retweetedTweet']['tweetId']['authorId']['_id'],
            'avatarURL': item['retweetedTweet']['tweetId']['authorId']
                    ['profileAvater']['url'] ??
                '',
            'tag': item['retweetedTweet']['tweetId']['authorId']['tag'],
            'name': item['retweetedTweet']['tweetId']['authorId']['screenName'],
            'text': item['retweetedTweet']['tweetId']['text'] ?? '',
            'retweetcount': item['retweetedTweet']['tweetId']['retweetCount'],
            'likecount': item['retweetedTweet']['tweetId']['likeCount'],
            'tags': tags,
            'images': images,
          };
        }

        List<Map<String, dynamic>> replies = [];

        list.add({
          'id': item['_id'],
          'ownerid': item['authorId']['_id'],
          'avatarURL': item['authorId']['profileAvater']['url'] ?? '',
          'tag': item['authorId']['tag'],
          'name': item['authorId']['screenName'],
          'text': item['text'] ?? '',
          'postdate': DateTime.parse(item['createdAt']),
          'replycount': item['replyCount'],
          'retweetcount': item['retweetCount'],
          'likecount': item['likeCount'],
          'liked': item['isliked'],
          'tags': tags,
          'images': images,
          'embeddedtweet': embeddedtweet,
          'embeddedtweetdeleted': item['retweetedTweet']['tweetExisted'],
          'replies': replies
        });
      }

      return list;
    } else {
      Map<String, dynamic> responsebody = json.decode(response.body);

      return [
        {'error': responsebody['error']}
      ];
    }
  }

  static Future<List<Map<String, dynamic>>> getUserLikes(String id) async {
    http.Request request = http.Request(
      'GET',
      Uri.parse('$baseURL/profile/likedtweets/$id'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    if (response.statusCode == 200) {
      List<dynamic> responsebody = json.decode(response.body);

      List<Map<String, dynamic>> list = [];
      for (Map<String, dynamic> item in responsebody) {
        List<Map<String, String>> tags = [];
        for (Map<String, dynamic> tag in item['tags']) {
          tags.add((await profileTagToID(tag['tag'].substring(1)))
              .map((key, value) => MapEntry(key, value as String)));
        }

        List<String> images = [];
        for (Map<String, dynamic> image in item['gallery']) {
          images.add(image['photo']);
        }

        Map<String, dynamic> embeddedtweet = {};
        if (item['retweetedTweet']['tweetId'] != null) {
          List<Map<String, String>> tags = [];
          for (Map<String, dynamic> tag in item['retweetedTweet']['tweetId']
              ['tags']) {
            tags.add((await profileTagToID(tag['tag'].substring(1)))
                .map((key, value) => MapEntry(key, value as String)));
          }

          List<String> images = [];
          for (Map<String, dynamic> image in item['retweetedTweet']['tweetId']
              ['gallery']) {
            images.add(image['photo']);
          }

          embeddedtweet = {
            'id': item['retweetedTweet']['tweetId']['_id'],
            'ownerid': item['retweetedTweet']['tweetId']['authorId']['_id'],
            'avatarURL': item['retweetedTweet']['tweetId']['authorId']
                    ['profileAvater']['url'] ??
                '',
            'tag': item['retweetedTweet']['tweetId']['authorId']['tag'],
            'name': item['retweetedTweet']['tweetId']['authorId']['screenName'],
            'text': item['retweetedTweet']['tweetId']['text'] ?? '',
            'retweetcount': item['retweetedTweet']['tweetId']['retweetCount'],
            'likecount': item['retweetedTweet']['tweetId']['likeCount'],
            'tags': tags,
            'images': images,
          };
        }

        List<Map<String, dynamic>> replies = [];

        list.add({
          'id': item['_id'],
          'ownerid': item['authorId']['_id'],
          'avatarURL': item['authorId']['profileAvater']['url'] ?? '',
          'tag': item['authorId']['tag'],
          'name': item['authorId']['screenName'],
          'text': item['text'] ?? '',
          'postdate': DateTime.parse(item['createdAt']),
          'replycount': item['replyCount'],
          'retweetcount': item['retweetCount'],
          'likecount': item['likeCount'],
          'liked': item['isliked'],
          'tags': tags,
          'images': images,
          'embeddedtweet': embeddedtweet,
          'embeddedtweetdeleted': item['retweetedTweet']['tweetExisted'],
          'replies': replies
        });
      }

      return list;
    } else {
      Map<String, dynamic> responsebody = json.decode(response.body);

      return [
        {'error': responsebody['error']}
      ];
    }
  }

  static Future<List<Map<String, dynamic>>> getUserMedia(String id) async {
    http.Request request = http.Request(
      'GET',
      Uri.parse('$baseURL/profile/media/$id'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    if (response.statusCode == 200) {
      List<dynamic> responsebody = json.decode(response.body);

      List<Map<String, dynamic>> list = [];
      for (Map<String, dynamic> item in responsebody) {
        List<Map<String, String>> tags = [];
        for (Map<String, dynamic> tag in item['tags']) {
          tags.add((await profileTagToID(tag['tag'].substring(1)))
              .map((key, value) => MapEntry(key, value as String)));
        }

        List<String> images = [];
        for (Map<String, dynamic> image in item['gallery']) {
          images.add(image['photo']);
        }

        Map<String, dynamic> embeddedtweet = {};
        if (item['retweetedTweet']['tweetId'] != null) {
          List<Map<String, String>> tags = [];
          for (Map<String, dynamic> tag in item['retweetedTweet']['tweetId']
              ['tags']) {
            tags.add((await profileTagToID(tag['tag'].substring(1)))
                .map((key, value) => MapEntry(key, value as String)));
          }

          List<String> images = [];
          for (Map<String, dynamic> image in item['retweetedTweet']['tweetId']
              ['gallery']) {
            images.add(image['photo']);
          }

          embeddedtweet = {
            'id': item['retweetedTweet']['tweetId']['_id'],
            'ownerid': item['retweetedTweet']['tweetId']['authorId']['_id'],
            'avatarURL': item['retweetedTweet']['tweetId']['authorId']
                    ['profileAvater']['url'] ??
                '',
            'tag': item['retweetedTweet']['tweetId']['authorId']['tag'],
            'name': item['retweetedTweet']['tweetId']['authorId']['screenName'],
            'text': item['retweetedTweet']['tweetId']['text'] ?? '',
            'retweetcount': item['retweetedTweet']['tweetId']['retweetCount'],
            'likecount': item['retweetedTweet']['tweetId']['likeCount'],
            'tags': tags,
            'images': images,
          };
        }

        List<Map<String, dynamic>> replies = [];

        list.add({
          'id': item['_id'],
          'ownerid': item['authorId']['_id'],
          'avatarURL': item['authorId']['profileAvater']['url'] ?? '',
          'tag': item['authorId']['tag'],
          'name': item['authorId']['screenName'],
          'text': item['text'] ?? '',
          'postdate': DateTime.parse(item['createdAt']),
          'replycount': item['replyCount'],
          'retweetcount': item['retweetCount'],
          'likecount': item['likeCount'],
          'liked': item['isliked'],
          'tags': tags,
          'images': images,
          'embeddedtweet': embeddedtweet,
          'embeddedtweetdeleted': item['retweetedTweet']['tweetExisted'],
          'replies': replies
        });
      }

      return list;
    } else {
      Map<String, dynamic> responsebody = json.decode(response.body);

      return [
        {'error': responsebody['error']}
      ];
    }
  }

  static Future<List<Map<String, dynamic>>> getUserFollowers(String id) async {
    http.Request request = http.Request(
      'GET',
      Uri.parse('$baseURL/user/$id/follower'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    if (response.statusCode == 200) {
      List<dynamic> responsebody = json.decode(response.body);

      List<Map<String, dynamic>> list = [];
      for (Map<String, dynamic> item in responsebody) {
        list.add({
          'id': item['_id'],
          'screenName': item['screenName'],
          'tag': item['tag'],
          'avatarURL': item['profileAvater']['url'] ?? '',
          'followed': item['isfollowing'],
          'followPending': item['ispending'],
        });
      }

      return list;
    } else {
      Map<String, dynamic> responsebody = json.decode(response.body);

      return [
        {'error': responsebody['error']}
      ];
    }
  }

  static Future<List<Map<String, dynamic>>> getUserFollowings(String id) async {
    http.Request request = http.Request(
      'GET',
      Uri.parse('$baseURL/user/$id/following'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    if (response.statusCode == 200) {
      List<dynamic> responsebody = json.decode(response.body);

      List<Map<String, dynamic>> list = [];
      for (Map<String, dynamic> item in responsebody) {
        list.add({
          'id': item['followingId']['_id'],
          'screenName': item['followingId']['screenName'],
          'tag': item['followingId']['tag'],
          'avatarURL': item['followingId']['profileAvater']['url'] ?? '',
          'followed': item['isfollowing'],
          'followPending': item['ispending'],
        });
      }

      return list;
    } else {
      Map<String, dynamic> responsebody = json.decode(response.body);

      return [
        {'error': responsebody['error']}
      ];
    }
  }

  static Future<List<Map<String, dynamic>>> getUserFollowRequests() async {
    http.Request request = http.Request(
      'GET',
      Uri.parse('$baseURL/privateRequest'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    if (response.statusCode == 200) {
      List<dynamic> responsebody = json.decode(response.body);

      List<Map<String, dynamic>> list = [];
      for (Map<String, dynamic> item in responsebody) {
        list.add({
          'requestid': item['_id'],
          'id': item['requestUser']['_id'],
          'screenName': item['requestUser']['screenName'],
          'tag': item['requestUser']['tag'],
          'avatarURL': item['requestUser']['profileAvater']['url'] ?? '',
        });
      }

      return list;
    } else {
      Map<String, dynamic> responsebody = json.decode(response.body);

      return [
        {'error': responsebody['error']}
      ];
    }
  }

  static Future<Map<String, dynamic>> acceptFollowRequest(String id) async {
    http.Request request = http.Request(
      'GET',
      Uri.parse('$baseURL/acceptRequest/$id'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': 'success',
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<Map<String, dynamic>> declineFollowRequest(String id) async {
    http.Request request = http.Request(
      'GET',
      Uri.parse('$baseURL/denyRequest/$id'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': 'success',
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<List<Map<String, dynamic>>> searchTweets(
      String text, bool filter) async {
    http.Request request = http.Request(
      'GET',
      Uri.parse('$baseURL/search/$text?followerfilter=$filter'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    if (response.statusCode == 200) {
      List<dynamic> responsebody = (json.decode(response.body))['Tweets'];

      List<Map<String, dynamic>> list = [];
      for (Map<String, dynamic> item in responsebody) {
        List<Map<String, String>> tags = [];
        for (Map<String, dynamic> tag in item['tags']) {
          tags.add((await profileTagToID(tag['tag'].substring(1)))
              .map((key, value) => MapEntry(key, value as String)));
        }

        List<String> images = [];
        for (Map<String, dynamic> image in item['gallery']) {
          images.add(image['photo']);
        }

        Map<String, dynamic> embeddedtweet = {};
        if (item['retweetedTweet']['tweetId'] != null) {
          List<Map<String, String>> tags = [];
          for (Map<String, dynamic> tag in item['retweetedTweet']['tweetId']
              ['tags']) {
            tags.add((await profileTagToID(tag['tag'].substring(1)))
                .map((key, value) => MapEntry(key, value as String)));
          }

          List<String> images = [];
          for (Map<String, dynamic> image in item['retweetedTweet']['tweetId']
              ['gallery']) {
            images.add(image['photo']);
          }

          embeddedtweet = {
            'id': item['retweetedTweet']['tweetId']['_id'],
            'ownerid': item['retweetedTweet']['tweetId']['authorId']['_id'],
            'avatarURL': item['retweetedTweet']['tweetId']['authorId']
                    ['profileAvater']['url'] ??
                '',
            'tag': item['retweetedTweet']['tweetId']['authorId']['tag'],
            'name': item['retweetedTweet']['tweetId']['authorId']['screenName'],
            'text': item['retweetedTweet']['tweetId']['text'] ?? '',
            'retweetcount': item['retweetedTweet']['tweetId']['retweetCount'],
            'likecount': item['retweetedTweet']['tweetId']['likeCount'],
            'tags': tags,
            'images': images,
          };
        }

        List<Map<String, dynamic>> replies = [];

        list.add({
          'id': item['_id'],
          'ownerid': item['authorId']['_id'],
          'avatarURL': item['authorId']['profileAvater']['url'] ?? '',
          'tag': item['authorId']['tag'],
          'name': item['authorId']['screenName'],
          'text': item['text'] ?? '',
          'postdate': DateTime.parse(item['createdAt']),
          'replycount': item['replyCount'],
          'retweetcount': item['retweetCount'],
          'likecount': item['likeCount'],
          'liked': item['isliked'],
          'tags': tags,
          'images': images,
          'embeddedtweet': embeddedtweet,
          'embeddedtweetdeleted': item['retweetedTweet']['tweetExisted'],
          'replies': replies,
        });
      }

      return list;
    } else {
      Map<String, dynamic> responsebody = json.decode(response.body);

      return [
        {'error': responsebody['error']}
      ];
    }
  }

  static Future<List<Map<String, dynamic>>> searchUsers(
      String text, bool filter) async {
    http.Request request = http.Request(
      'GET',
      Uri.parse('$baseURL/search/$text?followerfilter=$filter'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    if (response.statusCode == 200) {
      List<dynamic> responsebody = (json.decode(response.body))['Users'];

      List<Map<String, dynamic>> list = [];
      for (Map<String, dynamic> item in responsebody) {
        list.add({
          'id': item['_id'],
          'screenName': item['screenName'],
          'tag': item['tag'],
          'avatarURL': item['profileAvater']['url'] ?? '',
        });
      }

      return list;
    } else {
      Map<String, dynamic> responsebody = json.decode(response.body);

      return [
        {'error': responsebody['error']}
      ];
    }
  }

  static Future<List<Map<String, dynamic>>> getNotifications() async {
    http.Request request = http.Request(
      'GET',
      Uri.parse('$baseURL/notification'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> list = [];
      for (Map<String, dynamic> item in responsebody['notifications']) {
        list.add({
          'id': item['_id'],
          'ownerid': item['userId']['_id'],
          'avatarURL': item['userId']['profileAvater']['url'] ?? '',
          'tag': item['userId']['tag'],
          'name': item['userId']['screenName'],
          'text': item['text'] ?? '',
          'receiveddate': DateTime.parse(item['createdAt']),
        });
      }

      return list;
    } else {
      return [
        {'error': responsebody['error']}
      ];
    }
  }

  static Future<Map<String, dynamic>> deleteNotification(String id) async {
    http.Request request = http.Request(
      'DELETE',
      Uri.parse('$baseURL/notification/$id'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': 'successfully deleted',
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<Map<String, dynamic>> changePassword(
      String id, String currentPassword, String newPassword) async {
    http.Request request = http.Request(
      'PUT',
      Uri.parse('$baseURL/profile/$id/password'),
    );
    request.body = json.encode({
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    });
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': 'Data changed',
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<Map<String, dynamic>> setIsPrivate(
      String id, bool isPrivate) async {
    http.Request request = http.Request(
      'PUT',
      Uri.parse('$baseURL/profile/$id'),
    );
    request.body = json.encode({
      'isPrivate': isPrivate,
    });
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': 'Data changed',
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<Map<String, dynamic>> changeNotifications(
      String id,
      bool newFollowNotification,
      bool newTweetNotification,
      bool newLikeNotification) async {
    http.Request request = http.Request(
      'PUT',
      Uri.parse('$baseURL/profile/$id'),
    );
    request.body = json.encode({
      'Notificationssetting': {
        'newfollow': newFollowNotification,
        'newtweet': newTweetNotification,
        'liketweet': newLikeNotification,
      },
    });
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': 'Data changed',
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<Map<String, dynamic>> setDarkMode(
      String id, bool darkMode) async {
    http.Request request = http.Request(
      'PUT',
      Uri.parse('$baseURL/profile/$id'),
    );
    request.body = json.encode({
      'darkMode': darkMode,
    });
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': 'Data changed',
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<Map<String, dynamic>> logout() async {
    http.Request request = http.Request(
      'DELETE',
      Uri.parse('$baseURL/user/logout'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': responsebody['success'],
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<Map<String, dynamic>> logoutAll() async {
    http.Request request = http.Request(
      'DELETE',
      Uri.parse('$baseURL/user/logoutall'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': responsebody['success'],
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<Map<String, dynamic>> editProfile(String id, String screenName,
      String phoneNumber, String website, String biography) async {
    http.Request request = http.Request(
      'PUT',
      Uri.parse('$baseURL/profile/$id'),
    );
    request.body = json.encode({
      'screenName': screenName,
      'phoneNumber': phoneNumber,
      'website': website,
      'Biography': biography,
    });
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': 'Data changed',
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<Map<String, dynamic>> setBirthdate(
      String id, bool birthdateVisibility) async {
    http.Request request = http.Request(
      'PUT',
      Uri.parse('$baseURL/profile/$id'),
    );
    request.body = json.encode({
      'birth': {
        'visability': birthdateVisibility,
      },
    });
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': 'Data changed',
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<Map<String, dynamic>> setLocation(
    String id,
    String location,
    bool locationVisibility,
  ) async {
    http.Request request = http.Request(
      'PUT',
      Uri.parse('$baseURL/profile/$id'),
    );
    request.body = json.encode({
      'location': {
        'place': location,
        'visability': locationVisibility,
      },
    });
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': 'Data changed',
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<Map<String, dynamic>> editAvatar(String id, File image) async {
    http.MultipartRequest request = http.MultipartRequest(
      'PUT',
      Uri.parse('$baseURL/profile/$id/avater'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });
    request.files.add(await http.MultipartFile.fromPath('image', image.path));

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': 'Data changed',
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<Map<String, dynamic>> removeAvatar(String id) async {
    http.Request request = http.Request(
      'DELETE',
      Uri.parse('$baseURL/profile/$id/avater'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': 'Data changed',
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<Map<String, dynamic>> editBanner(String id, File image) async {
    http.MultipartRequest request = http.MultipartRequest(
      'PUT',
      Uri.parse('$baseURL/profile/$id/banner'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });
    request.files.add(await http.MultipartFile.fromPath('image', image.path));

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': 'Data changed',
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }

  static Future<Map<String, dynamic>> removeBanner(String id) async {
    http.Request request = http.Request(
      'DELETE',
      Uri.parse('$baseURL/profile/$id/banner'),
    );
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': MyProfile.userToken,
    });

    http.Response response = await http.Response.fromStream(
        await (mocked ? _mockClient.send(request) : _client.send(request)));

    Map<String, dynamic> responsebody = json.decode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': 'Data changed',
      };
    } else {
      return {
        'error': responsebody['error'],
      };
    }
  }
}
