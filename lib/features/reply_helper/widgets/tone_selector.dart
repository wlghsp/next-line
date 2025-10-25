import 'package:flutter/material.dart';
import '../models/reply_helper_model.dart';

/// 대화 톤 선택 위젯
class ToneSelector extends StatelessWidget {
  /// [ToneSelector] 생성자
  const ToneSelector({
    required this.selectedTone,
    required this.onToneSelected,
    super.key,
  });

  /// 현재 선택된 톤
  final ConversationTone selectedTone;

  /// 톤 선택 콜백
  final Function(ConversationTone) onToneSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: ConversationTone.values.map((tone) {
        final isSelected = tone == selectedTone;

        return GestureDetector(
          onTap: () => onToneSelected(tone),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF1A237E).withValues(alpha: 0.1)
                  : const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              tone.label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                height: 1.43,
                color: isSelected
                    ? const Color(0xFF1A237E)
                    : const Color(0xFF616161),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
