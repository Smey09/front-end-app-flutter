// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class PostController extends GetxController {
//   final dio = Dio();
//   final baseUrl = "http://10.0.2.2:8000/api";

//   Future<bool> deletePost(int postId) async {
//     try {
//       final response = await dio.delete(
//         "$baseUrl/post/$postId/delete",
//         options: Options(
//           headers: {
//             "Accept": "application/json",
//             "Authorization": "Bearer ${box.read("token")}",
//           },
//           followRedirects: false,
//           validateStatus: (status) {
//             return status! < 500;
//           },
//         ),
//       );

//       if (response.statusCode == 200 || response.statusCode == 204) {
//         // Handle successful deletion (show message, navigate back, etc.)
//         Get.snackbar("Success", "Post deleted successfully!",
//             backgroundColor: Colors.green, colorText: Colors.white);
//         return true;
//       } else {
//         throw Exception("Failed to delete post");
//       }
//     } on Exception catch (e) {
//       Get.snackbar("Error", "Failed to delete post: ${e.toString()}",
//           backgroundColor: Colors.red, colorText: Colors.white);
//       return false;
//     }
//   }
// }
