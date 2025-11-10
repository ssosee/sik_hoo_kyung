import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sik_hoo_kyung/utils/time_provider.dart';

class CompleteWalkingSummaryScreen extends StatefulWidget {
  final int completeSecond;

  const CompleteWalkingSummaryScreen({super.key, required this.completeSecond});

  @override
  State<CompleteWalkingSummaryScreen> createState() =>
      _CompleteWalkingSummaryScreenState();
}

class _CompleteWalkingSummaryScreenState
    extends State<CompleteWalkingSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    // 시간 기반 추정값
    double estimatedDistance =
        (widget.completeSecond / 60) * 0.08; // 시속 4.8km 가정
    int estimatedSteps = (widget.completeSecond * 1.5).round(); // 초당 1.5걸음 가정

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 캐릭터 영역
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                child: Lottie.asset(
                  'assets/animations/confetti.json',
                  width: 300,
                  height: 300,
                  repeat: true,
                ),
              ),
            ),

            // 산책 정보 영역
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 산책시간 박스
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '⏰ 산책시간',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 12),
                            TweenAnimationBuilder<int>(
                              tween: IntTween(
                                begin: 0,
                                end: widget.completeSecond,
                              ),
                              duration: Duration(seconds: 2),
                              curve: Curves.easeOutCubic,
                              builder: (context, value, child) {
                                return Text(
                                  TimeProvider.formatTime(value),
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 16),

                    // 거리와 걸음수
                    Expanded(
                      child: Row(
                        children: [
                          // 거리 박스
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '🔥 거리',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  TweenAnimationBuilder<double>(
                                    tween: Tween<double>(
                                      begin: 0.0,
                                      end: estimatedDistance,
                                    ),
                                    duration: Duration(seconds: 2),
                                    curve: Curves.easeOutCubic,
                                    builder: (context, value, child) {
                                      return Text(
                                        '${value.toStringAsFixed(2)} km',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 16),

                          // 걸음수 박스
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(243, 135, 243, 255),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '🐾 걸음수',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  TweenAnimationBuilder<int>(
                                    tween: IntTween(
                                      begin: 0,
                                      end: estimatedSteps,
                                    ),
                                    duration: Duration(seconds: 2),
                                    curve: Curves.easeOutCubic,
                                    builder: (context, value, child) {
                                      return Text(
                                        NumberFormat('#,###').format(value),
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 완료 버튼 영역
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all(
                      Size(double.infinity, 50),
                    ),
                    backgroundColor: WidgetStateProperty.all(Colors.orange),
                    foregroundColor: WidgetStateProperty.all(Colors.black87),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  child: Text(
                    '완료',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
