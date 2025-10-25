import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

/// Claude API와 통신하는 Repository
class ClaudeApiRepository {
  static const _baseUrl = 'https://api.anthropic.com/v1';
  // Claude Sonnet 4.5 (최신 모델, Vision 지원)
  static const _model = 'claude-sonnet-4-5-20250929';

  /// API 키 가져오기
  String get _apiKey => dotenv.env['CLAUDE_API_KEY'] ?? '';

  /// 이미지에서 대화 내용 추출
  ///
  /// [imageFile] 분석할 이미지 파일
  /// 반환: 추출된 대화 텍스트
  Future<String> extractTextFromImage(File imageFile) async {
    final imageBytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(imageBytes);

    // 이미지 확장자 확인
    final extension = imageFile.path.split('.').last.toLowerCase();
    final mediaType = _getMediaType(extension);

    final response = await http.post(
      Uri.parse('$_baseUrl/messages'),
      headers: {
        'x-api-key': _apiKey,
        'anthropic-version': '2023-06-01',
        'content-type': 'application/json',
      },
      body: jsonEncode({
        'model': _model,
        'max_tokens': 1024,
        'messages': [
          {
            'role': 'user',
            'content': [
              {
                'type': 'image',
                'source': {
                  'type': 'base64',
                  'media_type': mediaType,
                  'data': base64Image,
                },
              },
              {
                'type': 'text',
                'text':
                    '''This is a KakaoTalk (Korean messaging app) screenshot. Extract the conversation carefully.

IMPORTANT - KakaoTalk Reply Format:
- When someone replies to a message, it shows a gray quoted box first (the original message being replied to)
- Then below that is the actual reply message
- The text "나에게 답장" means "Reply to me" - this indicates the other person is replying to MY previous message
- The text "[name]에게 답장" means "Reply to [name]" - this indicates I am replying to their message

Extract the conversation showing:
1. Who sent each message (use the name shown, or "Me" for my messages)
2. If it's a reply, indicate what message they're replying to
3. The actual message content

Return ONLY the extracted conversation text in a clear format.''',
              },
            ],
          },
        ],
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to extract text: ${response.body}');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final content = data['content'] as List<dynamic>;
    final textContent = content.firstWhere(
      (item) => item['type'] == 'text',
      orElse: () => {'text': ''},
    ) as Map<String, dynamic>;

    return textContent['text'] as String? ?? '';
  }

  /// 대화 내용을 기반으로 응답 추천 생성
  ///
  /// [conversationText] 대화 내용
  /// [tone] 어조 (예: "비즈니스", "캐주얼", "격식있게")
  /// [userIntent] 사용자가 원하는 답장 의도 (선택 사항)
  /// 반환: JSON 형식의 추천 응답 목록
  Future<List<Map<String, String>>> generateReplies({
    required String conversationText,
    required String tone,
    String? userIntent,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/messages'),
      headers: {
        'x-api-key': _apiKey,
        'anthropic-version': '2023-06-01',
        'content-type': 'application/json',
      },
      body: jsonEncode({
        'model': _model,
        'max_tokens': 2048,
        'messages': [
          {
            'role': 'user',
            'content': '''You are helping me reply to a KakaoTalk conversation. Here is the conversation:

"$conversationText"

IMPORTANT Context:
- This is from a Korean messaging app (KakaoTalk)
- "나에게 답장" means the OTHER person is replying to MY message
- Look at the LATEST message from the OTHER person (not me) - that's what I need to respond to
- Understand the full context: if they replied to my message, their reply is their response to what I said

${userIntent != null && userIntent.isNotEmpty ? 'User Intent: I want to reply with this intent: "$userIntent"\nPlease generate replies that align with this intent.\n\n' : ''}Generate 3 different English reply suggestions with a $tone tone that I can send as MY next response.

For each reply, provide:
1. The reply text (in English) - this should be MY response to what THEY LAST said
2. A brief explanation (in Korean) of why this reply is appropriate

Return your response in the following JSON format:
[
  {
    "id": "1",
    "text": "The English reply text here",
    "explanation": "한국어로 된 설명"
  },
  {
    "id": "2",
    "text": "Another English reply",
    "explanation": "다른 설명"
  },
  {
    "id": "3",
    "text": "Third English reply",
    "explanation": "세 번째 설명"
  }
]

Return ONLY the JSON array, no additional text.''',
          },
        ],
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to generate replies: ${response.body}');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final content = data['content'] as List<dynamic>;
    final textContent = content.firstWhere(
      (item) => item['type'] == 'text',
      orElse: () => {'text': '[]'},
    ) as Map<String, dynamic>;

    final jsonText = textContent['text'] as String? ?? '[]';

    // JSON 파싱 (Claude가 가끔 ```json으로 감쌀 수 있음)
    final cleanedJson = jsonText
        .replaceAll('```json', '')
        .replaceAll('```', '')
        .trim();

    final replies = jsonDecode(cleanedJson) as List<dynamic>;

    return replies.map((reply) {
      final map = reply as Map<String, dynamic>;
      return {
        'id': map['id']?.toString() ?? '',
        'text': map['text']?.toString() ?? '',
        'explanation': map['explanation']?.toString() ?? '',
      };
    }).toList();
  }

  /// 이미지 확장자에 따른 media type 반환
  String _getMediaType(String extension) {
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      default:
        return 'image/jpeg';
    }
  }
}
