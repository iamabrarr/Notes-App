import 'dart:async';
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/utils/size_config.dart';
import 'package:notes/views/constants/consts.dart';
import 'package:notes/views/constants/images.dart';
import 'package:notes/views/pages/MyNotes/my_notes_page.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 3200), () => Get.offAll(() => MyNotes()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Image.asset(
                splash,
                height: SizeConfig.imageSizeMultiplier * 35,
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 2,
            ),
            DefaultTextStyle(
              style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: kSecondaryColor, fontWeight: FontWeight.w500),
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(
                    'My Notes',
                  ),
                ],
                isRepeatingAnimation: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
