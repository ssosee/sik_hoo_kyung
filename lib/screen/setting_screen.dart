import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final InAppReview inAppReview = InAppReview.instance;

  Future<void> _requestReview() async {
    if (await inAppReview.isAvailable()) {
      await inAppReview.requestReview();
    } else {
      await _openStoreListing();
    }
  }

  Future<void> _openStoreListing() async {
    await inAppReview.openStoreListing(appStoreId: 'com.sikhookyung');
  }

  Future<void> _sendFeedback() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'howisitgoing@kakao.com',
      query: _encodeQueryParameter({
        'subject': '식후경 앱 피드백',
        'body':
            '우와!!! 소중한 피드백 감사합니다.\n'
            '편안한 마음으로 피드백 내용을 작성해주세요! 🙂',
      }),
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('이메일 앱을 열 수 없습니다. 🥲')));
      }
    }
  }

  String _encodeQueryParameter(Map<String, String> params) {
    return params.entries
        .map((entry) => '${Uri.encodeComponent(entry.key)}')
        .join('&');
  }

  Future<void> _openSupportLink() async {
    final url = Uri.parse('https://buymeacoffee.com/ralph_jang');

    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('링크를 열 수 없습니다')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.email_outlined),
          title: const Text('이메일로 피드백 남기기'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: _sendFeedback,
        ),
        ListTile(
          leading: const Icon(Icons.star_outline),
          title: const Text('앱 별점 주기'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: _requestReview,
        ),
        // ListTile(
        //   leading: const Icon(Icons.coffee),
        //   title: const Text('개발자 응원하기 🤗'),
        //   trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        //   onTap: _openSupportLink,
        // ),
        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('앱 버전'),
          subtitle: const Text('v1.0.0'),
        ),
      ],
    );
  }
}
