import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/timer_ctrl.dart';
import 'package:http/http.dart' as http;
import '../controller/post_ctrl.dart';

class DetailView extends StatelessWidget {
  final int postId;

  DetailView({required this.postId});

  @override
  Widget build(BuildContext context) {
    final TimerController timerController = Get.find();
    final PostsController postsController = Get.find();

    return PopScope(
      canPop: true,
      onPopInvoked: (pop) async {
        if (!timerController.isTimerDone(postId)) {
          timerController.resumeTimer(postId);
        }
        postsController.markAsRead(postId);
        postsController.reloadPosts();
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Post $postId')),
        body: FutureBuilder(
          future: fetchPostDetail(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final post = snapshot.data as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(post['body']),
              );
            }
          },
        ),
      ),
    );
  }

/// FETCH POST DETAILS

  Future<Map<String, dynamic>> fetchPostDetail() async {
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/posts/$postId'));

    if (response.statusCode == 200) {
      return Map<String, dynamic>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load post details.');
    }
  }
}
