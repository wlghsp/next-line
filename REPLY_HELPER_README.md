# AI 영어 답장 도우미

Claude API를 사용하여 대화 이미지를 분석하고 영어 응답을 추천해주는 기능입니다.

## 기능

1. **이미지 업로드**: 대화 스크린샷 선택
2. **자동 텍스트 추출**: Claude Vision API로 대화 내용 자동 추출
3. **편집 가능**: 추출된 텍스트 수정 가능
4. **어조 선택**: 비즈니스, 캐주얼, 격식있게, 친근하게, 유머러스하게
5. **AI 응답 생성**: Claude가 3가지 응답 옵션 제공 (영어 + 한글 설명)
6. **복사 기능**: 원클릭으로 클립보드에 복사

## 설정 방법

### 1. Claude API Key 발급

1. [Anthropic Console](https://console.anthropic.com/settings/keys)에 접속
2. API Key 생성
3. 발급받은 키를 복사

### 2. .env 파일 설정

프로젝트 루트에 `.env` 파일을 생성하고 API 키를 입력하세요:

```bash
CLAUDE_API_KEY=your_api_key_here
```

**중요**: `.env` 파일은 절대 Git에 커밋하지 마세요! (이미 .gitignore에 추가되어 있습니다)

### 3. 패키지 설치

```bash
fvm flutter pub get
```

## 사용 방법

### 스크린 열기

```dart
import 'package:template/features/reply_helper/screens/reply_helper_screen.dart';

// 버튼 클릭 시
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const ReplyHelperScreen(),
  ),
);
```

### 사용 흐름

1. "이미지 선택하기" 버튼 클릭
2. 대화 스크린샷 선택
3. Claude가 자동으로 대화 내용 추출
4. 필요시 텍스트 수정
5. 원하는 어조 선택 (기본: 비즈니스)
6. AI 추천 응답 3개 확인
7. 마음에 드는 응답의 복사 버튼 클릭
8. 클립보드에 복사된 텍스트를 원하는 곳에 붙여넣기

## 파일 구조

```
lib/features/reply_helper/
├── models/
│   └── reply_helper_model.dart          # SuggestedReply, ConversationTone
├── repositories/
│   └── claude_api_repository.dart       # Claude API 통신
├── controllers/
│   └── reply_helper_controller.dart     # Riverpod 상태 관리
├── screens/
│   └── reply_helper_screen.dart         # 메인 화면
└── widgets/
    ├── image_upload_section.dart        # 이미지 업로드 UI
    ├── image_preview_section.dart       # 이미지 미리보기
    ├── tone_selector.dart               # 어조 선택기
    └── suggested_reply_card.dart        # 응답 카드
```

## API 사용량 참고

- **모델**: `claude-3-5-sonnet-20241022`
- **텍스트 추출**: 약 1,000 토큰/요청
- **응답 생성**: 약 2,000 토큰/요청
- **예상 비용**: 이미지 1개 + 응답 생성 = $0.01~0.02 정도

자세한 가격은 [Anthropic Pricing](https://www.anthropic.com/pricing)을 참고하세요.

## 에러 처리

현재 에러는 rethrow되어 상위에서 처리됩니다. 필요시 UI에서 try-catch로 감싸서 사용자에게 메시지를 표시하세요:

```dart
try {
  await ref.read(replyHelperProvider.notifier).pickImage();
} catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('이미지 처리 중 오류가 발생했습니다: $e')),
  );
}
```

## 개발 시 주의사항

1. **.env 파일**: Git에 커밋하지 않도록 주의
2. **API 비용**: 테스트 시 과도한 호출 주의
3. **이미지 크기**: 너무 큰 이미지는 API 제한에 걸릴 수 있음 (최대 5MB)
4. **지원 이미지**: JPEG, PNG, GIF, WebP

## 향후 개선 사항

- [ ] 로딩 인디케이터 추가
- [ ] 에러 메시지 UI 개선
- [ ] 이미지 크기 자동 조정
- [ ] 응답 히스토리 저장
- [ ] 오프라인 모드 지원
- [ ] 다국어 지원 (현재는 영어 응답만)
