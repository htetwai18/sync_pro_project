import 'package:flutter/material.dart';
import 'package:sync_pro/presentation/admin/screen/approval_queue_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: const ApprovalQueueScreen(),
    );
  }
}
