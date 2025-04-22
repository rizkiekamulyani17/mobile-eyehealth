import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/services/chatbot.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/models/api.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late ChatbotService chatbotService;
  late MockClient mockClient;
  String baseUrl =
      "${ApiService().baseUrl}api/chatbot"; 

  setUp(() {
    mockClient = MockClient();
    chatbotService =
        ChatbotService(); 
  });

  test('should return bot reply when the response code is 200', () async {
    final mockResponse =
        "katarak adalah proses degeneratif berupa kekeruhan di lensa bola mata sehingga menyebabkan menurunnya kemampuan penglihatan sampai kebutaan.";
    when(() => mockClient.post(
          Uri.parse('$baseUrl'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'message': 'katarak adalah'}),
        )).thenAnswer((_) async => http.Response(mockResponse, 200));

 
    final result = await chatbotService.getBotReply('katarak adalah');

    expect(result, mockResponse);
  });


  test('should throw exception on network error', () async {
    when(() => mockClient.post(
          Uri.parse('$baseUrl/api/chatbot'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'message': 'Hi'}),
        )).thenThrow(Exception('Network error'));

    expect(() async => await chatbotService.getBotReply('Hi'),
        throwsA(isA<Exception>()));
  });
}
