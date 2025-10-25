import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/reply_helper_controller.dart';
import '../widgets/image_upload_section.dart';
import '../widgets/image_preview_section.dart';
import '../widgets/user_intent_section.dart';
import '../widgets/suggested_reply_card.dart';

/// AI 영어 답장 도우미 메인 화면
class ReplyHelperScreen extends ConsumerWidget {
  /// [ReplyHelperScreen] 생성자
  const ReplyHelperScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(replyHelperProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      body: Column(
        children: [
          // Header
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFFE0B2),
                  Color(0xFFFFF9C4),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFB74D).withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: SafeArea(
              bottom: false,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '✨',
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Next Line',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF5D4037),
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 메인 컨텐츠 (스크롤 가능)
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 이미지 업로드 또는 미리보기
                    if (!state.hasImage)
                      ImageUploadSection(
                        onPickImage: () =>
                            ref.read(replyHelperProvider.notifier).pickImage(),
                        onTakePhoto: () =>
                            ref.read(replyHelperProvider.notifier).takePhoto(),
                      )
                    else
                      ImagePreviewSection(
                        imageFile: ref.read(replyHelperProvider.notifier).currentImageFile,
                        onChangeImage: () =>
                            ref.read(replyHelperProvider.notifier).changeImage(),
                      ),

                    if (state.hasImage) ...[
                      const SizedBox(height: 24),

                      // 이미지 분석 중 로딩
                      if (state.isAnalyzingImage)
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(40),
                            decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFE1F5FE),
                                Color(0xFFF3E5F5),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF81D4FA).withValues(alpha: 0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF81D4FA).withValues(alpha: 0.3),
                                      blurRadius: 16,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: const SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF29B6F6)),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                '🔍',
                                style: TextStyle(fontSize: 32),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                '이미지 분석 중...',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF4A148C),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                '대화 내용을 추출하고 있어요',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF7B1FA2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      else ...[
                        // 사용자 의도 입력 섹션 (톤 선택 포함)
                        UserIntentSection(
                          userIntent: state.userIntent,
                          selectedTone: state.selectedTone,
                          onIntentChanged: (intent) => ref
                              .read(replyHelperProvider.notifier)
                              .updateUserIntent(intent),
                          onToneSelected: (tone) => ref
                              .read(replyHelperProvider.notifier)
                              .selectTone(tone),
                          onRequestNextLine: () => ref
                              .read(replyHelperProvider.notifier)
                              .requestNextLine(),
                        ),

                        // AI 추천 응답 섹션 (생성된 경우만 표시)
                        if (state.suggestedReplies.isNotEmpty ||
                            state.isGeneratingReplies) ...[
                          const SizedBox(height: 24),

                          // AI 추천 응답
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFFA726),
                                      Color(0xFFFFB74D),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFFFA726).withValues(alpha: 0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Text(
                                  '✨',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'AI 추천 응답',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF5D4037),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // 응답 생성 중 로딩
                          if (state.isGeneratingReplies)
                            Center(
                              child: Container(
                                padding: const EdgeInsets.all(40),
                                decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFFFCE4EC),
                                    Color(0xFFFFF9C4),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFF48FB1).withValues(alpha: 0.2),
                                    blurRadius: 20,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.9),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFFF48FB1).withValues(alpha: 0.3),
                                          blurRadius: 16,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: const SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFEC407A)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  const Text(
                                    '🤖',
                                    style: TextStyle(fontSize: 32),
                                  ),
                                  const SizedBox(height: 12),
                                  const Text(
                                    'AI가 응답을 생성하고 있습니다',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF4A148C),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    '최적의 답장을 찾고 있어요 ✨',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF7B1FA2),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          else
                            // 추천 응답 카드들
                            ...state.suggestedReplies.map((reply) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: SuggestedReplyCard(
                                  reply: reply,
                                  onCopy: () => ref
                                      .read(replyHelperProvider.notifier)
                                      .copyReply(reply.text),
                                ),
                              );
                            }),
                        ],

                        // 다시 시작하기 버튼
                        const SizedBox(height: 32),
                        Center(
                          child: GestureDetector(
                            onTap: () =>
                                ref.read(replyHelperProvider.notifier).reset(),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 28,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFFAB47BC).withValues(alpha: 0.6),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFAB47BC).withValues(alpha: 0.15),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF3E5F5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.refresh_rounded,
                                      size: 18,
                                      color: Color(0xFFAB47BC),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    '다시 시작하기',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF7B1FA2),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
