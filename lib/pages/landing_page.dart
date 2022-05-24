import 'package:flutter/material.dart';

import '../NetworkHandler.dart';

class Landing_Page extends StatefulWidget {
  const Landing_Page({Key? key}) : super(key: key);

  @override
  State<Landing_Page> createState() => _Landing_PageState();
}

class _Landing_PageState extends State<Landing_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'LARRY',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                const Text(
                  'See what\'s happening in the world right now.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox.square(
                  dimension: 300,
                  child: Image(
                    image: AssetImage('assets/logo.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/Login');
                    },
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      minimumSize: Size.zero,
                      fixedSize: const Size(220, 60),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/SignUp');
                    },
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      minimumSize: Size.zero,
                      fixedSize: const Size(220, 60),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: OutlinedButton(
                      onPressed: () {
                        NetworkHandler.mocked = !NetworkHandler.mocked;
                        setState(() {});
                      },
                      style: OutlinedButton.styleFrom(
                        shape: const CircleBorder(),
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.all(5),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Icon(
                        Icons.developer_mode,
                        size: 20,
                        color:
                            NetworkHandler.mocked ? Colors.green : Colors.grey,
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
  }
}
