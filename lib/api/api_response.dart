//Api respone mas rafi

import 'dart:convert';

import 'package:job_marketplace/api/api_pagination.dart';
import 'package:job_marketplace/api/error/exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ApiResponse<T> {
  final bool success;
  final String message;
  final dynamic data;
  final Response? responseBase;
  final int statusCode;

  ApiResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.statusCode,
    this.responseBase,
  });

  factory ApiResponse.fromJson(
    Response response,
    T Function(Map<String, dynamic> json)? fromJson, {
    bool pagination = false,
  }) {
    if (response.data is String) {
      if (response.data.isEmpty) {
        final statusCode = (response.statusCode ?? 0) >= 200 &&
            (response.statusCode ?? 0) < 300;
        final message = statusCode ? 'Success' : 'Error';

        return ApiResponse(
          success: statusCode,
          message: message,
          statusCode: response.data["statusCode"],
          data: null,
        );
      }
    }

    if (response.data is! Map<String, dynamic>) {
      debugPrint('response.data: ${response.data}');
      throw ServerException(
          'Response bukan JSON\nSilahkan cek Kesalahan di API',
          response.statusCode ?? 500);
    }

    final Map<String, dynamic> json = response.data;
    // if (json['status'] is! bool) {
    //   throw ServerException(
    //       'Response key "success" bukan boolean', response.statusCode ?? 500);
    // }

    // if (json['message'] is! String) {
    //   throw ServerException(
    //       'Response key "message" bukan string', response.statusCode ?? 500);
    // }

    if (json['status'] == 0 || response.statusCode != 200) {
      if (response.statusCode == 422) {
        throw ServerException(
          jsonEncode(response.data),
          response.statusCode ?? 500,
        );
      }
      if (json['message'].toString().trim().isNotEmpty) {
        throw ServerException(
            json['message'].toString().trim(), response.statusCode ?? 500);
      } else if (json['message'].toString().trim().isEmpty) {
        throw ServerException(
            'Response key "success" true tapi messagenya kosong',
            response.statusCode ?? 500);
      }
    }

    if (json['status'] == 0 || response.statusCode != 200) {
      if (response.statusCode == 422) {
        throw ServerException(
          jsonEncode(response.data),
          response.statusCode ?? 500,
        );
      }
      if (json['message'].toString().trim().isNotEmpty) {
        throw ServerException(
            json['message'].toString().trim(), response.statusCode ?? 500);
      } else if (json['message'].toString().trim().isEmpty) {
        throw ServerException(
            'Response key "success" true tapi messagenya kosong',
            response.statusCode ?? 500);
      }
    }

    dynamic data;

    if (json['data'] != null) {
      final jsonData = json['data'].toString();

      if (jsonData.isNotEmpty) {
        if (fromJson != null) {
          if (pagination) {
            data = ApiPagination<T>.fromJson(json['data'], fromJson.call);
          } else if (jsonData[0] == '[') {
            data = (json['data'] as List<dynamic>).map((e) {
              return fromJson.call(e);
            }).toList();
          } else if (jsonData[0] == '{') {
            data = fromJson.call(json['data']);
          }
        } else if (json['data'] is List<dynamic>) {
          data = (json['data'] as List<dynamic>).map<Map<String, dynamic>>((e) {
            return e;
          }).toList();
        } else {
          data = json['data'];
        }
      }
    }

    return ApiResponse(
      success: json['status'] == 1 ? true : false,
      message: json['message'] ?? 'Pesan tidak dikenal',
      statusCode: json['status'],
      data: data,
      responseBase: response,
    );
  }
}
