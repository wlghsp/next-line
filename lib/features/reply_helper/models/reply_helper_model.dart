/// AI 응답 추천 데이터 모델
class SuggestedReply {
  /// [SuggestedReply] 생성자
  const SuggestedReply({
    required this.id,
    required this.text,
    required this.explanation,
  });

  /// 고유 식별자
  final String id;

  /// 추천 응답 텍스트
  final String text;

  /// 응답 설명 (예: "긍정적이고 구체적인 질문으로 화답")
  final String explanation;
}

/// 대화 톤 타입
enum ConversationTone {
  /// 비즈니스
  business('비즈니스'),

  /// 캐주얼
  casual('캐주얼'),

  /// 격식있게
  formal('격식있게'),

  /// 친근하게
  friendly('친근하게'),

  /// 유머러스하게
  humorous('유머러스하게');

  const ConversationTone(this.label);

  /// 톤 레이블
  final String label;
}
