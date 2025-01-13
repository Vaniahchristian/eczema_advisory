import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final String baseUrl = 'http://localhost:3001/api'; // Update with your API URL
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<Map<String, String>> _getHeaders() async {
    final token = await _storage.read(key: 'auth_token');
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // Doctors API
  Future<List<dynamic>> getDoctors() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/doctors'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load doctors');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Appointments API
  Future<List<dynamic>> getAppointments() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/appointments'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load appointments');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> createAppointment(Map<String, dynamic> appointmentData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/appointments'),
        headers: await _getHeaders(),
        body: json.encode(appointmentData),
      );

      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to create appointment');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateAppointment(
      String appointmentId, Map<String, dynamic> updateData) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/appointments/$appointmentId'),
        headers: await _getHeaders(),
        body: json.encode(updateData),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to update appointment');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Diagnosis API
  Future<dynamic> uploadImage(String imagePath) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/diagnosis/upload'),
      );

      request.headers.addAll(await _getHeaders());
      request.files.add(await http.MultipartFile.fromPath('image', imagePath));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to upload image');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getDiagnosisResult(String diagnosisId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/diagnosis/$diagnosisId'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to get diagnosis result');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Messages API
  Future<List<dynamic>> getMessages(String doctorId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/messages/$doctorId'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load messages');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> sendMessage(Map<String, dynamic> messageData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/messages'),
        headers: await _getHeaders(),
        body: json.encode(messageData),
      );

      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to send message');
      }
    } catch (e) {
      rethrow;
    }
  }
}
