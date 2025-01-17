import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:openai_dart/openai_dart.dart';

class FaceAnalysisService {
  static final FaceAnalysisService _instance = FaceAnalysisService._internal();
  late final OpenAIClient _client;

  factory FaceAnalysisService() {
    return _instance;
  }

  FaceAnalysisService._internal() {
    final apiKey = dotenv.env['OPENAI_API_KEY'];
    if (apiKey == null) throw Exception('OPENAI_API_KEY bulunamadı');
    _client = OpenAIClient(apiKey: apiKey);
  }

  Future<Map<String, dynamic>> analyzeFaceShape(String imagePath) async {
    try {
      final bytes = await File(imagePath).readAsBytes();
      final base64Image = base64Encode(bytes);

      final res = await _client.createChatCompletion(
        request: CreateChatCompletionRequest(
          model: const ChatCompletionModel.model(
            ChatCompletionModels.gpt4oMini,
          ),
          messages: [
            const ChatCompletionMessage.system(
              content:
                  'Sen bir yüz şekli analiz uzmanısın. Verilen fotoğraftaki kişinin yüz şeklini analiz et ve sonucu sadece JSON formatında dön. Yanıt formatı şu şekilde olmalı: {"predictions": {"Oval": 40, "Oblong": 20, "Kare": 10, "Yuvarlak": 10, "Kalp": 10, "Üçgen": 10}}. Yüz şekilleri: Oval, Oblong, Kare, Yuvarlak, Kalp, Üçgen olabilir. Her bir yüz şekli için yüzdelik tahmin ver. Toplam yüzde 100 olmalı. Verilen fotoğrafta bir yüz göremezsen bile yüz şeklinin ne olduğunu tahmin et ve sonucu dön.',
            ),
            ChatCompletionMessage.user(
              content: ChatCompletionUserMessageContent.parts([
                const ChatCompletionMessageContentPart.text(
                  text: 'Bu fotoğraftaki kişinin yüz şekli analizi nedir?',
                ),
                ChatCompletionMessageContentPart.image(
                  imageUrl: ChatCompletionMessageImageUrl(
                    url: 'data:image/jpeg;base64,$base64Image',
                  ),
                ),
              ]),
            ),
          ],
        ),
      );

      final content =
          res.choices.first.message.content ?? '{"predictions": {}}';
      return json.decode(content) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Fotoğraf analiz edilirken bir hata oluştu: $e');
    }
  }
}
