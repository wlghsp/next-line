# Next Line - 앱 아이콘 디자인 가이드

## 앱 콘셉트
**Next Line**은 카카오톡 대화 이미지를 분석하여 AI가 영어 답장을 추천해주는 서비스입니다.

## 디자인 콘셉트

### 컬러 팔레트
앱의 따뜻하고 친근한 느낌을 살린 그라데이션 컬러:

- **메인 컬러**: 오렌지-노랑 계열 (#FFB74D, #FFA726)
- **서브 컬러**: 보라-핑크 계열 (#AB47BC, #BA68C8)
- **포인트**: 파스텔 옐로우 (#FFF9C4, #FFFDE7)

### 아이콘 디자인 요소

1. **메인 심볼**:
   - 대화 말풍선 + 반짝이는 효과 (✨)
   - 또는 "Next Line"의 "N" 또는 화살표 (→) 형태

2. **스타일**:
   - 둥근 모서리 (친근함)
   - 그라데이션 배경
   - 부드러운 그림자
   - 3D 느낌의 레이어

3. **추천 디자인 아이디어**:
   ```
   옵션 1: 말풍선 💬 + 별 ✨ 조합
   - 배경: 오렌지→노랑 그라데이션
   - 중앙: 흰색 말풍선 아이콘
   - 포인트: 반짝이는 별 효과

   옵션 2: Next Line의 "N" 심볼
   - 배경: 보라→핑크 그라데이션
   - 중앙: 굵은 "N" 레터링
   - 스타일: 모던하고 심플

   옵션 3: 화살표 (→) 모티브
   - "다음 줄"의 의미를 시각화
   - 배경: 파스텔 그라데이션
   - 중앙: 둥근 화살표 아이콘
   ```

## 아이콘 파일 위치

### Android
- `/android/app/src/main/res/mipmap-*/ic_launcher.png`
- 크기: mdpi(48), hdpi(72), xhdpi(96), xxhdpi(144), xxxhdpi(192)

### iOS
- `/ios/Runner/Assets.xcassets/AppIcon.appiconset/`
- 크기: 20x20 ~ 1024x1024 (다양한 배수)

## 제작 도구 추천

1. **Figma** - 벡터 디자인 및 프로토타입
2. **flutter_launcher_icons** 패키지 - 자동 아이콘 생성
   ```yaml
   dev_dependencies:
     flutter_launcher_icons: ^0.13.1

   flutter_launcher_icons:
     android: true
     ios: true
     image_path: "assets/icon/app_icon.png"
     adaptive_icon_background: "#FFF9C4"
     adaptive_icon_foreground: "assets/icon/app_icon_foreground.png"
   ```

3. **온라인 도구**:
   - Canva - 간단한 아이콘 제작
   - AppIcon.co - 다양한 크기 자동 생성

## 제작 후 적용 방법

```bash
# 1. 아이콘 이미지 준비 (1024x1024 PNG)
# 2. assets/icon/ 폴더에 저장

# 3. pubspec.yaml에 flutter_launcher_icons 추가
fvm flutter pub add flutter_launcher_icons --dev

# 4. 아이콘 생성
fvm flutter pub run flutter_launcher_icons

# 5. 앱 재빌드
fvm flutter clean
fvm flutter pub get
fvm flutter run
```

## 현재 상태
- ⏳ 기본 Flutter 아이콘 사용 중
- 📝 Next Line 브랜딩에 맞는 커스텀 아이콘 제작 필요

## 디자인 원칙
- **친근함**: 따뜻한 색상과 둥근 형태
- **명확함**: 한눈에 "대화/메시지" 관련 앱임을 알 수 있도록
- **차별성**: 다른 메시징 앱과 구별되는 독특한 디자인
- **심플함**: 복잡하지 않고 깔끔한 형태
