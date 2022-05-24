import 'NetworkHandler.dart';

class MyProfile {
  static String userToken = '';
  static String adminToken = '';

  static String id = '';
  static String screenName = '';
  static String tag = '';
  static String email = '';
  static String avatarURL = '';
  static String bannerURL = '';
  static String biography = '';
  static String phoneNumber = '';
  static String website = '';
  static DateTime birthdate = DateTime.now();
  static bool birthdateVisibility = false;
  static String location = '';
  static bool locationVisibility = false;
  static bool isPrivate = false;
  static int followerCount = 0;
  static int followingCount = 0;

  static bool newFollowNotification = false;
  static bool newTweetNotification = false;
  static bool newLikeNotification = false;

  static Future<bool> updateProfile() async {
    Map<String, dynamic> myProfileInfo = await NetworkHandler.getMyProfile(id);

    if (myProfileInfo['error'] == null) {
      id = myProfileInfo['id'];
      screenName = myProfileInfo['screenName'];
      tag = myProfileInfo['tag'];
      email = myProfileInfo['email'];
      avatarURL = myProfileInfo['avatarURL'];
      bannerURL = myProfileInfo['bannerURL'];
      biography = myProfileInfo['biography'];
      phoneNumber = myProfileInfo['phoneNumber'];
      website = myProfileInfo['website'];
      birthdate = myProfileInfo['birthdate'];
      birthdateVisibility = myProfileInfo['birthdateVisibility'];
      //location = myProfileInfo['location'];
      //locationVisibility = myProfileInfo['locationVisibility'];
      isPrivate = myProfileInfo['isPrivate'];
      followerCount = myProfileInfo['followerCount'];
      followingCount = myProfileInfo['followingCount'];

      newFollowNotification = myProfileInfo['newFollowNotification'];
      newTweetNotification = myProfileInfo['newTweetNotification'];
      newLikeNotification = myProfileInfo['newLikeNotification'];

      return true;
    } else {
      return false;
    }
  }
}

class UserProfile {
  String id = '';
  String screenName = '';
  String tag = '';
  String email = '';
  bool isPrivate = false;
  String avatarURL = '';
  String bannerURL = '';
  String biography = '';
  String phoneNumber = '';
  String website = '';
  DateTime birthdate = DateTime.now();
  bool birthdateVisibility = false;
  String location = '';
  bool locationVisibility = false;
  int followerCount = 0;
  int followingCount = 0;

  bool followed = false;
  bool followPending = false;

  UserProfile({required this.id});

  Future<bool> updateProfile() async {
    Map<String, dynamic> profileInfo = await NetworkHandler.getUserProfile(id);
    if (profileInfo['error'] == null) {
      id = profileInfo['id'];
      screenName = profileInfo['screenName'];
      tag = profileInfo['tag'];
      email = profileInfo['email'];
      avatarURL = profileInfo['avatarURL'];
      bannerURL = profileInfo['bannerURL'];
      isPrivate = profileInfo['isPrivate'];
      biography = profileInfo['biography'];
      phoneNumber = profileInfo['phoneNumber'];
      website = profileInfo['website'];
      birthdate = profileInfo['birthdate'];
      birthdateVisibility = profileInfo['birthdateVisibility'];
      //location = profileInfo['location'];
      //locationVisibility = profileInfo['locationVisibility'];
      followerCount = profileInfo['followerCount'];
      followingCount = profileInfo['followingCount'];

      followed = profileInfo['followed'];
      followPending = profileInfo['followPending'];

      return true;
    } else {
      return false;
    }
  }
}
