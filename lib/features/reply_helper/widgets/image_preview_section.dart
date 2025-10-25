import 'dart:io';
import 'package:flutter/material.dart';

/// 이미지 미리보기 섹션
class ImagePreviewSection extends StatelessWidget {
  /// [ImagePreviewSection] 생성자
  const ImagePreviewSection({
    required this.onChangeImage,
    this.imageFile,
    super.key,
  });

  /// 이미지 변경 콜백
  final VoidCallback onChangeImage;

  /// 선택한 이미지 파일
  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          // 이미지 프리뷰
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            child: imageFile != null
                ? Image.file(
                    imageFile!,
                    fit: BoxFit.cover,
                  )
                : const Icon(
                    Icons.image,
                    size: 40,
                    color: Color(0xFF9E9E9E),
                  ),
          ),

          const SizedBox(width: 16),

          // 정보 및 변경 버튼
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '대화 이미지',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                    color: Color(0xFF212121),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '분석 준비 완료',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.43,
                    color: Color(0xFF616161),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: onChangeImage,
                  child: const Text(
                    '이미지 변경',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.43,
                      color: Color(0xFF1A237E),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
