# 📝 Commit Convention

## 🎯 기본 규칙

### 📋 커밋 메시지 구조

```
<type>(<scope>): <subject>

<body>

<footer>
```

### 📌 예시

```
feat(user-service): 회원가입 API 구현

- User Entity 및 Repository 추가
- JWT 토큰 기반 인증 로직 구현
- 회원가입 validation 추가

Closes #15
```

## 🏷️ Type (필수)

| Type       | 설명                           | 예시                                                   |
| ---------- | ------------------------------ | ------------------------------------------------------ |
| `feat`     | 새로운 기능 추가               | `feat(product-service): 상품 검색 API 구현`            |
| `fix`      | 버그 수정                      | `fix(order-service): 주문 생성 시 재고 검증 오류 수정` |
| `docs`     | 문서 수정/추가                 | `docs: Day 5 학습 기록 추가`                           |
| `style`    | 코드 포맷팅, 세미콜론 누락 등  | `style(gateway): 코드 포맷팅 적용`                     |
| `refactor` | 코드 리팩토링 (기능 변경 없음) | `refactor(user-service): UserService 로직 분리`        |
| `test`     | 테스트 코드 추가/수정          | `test(product-service): 상품 CRUD 통합테스트 추가`     |
| `chore`    | 빌드, 설정 파일 수정           | `chore: Docker Compose 환경 설정 추가`                 |
| `perf`     | 성능 개선                      | `perf(product-service): Redis 캐싱 적용`               |
| `ci`       | CI/CD 관련 수정                | `ci: GitHub Actions 워크플로우 추가`                   |
| `build`    | 빌드 시스템 관련 수정          | `build: Gradle 의존성 업데이트`                        |

## 🎯 Scope (선택사항)

### 📦 서비스별 Scope

- `user-service`: 사용자 서비스 관련
- `product-service`: 상품 서비스 관련
- `order-service`: 주문 서비스 관련
- `payment-service`: 결제 서비스 관련
- `notification-service`: 알림 서비스 관련

### 🏗️ 인프라별 Scope

- `gateway`: API Gateway 관련
- `discovery`: Service Discovery 관련
- `monitoring`: 모니터링 관련
- `docker`: Docker 관련
- `config`: 설정 관련

### 📚 학습별 Scope

- `docs`: 문서/학습 기록
- `til`: Today I Learned
- `blog`: 블로그 포스팅

## ✍️ Subject 작성 규칙

### ✅ Good Examples

```
feat(user-service): JWT 인증 미들웨어 구현
fix(order-service): 주문 취소 시 재고 복원 로직 수정
docs: Day 10 MSA 설계 패턴 학습 정리
test(product-service): 상품 카테고리 API 테스트 추가
refactor(gateway): 라우팅 설정 yml 파일로 분리
```

### ❌ Bad Examples

```
fix: 버그 수정 (구체적이지 않음)
feat: 새 기능 (무엇인지 알 수 없음)
update user service (type 누락)
FEAT: USER API (대문자 사용)
feat(user-service): 사용자 관리 기능을 구현했습니다. (마침표 사용)
```

### 📏 작성 가이드

- **50자 이내**로 작성
- **동사 원형**으로 시작 (구현, 추가, 수정, 삭제 등)
- **마침표 사용 금지**
- **한글 사용** (팀 프로젝트가 아닌 개인 학습이므로)

## 📄 Body 작성 규칙

### 📝 작성 시점

다음 경우에 Body를 작성합니다:

- 변경 사항이 복잡하거나 여러 개일 때
- 왜 이렇게 구현했는지 설명이 필요할 때
- 학습 과정에서 특별히 기록하고 싶은 내용이 있을 때

### ✍️ 작성 방식

```
feat(order-service): SAGA 패턴을 활용한 분산 트랜잭션 구현

- OrderSaga 클래스 추가하여 주문 프로세스 관리
- 결제 실패 시 주문 취소 보상 트랜잭션 구현
- 각 단계별 상태 관리를 위한 SagaState enum 추가
- RabbitMQ를 통한 이벤트 기반 통신으로 서비스 간 결합도 감소

학습 포인트: 분산 시스템에서 데이터 일관성 보장 방법 이해
```

## 🔗 Footer 작성 규칙

### 🎫 이슈 연결

```
Closes #15          # 이슈 완전 해결
Fixes #23           # 버그 수정
Refs #7             # 이슈 참조
Related to #12      # 관련 이슈
```

### ⚠️ Breaking Changes

```
BREAKING CHANGE: API 응답 형식 변경

기존 `/api/users` 응답에서 `user_id`를 `id`로 변경
마이그레이션 가이드: docs/migration-guide.md 참조
```

## 🎯 MSA 학습 특화 컨벤션

### 📅 일별 학습 기록

```
docs(til): Day 15 User Service 도메인 모델 구현

- User, UserProfile Entity 설계 및 구현
- JPA Repository 패턴 적용
- 학습 시간: 1시간
- 어려웠던 점: JPA 연관관계 매핑

Day 15/60 완료 ✅
```

### 🏗️ 아키텍처 변경

```
feat(architecture): API Gateway 패턴 도입

- Spring Cloud Gateway 설정 추가
- 라우팅 규칙 및 필터 체인 구성
- 로드 밸런싱 및 서킷 브레이커 적용

MSA 핵심 패턴 중 하나인 API Gateway 학습 완료
```

### 🐛 학습 중 발견한 문제 해결

```
fix(docker): 서비스 간 통신 네트워크 오류 해결

Docker Compose 네트워크 설정에서 서비스명으로
호스트 접근이 안 되는 문제 발견

해결 방법:
- depends_on 설정 추가
- 커스텀 네트워크 생성하여 서비스 간 격리

학습: Docker 네트워킹 개념 이해 필요
```

## 🔄 커밋 주기

### 📊 권장 커밋 패턴

- **매일 학습 후**: docs(til) 타입으로 학습 기록
- **기능 단위**: feat, fix 타입으로 개발 내용
- **주차 마무리**: docs 타입으로 주간 회고

### 📈 예시 커밋 히스토리

```
docs(til): Day 16 User 도메인 모델 구현
feat(user-service): User Entity 및 Repository 추가
test(user-service): User Repository 단위 테스트 작성
style(user-service): 코드 포맷팅 적용
docs(til): Day 15 User Service 프로젝트 생성
chore: User Service 초기 Spring Boot 프로젝트 설정
docs: 2주차 학습 계획 업데이트
```

## 🎨 커밋 메시지 템플릿

Git 커밋 템플릿 설정:

```bash
# ~/.gitmessage 파일 생성
<type>(<scope>): <subject>

# 변경사항 설명 (선택사항)
-
-
-

# 학습 포인트 (학습 관련 커밋 시)
학습 포인트:

# 이슈 연결 (해당시)
Closes #
```

설정 적용:

```bash
git config commit.template ~/.gitmessage
```

이 커밋 컨벤션을 따르면 **60일 후 커밋 히스토리만 봐도 체계적인 학습 과정을 확인**할 수 있어 포트폴리오 효과가 극대화될 것입니다! 🚀
