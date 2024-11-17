import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/timer_ctrl.dart';

class TimerIcon extends StatefulWidget {
  final int postId;
  final int initialDuration;

  TimerIcon({required this.postId, required this.initialDuration});

  @override
  _TimerIconState createState() => _TimerIconState();
}

class _TimerIconState extends State<TimerIcon> {
  late TimerController timerController;

  @override
  void initState() {
    super.initState();
    timerController = Get.find<TimerController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      timerController.initializeTimer(widget.postId, widget.initialDuration);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final remainingTime = timerController.timerDurations[widget.postId] ?? widget.initialDuration;
      return Row(
        children: [
          const Icon(Icons.timer, size: 24),
          Text(
            remainingTime > 0 ? '$remainingTime s' : 'Done',
            style: const TextStyle(fontSize: 14),
          ),
        ],
      );
    });
  }
}
