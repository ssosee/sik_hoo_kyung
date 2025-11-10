import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sik_hoo_kyung/screen/complete_walking_summary_screen.dart';
import 'package:sik_hoo_kyung/utils/time_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String buttonText = '산책하기';
  String assetsAnimation = 'assets/animations/beautiful-city.json';
  bool isWalking = false;
  int seconds = 0;
  Timer? timer;

  void onWalk() async {
    if (isWalking) {
      setState(() {
        // 산책 종료
        buttonText = '산책하기';
        assetsAnimation = 'assets/animations/beautiful-city.json';
        isWalking = false;
        timer?.cancel();
      });

      final completeSecond = seconds;
      seconds = 0;

      // 산책 완료 화면
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              CompleteWalkingSummaryScreen(completeSecond: completeSecond),
        ),
      );
    } else {
      // 산책 시작
      setState(() {
        buttonText = '산책 끝';
        assetsAnimation = 'assets/animations/walking-man.json';
        isWalking = true;
        seconds = 0;
        timer = Timer.periodic(Duration(seconds: 1), (timer) {
          setState(() {
            seconds++;
          });
        });
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 3,
          child: Container(
            alignment: Alignment.center,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 700),
              transitionBuilder: (Widget child, Animation<double> animation) {
                // 줌인 + 페이드 효과
                return ScaleTransition(
                  scale: animation,
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: isWalking
                  ? Lottie.asset(
                      assetsAnimation,
                      key: const ValueKey('first'),
                      width: 260,
                      height: 260,
                    )
                  : Lottie.asset(
                      assetsAnimation,
                      key: const ValueKey('second'),
                      repeat: false,
                      width: 400,
                      height: 400,
                    ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isWalking)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      TimeProvider.formatTime(seconds),
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ElevatedButton(
                  onPressed: onWalk,
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all(
                      Size(double.infinity, 50),
                    ),
                  ),
                  child: Text(buttonText, style: TextStyle(fontSize: 30)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
