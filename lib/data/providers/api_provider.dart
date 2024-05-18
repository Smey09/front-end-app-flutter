import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:we_post_app/data/models/comment_res_model.dart';
import 'package:we_post_app/data/models/post_res_model.dart';
import 'package:we_post_app/data/models/user_res_model.dart';

import '../models/login_res_model.dart';

class APIProvider {
  final dio = Dio(); // used to make HTTP requests to the server
  final box =
      GetStorage(); // used to store data locally such as token or user data
  final baseUrl = "http://10.0.2.2:8000/api";
  // final baseUrl = "http://127.0.0.1:8000/api";

  Future<bool> register(
      {required String email,
      required String name,
      required String password,
      File? image}) async {
    try {
      // prepare the data to be sent to the server
      var _formData = FormData.fromMap({
        "email": email,
        "name": name,
        "password": password,
        "password_confirmation": password,
        "image": image != null ? await MultipartFile.fromFile(image.path) : null
      });
      // request to the server
      final response = await dio.post(
        "$baseUrl/user/register",
        data: _formData,
        options: Options(
          headers: {
            "Accept": "application/json",
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      print("Status ${response.statusCode}");
      if (response.statusCode == 200) {
        // that means the request was successful
        return true;
      } else if (response.statusCode == 400) {
        throw Exception("Email already exists");
      } else {
        throw Exception("Failed to register");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginResModel> login(
      {required String email, required String password}) async {
    // prepare the data to be sent to the server
    try {
      var _formData = FormData.fromMap({
        "email": email,
        "password": password,
      });
      // request to the server
      final response = await dio.post(
        "$baseUrl/user/login",
        data: _formData,
        options: Options(
          headers: {
            "Accept": "application/json",
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        // that means the request was successful
        return LoginResModel.fromJson(response.data);
      } else {
        throw Exception("Failed to register");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserResModel> getUserProfile() async {
    // prepare the data to be sent to the server
    try {
      final token = box.read('token');
      // request to the server
      final response = await dio.get(
        "$baseUrl/user/profile",
        options: Options(
          headers: {
            "Accept": "application/json",
            'Authorization': "Bearer $token"
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        // that means the request was successful
        return UserResModel.fromJson(response.data);
      } else {
        throw Exception("Failed to get user profile");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<PostResModel> fetchPosts() async {
    // prepare the data to be sent to the server
    try {
      final token = box.read('token');
      // request to the server
      final response = await dio.get(
        "$baseUrl/post/index",
        options: Options(
          headers: {
            "Accept": "application/json",
            'Authorization': "Bearer $token"
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        // that means the request was successful
        return PostResModel.fromJson(response.data);
      } else {
        throw Exception("Failed to get user profile");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> likeDisLike({required int id}) async {
    // prepare the data to be sent to the server
    try {
      final token = box.read('token');
      // request to the server
      final response = await dio.post(
        "$baseUrl/like-disLike/${id}",
        options: Options(
          headers: {
            "Accept": "application/json",
            'Authorization': "Bearer $token"
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        // that means the request was successful
        return response.data['message'];
      } else {
        throw Exception("Failed to get user profile");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CommentResModel>> getCommentByPost({required int postId}) async {
    // prepare the data to be sent to the server
    try {
      final token = box.read('token');
      // request to the server
      final response = await dio.get(
        "$baseUrl/comment/show/${postId}",
        options: Options(
          headers: {
            "Accept": "application/json",
            'Authorization': "Bearer $token"
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        // that means the request was successful
        return (response.data as List)
            .map((e) => CommentResModel.fromJson(e))
            .toList();
      } else {
        throw Exception("Failed to get user profile");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> createComment(
      {required int postId, required String text}) async {
    // prepare the data to be sent to the server
    try {
      final token = box.read('token');
      // request to the server
      final response = await dio.post(
        "$baseUrl/comment/store",
        data: {"post_id": postId, "text": text},
        options: Options(
          headers: {
            "Accept": "application/json",
            'Authorization': "Bearer $token"
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        // that means the request was successful
        return "Comment created successfully";
      } else {
        throw Exception("Failed to get user profile");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> createPost({
    required String caption,
    File? photo,
  }) async {
    var _formData = FormData.fromMap({
      "caption": caption,
      "image": photo != null ? await MultipartFile.fromFile(photo.path) : null,
    });
    final response = await dio.post(
      "$baseUrl/post/store",
      data: _formData,
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${box.read("token")}",
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    print(response.data);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to create post");
    }
  }

  Future<bool> updatePost({
    required int postId,
    required String caption,
    File? photo,
  }) async {
    var _formData = FormData.fromMap({
      "caption": caption,
      "image": photo != null ? await MultipartFile.fromFile(photo.path) : null,
    });

    final response = await dio.patch(
      "$baseUrl/post/$postId/update",
      data: _formData,
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${box.read("token")}",
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    print(response.data);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to update post");
    }
  }

  Future<bool> deletePost(int postId) async {
    final response = await dio.delete(
      "$baseUrl/post/$postId/delete", // Update URL with post ID
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${box.read("token")}",
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    print(response.data);
    if (response.statusCode == 200 || response.statusCode == 204) {
      return true;
    } else {
      throw Exception("Failed to delete post");
    }
  }
}
