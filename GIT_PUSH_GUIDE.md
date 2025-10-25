# GitHub 푸시 가이드 🚀

## 첫 푸시 전 체크리스트

✅ `.env` 파일이 gitignore에 있고 커밋되지 않는지 확인
✅ `.mcp.json` 파일이 커밋되지 않는지 확인
✅ API 키가 노출되지 않는지 확인
✅ `.env.example` 파일은 커밋되어야 함 (API 키 없이)

## GitHub 저장소 생성 및 푸시

### 1. GitHub에서 새 저장소 생성

1. https://github.com/new 접속
2. Repository name: `next-line`
3. Description: "AI 기반 영어 답장 도우미"
4. Public or Private 선택
5. **Initialize this repository with 체크 해제** (이미 로컬에 코드가 있으므로)
6. "Create repository" 클릭

### 2. 로컬에서 Git 설정 및 커밋

```bash
# 현재 변경사항 확인
git status

# 모든 변경사항 스테이징
git add .

# 커밋 (민감한 파일들은 자동으로 제외됨)
git commit -m "Initial commit: Next Line AI 영어 답장 도우미

- AI 기반 영어 답장 생성 기능 구현
- 카카오톡 대화 이미지 분석
- Claude API 연동
- 다양한 톤 선택 기능
- 귀여운 UI/UX 디자인"
```

### 3. GitHub 저장소와 연결 및 푸시

```bash
# GitHub 저장소 연결 (your-username을 본인 깃허브 아이디로 변경)
git remote add origin https://github.com/your-username/next-line.git

# 현재 브랜치 이름 확인
git branch

# main 브랜치로 푸시
git push -u origin main
```

### 4. 푸시 후 확인사항

GitHub 저장소에 들어가서 다음을 확인하세요:

- ✅ `.env` 파일이 **없는지** (있으면 안됨!)
- ✅ `.mcp.json` 파일이 **없는지** (있으면 안됨!)
- ✅ `.env.example` 파일이 **있는지** (있어야 함)
- ✅ README.md가 제대로 표시되는지
- ✅ 코드가 정상적으로 업로드되었는지

## 실수로 민감한 파일을 커밋한 경우

만약 `.env`나 API 키를 실수로 커밋해서 푸시했다면:

```bash
# 1. 즉시 해당 커밋 제거
git reset --soft HEAD~1

# 2. .gitignore 재확인
cat .gitignore | grep -E "\.env|\.mcp"

# 3. 캐시 제거
git rm --cached .env .mcp.json

# 4. 다시 커밋
git add .
git commit -m "Fix: Remove sensitive files"

# 5. 강제 푸시 (히스토리 덮어쓰기)
git push --force

# 6. API 키 재발급
# Claude Console에서 기존 키 삭제하고 새로 발급
```

⚠️ **중요**: API 키가 노출되었다면 반드시 해당 키를 삭제하고 새로 발급받으세요!

## 협업 시 주의사항

다른 개발자가 프로젝트를 클론할 때:

1. `.env.example`을 복사하여 `.env` 생성
2. 자신의 Claude API 키 입력
3. `fvm flutter pub get` 실행
4. 개발 시작

## 지속적인 푸시

일상적인 변경사항 푸시:

```bash
# 변경사항 확인
git status

# 스테이징
git add .

# 커밋
git commit -m "Update: 기능 추가 또는 버그 수정 설명"

# 푸시
git push
```

## 브랜치 전략 (선택사항)

더 체계적인 개발을 원한다면:

```bash
# 새 기능 개발
git checkout -b feature/new-feature

# 개발 후 커밋
git add .
git commit -m "Add: 새로운 기능"

# 메인에 병합
git checkout main
git merge feature/new-feature

# 푸시
git push
```

---

Happy Coding! 🎉
