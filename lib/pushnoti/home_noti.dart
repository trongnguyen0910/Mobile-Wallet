import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeNoti extends StatelessWidget {
  final String message;

  const HomeNoti({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = json.decode(message);
    String title = data['notification']['title'];
    String content = data['notification']['content'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              content,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
