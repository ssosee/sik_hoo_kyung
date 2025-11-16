import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:sik_hoo_kyung/component/bottom_button.dart';
import 'package:sik_hoo_kyung/screen/complete_walking_summary_screen.dart';
import 'package:sik_hoo_kyung/screen/popup_screen.dart';
import 'package:sik_hoo_kyung/utils/time_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  String buttonText = '산책하기';
  String assetsAnimation = 'assets/animations/beautiful-city.json';
  bool isWalking = false;
  int seconds = 0;
  Timer? timer;
  late AnimationController _lottiController;
  bool _isLottieLoaded = false; // 추가: Lottie 로드 완료 여부

  @override
  void initState() {
    super.initState();
    _lottiController = AnimationController(vsync: this);
  }

  Future<void> _showCompleteWalkingBottomSheet() async {
    HapticFeedback.mediumImpact();

    _lottiController.stop();

    final result = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return PopupScreen(seconds: seconds);
      },
    );
    // 사용자가 완료를 선택한 경우에만 화면 전환
    if (result == true) {
      setState(() {
        buttonText = '산책하기';
        assetsAnimation = 'assets/animations/beautiful-city.json';
        isWalking = false;
        _isLottieLoaded = false;
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
      // 취소한 경우 타이머 재시작
      if (isWalking) {
        _startTimer();
        _lottiController.repeat();
      }
    }
  }

  void onWalk() async {
    if (isWalking) {
      HapticFeedback.mediumImpact();
      timer?.cancel();
      // 바텀 시트 표시
      await _showCompleteWalkingBottomSheet();
    } else {
      // 산책 시작
      setState(() {
        buttonText = '산책 끝';
        assetsAnimation = 'assets/animations/walking-man.json';
        isWalking = true;
        seconds = 0;
        _isLottieLoaded = false;
      });
      _startTimer();
    }
  }

  // 타이머 시작
  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        seconds++;
      });
    });
  }

  @override
  void dispose() {
    _lottiController.dispose();
    timer?.cancel();
    timer = null;
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
                      controller: _lottiController,
                      onLoaded: (composition) {
                        _lottiController.duration = composition.duration;
                        _isLottieLoaded = true;
                        if (isWalking) {
                          _lottiController.repeat();
                        }
                      },
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 5,
                    ),
                    child: Text(
                      TimeProvider.formatTime(seconds),
                      style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                BottomButton(
                  onClick: onWalk,
                  buttonText: buttonText,
                  backgroundColor: Colors.greenAccent,
                  foregroundColor: Colors.black87,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// tamtaneng
