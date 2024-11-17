import 'dart:async';
import 'package:get/get.dart';

class TimerController extends GetxController {
  final Map<int, int> timerDurations = <int, int>{}.obs; // Stores remaining time
  final Map<int, bool> timerActive = <int, bool>{}.obs;  // Active/Paused state
  final Map<int, Timer?> timers = {};                   // Actual timers

  void initializeTimer(int postId, int initialDuration) {
    if (!timerDurations.containsKey(postId)) {
      timerDurations[postId] = initialDuration;
      timerActive[postId] = true;
      startTimer(postId);
    }
  }

  void startTimer(int postId) {
    if (timerActive[postId] == true && (timers[postId] == null || !timers[postId]!.isActive)) {
      timers[postId] = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (timerDurations[postId]! > 0) {
          timerDurations[postId] = timerDurations[postId]! - 1;
        } else {
          timer.cancel();
          timerActive[postId] = false;
        }
      });
    }
  }

  void pauseTimer(int postId) {
    if (timers[postId]?.isActive == true) {
      timers[postId]?.cancel();
      timerActive[postId] = false;
    }
  }

  void resumeTimer(int postId) {
    if (timerDurations[postId]! > 0 && timerActive[postId] == false) {
      timerActive[postId] = true;
      // start timer from previous time
      startTimer(postId);
    }
  }

  bool isTimerDone(int postId) {
    return timerDurations[postId] == 0;
  }

  @override
  void onClose() {
    timers.values.forEach((timer) => timer?.cancel());
    super.onClose();
  }
}
