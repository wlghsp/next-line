import 'package:flutter/material.dart';
import '../models/reply_helper_model.dart';

/// AI 추천 응답 카드
class SuggestedReplyCard extends StatelessWidget {
  /// [SuggestedReplyCard] 생성자
  const SuggestedReplyCard({
    required this.reply,
    required this.onCopy,
    super.key,
  });

  /// 추천 응답 데이터
  final SuggestedReply reply;

  /// 복사 콜백
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFFDE7),
            Color(0xFFFFF9C4),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFFFD54F).withValues(alpha: 0.5),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFA726).withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 응답 텍스트
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFA726).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '💬',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  reply.text,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.6,
                    color: Color(0xFF5D4037),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 구분선
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFFFD54F).withValues(alpha: 0.0),
                  const Color(0xFFFFD54F).withValues(alpha: 0.3),
                  const Color(0xFFFFD54F).withValues(alpha: 0.0),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // 하단 영역 (설명 + 복사 버튼)
          Row(
            children: [
              // 설명
              Expanded(
                child: Row(
                  children: [
                    const Text(
                      '💡',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        reply.explanation,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                          color: Color(0xFF8D6E63),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // 복사 버튼
              GestureDetector(
                onTap: onCopy,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFFA726),
                        Color(0xFFFFB74D),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFFA726).withValues(alpha: 0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.content_copy_rounded,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
