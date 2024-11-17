import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/post_ctrl.dart';
import '../controller/timer_ctrl.dart';
import '../widget/timer_icon.dart';
import 'detail_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PostsController postsController = Get.put(PostsController());
  final TimerController timerController = Get.put(TimerController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      postsController.reloadPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Posts List')),
      body: Obx(() {
        if (postsController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (postsController.errorMessage.isNotEmpty) {
          return Center(child: Text(postsController.errorMessage.value));
        }

        return ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 5,child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(),
          ),),
          itemCount: postsController.posts.length,
          itemBuilder: (context, index) {
            final post = postsController.posts[index];
            final postId = post['id'];
            final isRead = post['isRead'];

            return GestureDetector(
              onTap: () {
                postsController.markAsRead(postId);
                timerController.pauseTimer(postId);
                Get.to(() => DetailView(postId: postId));
              },
              child: Container(

                  decoration: BoxDecoration(

                      backgroundBlendMode:BlendMode.color,
                      color: isRead ? Colors.white : Colors.yellow[100],
                      borderRadius: BorderRadius.circular(18)
                  ),
                padding: const EdgeInsets.all(16),
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        post['title'],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    TimerIcon(postId: postId, initialDuration: 10 + index % 15),
                  ],
                )

              ),
            );
          },
        );
      }),
    );
  }
}
