import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/journal_controller.dart';

class JournalView extends GetView<JournalController> {
  const JournalView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JournalView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'JournalView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
