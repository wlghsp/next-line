# Next Line ✨

AI 기반 영어 답장 도우미 - 카카오톡 대화 이미지를 분석하여 상황에 맞는 영어 답장을 추천해드립니다.

## 📸 스크린샷

<p align="center">
  <img src="assets/screenshots/screenshot-1.png" width="250" />
  <img src="assets/screenshots/screenshot-2.png" width="250" />
  <img src="assets/screenshots/screenshot-3.png" width="250" />
</p>

## 📱 주요 기능

- 📸 **대화 이미지 분석**: 카카오톡 스크린샷을 업로드하면 AI가 대화 내용을 추출합니다
- 🤖 **AI 답장 생성**: Claude API를 활용하여 맥락에 맞는 영어 답장 3개를 생성합니다
- 🎨 **다양한 톤 선택**: 비즈니스, 캐주얼, 격식있게, 친근하게, 유머러스하게 등 상황에 맞는 톤 선택 가능
- 💡 **한국어 설명**: 각 답장마다 왜 적절한지 한국어로 설명을 제공합니다
- 📋 **간편한 복사**: 마음에 드는 답장을 클릭 한 번으로 복사할 수 있습니다

## 🚀 시작하기

### 1. 저장소 클론

```bash
git clone https://github.com/your-username/next-line.git
cd next-line
```

### 2. Flutter 버전 설치 (FVM)

이 프로젝트는 FVM으로 Flutter 버전을 관리합니다 (v3.35.6).

```bash
# FVM 설치 (처음 한 번만)
dart pub global activate fvm

# 프로젝트 Flutter 버전 설치
fvm install
```

### 3. 환경 변수 설정

`.env.example` 파일을 복사하여 `.env` 파일을 만들고, Claude API 키를 입력합니다.

```bash
# .env 파일 생성
cp .env.example .env

# .env 파일을 열어서 API 키 입력
# CLAUDE_API_KEY=sk-ant-api03-your-api-key-here
```

**Claude API Key 발급 방법:**
1. https://console.anthropic.com 접속
2. 회원가입 / 로그인
3. API Keys 메뉴에서 새 키 생성
4. 생성된 키를 `.env` 파일에 입력

### 4. 의존성 설치

```bash
fvm flutter pub get
```

### 5. 앱 실행

```bash
# Android/iOS 에뮬레이터 실행 후
fvm flutter run
```

## 🛠️ 기술 스택

### Frontend
- **Framework**: Flutter 3.35.6
- **Language**: Dart ^3.8.1
- **State Management**: Riverpod 3.0
- **UI/UX**: Material 3 Design with Custom Gradient Themes

### AI & API
- **AI Model**: Anthropic Claude Sonnet 4.5
- **Vision API**: Claude Vision for Image Analysis
- **HTTP Client**: Dart http package

### Development Tools
- **Version Control**: Git & GitHub
- **Flutter Version Manager**: FVM
- **Environment Variables**: flutter_dotenv
- **Localization**: easy_localization

## 📦 주요 패키지

- `flutter_riverpod: ^3.0.3` - 상태 관리
- `image_picker: ^1.1.2` - 이미지 선택/촬영
- `http: ^1.2.2` - HTTP 클라이언트 (Claude API)
- `flutter_dotenv: ^5.2.1` - 환경 변수 관리
- `flutter_svg: ^2.0.16` - SVG 이미지
- `easy_localization: ^3.0.8` - 다국어 지원

## 📁 프로젝트 구조

```
lib/
├── core/
│   ├── controllers/    # 전역 컨트롤러 (테마 등)
│   └── themes/         # 디자인 시스템
└── features/
    └── reply_helper/   # 답장 도우미 기능
        ├── controllers/        # Riverpod 상태 관리
        ├── models/            # 데이터 모델
        ├── repositories/      # Claude API 연동
        ├── screens/           # UI 화면
        └── widgets/           # 재사용 위젯
```

## 🎨 디자인

Next Line은 따뜻하고 친근한 느낌의 디자인을 지향합니다:

- **컬러**: 오렌지-노랑, 보라-핑크 그라데이션
- **스타일**: 둥근 모서리, 부드러운 그림자, 이모지 활용
- **UX**: 직관적인 플로우, 명확한 피드백

## 🔒 보안 주의사항

다음 파일들은 절대 Git에 커밋하지 마세요:

- `.env` - API 키가 포함된 환경 변수
- `.mcp.json` - MCP 서버 설정
- `google-services.json` - Firebase Android 설정
- `GoogleService-Info.plist` - Firebase iOS 설정

이 파일들은 이미 `.gitignore`에 추가되어 있습니다.

## 🤝 기여하기

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 라이센스

MIT License

## 💬 문의

프로젝트에 대한 질문이나 제안이 있으시면 Issue를 생성해주세요!

---

## 🏆 해커톤

이 프로젝트는 [치킨 먹는 해커톤(치킨톤) 2024](https://blueberry-team.com/)에서 개발되었습니다.

- **기간**: 2024.10.25(금) 22:00 ~ 2024.10.26(토) 10:00
- **주제**: "당신의 아이디어, 이번 주말에 앱이 된다"
- **개발 시간**: 12시간

---

Made with ❤️ using Flutter & Claude AI
