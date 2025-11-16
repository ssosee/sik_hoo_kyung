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
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  String buttonText = '산책하기';
  String assetsAnimation = 'assets/animations/beautiful-city.json';
  bool isWalking = false;
  int seconds = 0;
  Timer? timer;
  late AnimationController _lottiController;
  bool _isLottieLoaded = false;

  // 추가: 산책 시작 시간 저장
  DateTime? _walkingStartTime;

  @override
  void initState() {
    super.initState();
    _lottiController = AnimationController(vsync: this);
    // 앱 생명주기 관찰자 등록
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _lottiController.dispose();
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  // 앱 생명주기 변경 감지
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed &&
        isWalking &&
        _walkingStartTime != null) {
      // 앱이 다시 활성화되면 경과 시간 재계산
      _updateElapsedTime();
    }
  }

  // 경과 시간 업데이트
  void _updateElapsedTime() {
    if (_walkingStartTime != null) {
      final elapsed = DateTime.now().difference(_walkingStartTime!);
      setState(() {
        seconds = elapsed.inSeconds;
      });
    }
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
      _walkingStartTime = null; // 시작 시간 초기화

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              CompleteWalkingSummaryScreen(completeSecond: completeSecond),
        ),
      );
    } else {
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
      await _showCompleteWalkingBottomSheet();
    } else {
      // 산책 시작
      setState(() {
        buttonText = '산책 끝';
        assetsAnimation = 'assets/animations/walking-man.json';
        isWalking = true;
        seconds = 0;
        _isLottieLoaded = false;
        _walkingStartTime = DateTime.now(); // 시작 시간 저장
      });
      _startTimer();
    }
  }

  // 타이머 시작 (UI 업데이트용)
  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateElapsedTime();
    });
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
            padding: const EdgeInsets.symmetric(horizontal: 40),
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
                      style: const TextStyle(
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
