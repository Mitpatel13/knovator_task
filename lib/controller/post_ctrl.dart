import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PostsController extends GetxController {
  var posts = [].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadLocalData();
    fetchPosts();
  }
/// FETCHING POST
  Future<void> fetchPosts() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      if (response.statusCode == 200) {
        final List fetchedPosts = jsonDecode(response.body);
        posts.value = fetchedPosts.map((post) {
          return {...post, 'isRead': false};
        }).toList();
      } else {
        errorMessage.value = 'Failed to fetch posts. Please try again.';
      }
    } catch (e) {
      errorMessage.value = 'No Internet Connection. Please check your connection.';
    } finally {
      isLoading.value = false;
    }
  }
  void markAsRead(int postId) {
    final index = posts.indexWhere((post) => post['id'] == postId);
    if (index != -1) {
      posts[index]['isRead'] = true;
      saveToLocalStorage(posts.value);
    }
  }

  void reloadPosts() {
    loadLocalData();
  }

  void loadLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    final localPosts = prefs.getString('posts');
    if (localPosts != null) {
      posts.value = jsonDecode(localPosts);
    }
  }

  void saveToLocalStorage(List posts) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('posts', jsonEncode(posts));
  }
}
