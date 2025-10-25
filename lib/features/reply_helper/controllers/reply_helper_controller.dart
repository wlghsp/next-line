import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../models/reply_helper_model.dart';
import '../repositories/claude_api_repository.dart';

/// 답장 도우미 상태
class ReplyHelperState {
  /// [ReplyHelperState] 생성자
  const ReplyHelperState({
    this.extractedText = '',
    this.userIntent = '',
    this.selectedTone = ConversationTone.business,
    this.suggestedReplies = const [],
    this.hasImage = false,
    this.isAnalyzingImage = false,
    this.isGeneratingReplies = false,
  });

  /// 추출된 대화 내용
  final String extractedText;

  /// 사용자가 입력한 답장 의도
  final String userIntent;

  /// 선택된 톤
  final ConversationTone selectedTone;

  /// AI 추천 응답 목록
  final List<SuggestedReply> suggestedReplies;

  /// 이미지 첨부 여부
  final bool hasImage;

  /// 이미지 분석 중 여부
  final bool isAnalyzingImage;

  /// 응답 생성 중 여부
  final bool isGeneratingReplies;

  /// 상태 복사
  ReplyHelperState copyWith({
    String? extractedText,
    String? userIntent,
    ConversationTone? selectedTone,
    List<SuggestedReply>? suggestedReplies,
    bool? hasImage,
    bool? isAnalyzingImage,
    bool? isGeneratingReplies,
  }) {
    return ReplyHelperState(
      extractedText: extractedText ?? this.extractedText,
      userIntent: userIntent ?? this.userIntent,
      selectedTone: selectedTone ?? this.selectedTone,
      suggestedReplies: suggestedReplies ?? this.suggestedReplies,
      hasImage: hasImage ?? this.hasImage,
      isAnalyzingImage: isAnalyzingImage ?? this.isAnalyzingImage,
      isGeneratingReplies: isGeneratingReplies ?? this.isGeneratingReplies,
    );
  }
}

/// 답장 도우미 Provider
final replyHelperProvider =
    NotifierProvider<ReplyHelperController, ReplyHelperState>(
  ReplyHelperController.new,
);

/// 답장 도우미 Controller
class ReplyHelperController extends Notifier<ReplyHelperState> {
  final _imagePicker = ImagePicker();
  final _claudeApi = ClaudeApiRepository();
  File? _currentImageFile;

  /// 현재 선택된 이미지 파일
  File? get currentImageFile => _currentImageFile;

  @override
  ReplyHelperState build() => const ReplyHelperState();

  /// 이미지 선택하기
  Future<void> pickImage() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile == null) {
        return;
      }

      _currentImageFile = File(pickedFile.path);

      // 이미지 분석 시작
      state = state.copyWith(
        hasImage: true,
        isAnalyzingImage: true,
      );

      // Mock 모드: API 크레딧이 없을 때 임시 데이터 사용
      const useMockData = false; // API 사용

      String extractedText;
      if (useMockData) {
        // 임시 데이터
        extractedText =
            'Hey! Are you free this Friday? I was thinking we could grab dinner together. There\'s a new Italian place downtown that got amazing reviews!';
      } else {
        // Claude API로 텍스트 추출
        extractedText = await _claudeApi.extractTextFromImage(
          _currentImageFile!,
        );
      }

      state = state.copyWith(
        extractedText: extractedText,
        isAnalyzingImage: false,
      );
    } catch (e) {
      // 에러 발생 시 로딩 상태 해제
      state = state.copyWith(
        isAnalyzingImage: false,
        isGeneratingReplies: false,
      );
      rethrow;
    }
  }

  /// 카메라로 촬영하기
  Future<void> takePhoto() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
      );

      if (pickedFile == null) {
        return;
      }

      _currentImageFile = File(pickedFile.path);

      // 이미지 분석 시작
      state = state.copyWith(
        hasImage: true,
        isAnalyzingImage: true,
      );

      // Mock 모드: API 크레딧이 없을 때 임시 데이터 사용
      const useMockData = false; // API 사용

      String extractedText;
      if (useMockData) {
        // 임시 데이터
        extractedText =
            'Hey! Are you free this Friday? I was thinking we could grab dinner together. There\'s a new Italian place downtown that got amazing reviews!';
      } else {
        // Claude API로 텍스트 추출
        extractedText = await _claudeApi.extractTextFromImage(
          _currentImageFile!,
        );
      }

      state = state.copyWith(
        extractedText: extractedText,
        isAnalyzingImage: false,
      );
    } catch (e) {
      // 에러 발생 시 로딩 상태 해제
      state = state.copyWith(
        isAnalyzingImage: false,
        isGeneratingReplies: false,
      );
      rethrow;
    }
  }

  /// 이미지 변경
  Future<void> changeImage() async {
    await pickImage();
  }

  /// 대화 내용 수정
  void updateExtractedText(String text) {
    state = state.copyWith(extractedText: text);
  }

  /// 사용자 의도 입력
  void updateUserIntent(String intent) {
    state = state.copyWith(userIntent: intent);
  }

  /// 톤 선택
  void selectTone(ConversationTone tone) {
    state = state.copyWith(selectedTone: tone);
  }

  /// Next Line 요청 (AI 응답 생성)
  Future<void> requestNextLine() async {
    await _generateSuggestedReplies();
  }

  /// 응답 복사
  Future<void> copyReply(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    // 복사 완료 토스트 표시 (UI에서 처리)
  }

  /// 처음으로 돌아가기 (초기화)
  void reset() {
    _currentImageFile = null;
    state = const ReplyHelperState();
  }

  /// AI 추천 응답 생성 (내부 메서드)
  Future<void> _generateSuggestedReplies() async {
    if (state.extractedText.isEmpty) {
      return;
    }

    // 응답 생성 시작
    state = state.copyWith(isGeneratingReplies: true);

    // Mock 모드: API 크레딧이 없을 때 임시 데이터 사용
    const useMockData = false; // API 사용

    try {
      List<SuggestedReply> replies;

      if (useMockData) {
        // 임시 데이터
        replies = [
          const SuggestedReply(
            id: '1',
            text:
                'That sounds great! I\'m free on Friday. What kind of food are you in the mood for?',
            explanation: '긍정적이고 구체적인 질문으로 화답',
          ),
          const SuggestedReply(
            id: '2',
            text:
                'I\'d love to, but I already have plans on Friday. How about another time next week?',
            explanation: '정중하게 거절하며 대안 제시',
          ),
          const SuggestedReply(
            id: '3',
            text:
                'Friday works for me! Do you have a place in mind, or should I look for some options?',
            explanation: '적극적으로 참여하며 다음 단계 제안',
          ),
        ];
      } else {
        // 실제 Claude API 호출
        final repliesData = await _claudeApi.generateReplies(
          conversationText: state.extractedText,
          tone: state.selectedTone.label,
          userIntent: state.userIntent.isNotEmpty ? state.userIntent : null,
        );

        replies = repliesData.map((data) {
          return SuggestedReply(
            id: data['id'] ?? '',
            text: data['text'] ?? '',
            explanation: data['explanation'] ?? '',
          );
        }).toList();
      }

      state = state.copyWith(
        suggestedReplies: replies,
        isGeneratingReplies: false,
      );
    } catch (e) {
      // 에러 발생 시 로딩 상태 해제
      state = state.copyWith(isGeneratingReplies: false);
      rethrow;
    }
  }
}
