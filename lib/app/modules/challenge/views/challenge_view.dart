import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/challenge_controller.dart';

class ChallengeView extends GetView<ChallengeController> {
  const ChallengeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChallengeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ChallengeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
