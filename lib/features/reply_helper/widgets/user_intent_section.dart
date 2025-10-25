import 'package:flutter/material.dart';
import 'package:template/features/reply_helper/models/reply_helper_model.dart';
import 'package:template/features/reply_helper/widgets/tone_selector.dart';

/// 사용자 의도 입력 섹션
class UserIntentSection extends StatefulWidget {
  /// [UserIntentSection] 생성자
  const UserIntentSection({
    required this.userIntent,
    required this.selectedTone,
    required this.onIntentChanged,
    required this.onToneSelected,
    required this.onRequestNextLine,
    super.key,
  });

  /// 현재 사용자 의도 텍스트
  final String userIntent;

  /// 선택된 톤
  final ConversationTone selectedTone;

  /// 의도 텍스트 변경 콜백
  final ValueChanged<String> onIntentChanged;

  /// 톤 선택 콜백
  final ValueChanged<ConversationTone> onToneSelected;

  /// Next Line 요청 콜백
  final VoidCallback onRequestNextLine;

  @override
  State<UserIntentSection> createState() => _UserIntentSectionState();
}

class _UserIntentSectionState extends State<UserIntentSection> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.userIntent);
  }

  @override
  void didUpdateWidget(UserIntentSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.userIntent != widget.userIntent) {
      _controller.text = widget.userIntent;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFF9F0),
            Color(0xFFFFF3E6),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFB74D).withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFB74D).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '✨',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  '어떤 답장을 하고 싶으신가요?',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    height: 1.4,
                    color: Color(0xFF5D4037),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            '답장 의도를 입력하면 더 정확한 응답을 생성할 수 있어요 💬',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 13,
              fontWeight: FontWeight.w500,
              height: 1.5,
              color: Color(0xFF8D6E63),
            ),
          ),
          const SizedBox(height: 16),
          // 의도 입력 필드
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFFFCC80).withValues(alpha: 0.5),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFB74D).withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _controller,
              onChanged: widget.onIntentChanged,
              maxLines: 3,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF5D4037),
              ),
              decoration: const InputDecoration(
                hintText: '예: 긍정적으로 수락하고 싶어 🤗\n정중하게 거절하고 싶어 🙏\n시간 조정을 제안하고 싶어 📅',
                hintStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFBCAAA4),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // 상황 및 어조 설정
          Row(
            children: [
              const Text(
                '🎨',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 8),
              const Text(
                '상황 및 어조 설정',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                  color: Color(0xFF5D4037),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Tone Selector
          ToneSelector(
            selectedTone: widget.selectedTone,
            onToneSelected: widget.onToneSelected,
          ),

          const SizedBox(height: 20),
          // Next Line 요청 버튼
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFF6F00),
                  Color(0xFFFF8F00),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF6F00).withValues(alpha: 0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: widget.onRequestNextLine,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 0,
                shadowColor: Colors.transparent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '✨ Next Line 요청하기',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.arrow_forward, size: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
