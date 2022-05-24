import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:provider/provider.dart';

import 'ThemeHandler.dart';

import 'pages/landing_page.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/viewtweet_page.dart';
import 'pages/timeline_page.dart';
import 'pages/explore_page.dart';
import 'pages/posttweet_page.dart';
import 'pages/profile_page.dart';
import 'pages/search_page.dart';
import 'pages/notifications_page.dart';
import 'pages/settings_page.dart';
import 'pages/editprofile_page.dart';
import 'pages/admin_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            physics: const BouncingScrollPhysics(),
            dragDevices: const {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
            },
          ),
          theme: theme.light,
          darkTheme: theme.dark,
          themeMode:
              theme.getTheme() == false ? ThemeMode.light : ThemeMode.dark,
          initialRoute: '/Welcome',
          routes: {
            '/Welcome': (context) => const Landing_Page(),
            '/Login': (context) => const Login_Page(),
            '/SignUp': (context) => const SignUp_Page(),
            '/View': (context) => const ViewTweet_Page(),
            '/Home': (context) => const Timeline_Page(),
            '/Explore': (context) => const Explore_Page(),
            '/Post': (context) => const PostTweet_Page(),
            '/Profile': (context) => const Profile_Page(),
            '/Search': (context) => const Search_Page(),
            '/Notifications': (context) => const Notifications_Page(),
            '/Settings': (context) => const Settings_Page(),
            '/Settings/EditProfile': (context) => const EditProfile_Page(),
            '/Admin': (context) => const Admin_Page(),
          },
        ),
      ),
    ),
  );
}
