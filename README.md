# 🏗️ MSA Learning Journey

> **목표**: 60일간 하루 1시간씩 투자하여 Microservices Architecture(MSA) 실무 경험 쌓기  
> **기간**: 2025.05.31 - 2025.07.30  
> **프로젝트**: 온라인 쇼핑몰 시스템을 MSA로 구현

[![GitHub stars](https://img.shields.io/github/stars/username/msa-learning-journey?style=social)](https://github.com/devRonPark/msa-learning-journey)
[![GitHub forks](https://img.shields.io/github/forks/username/msa-learning-journey?style=social)](https://github.com/devRonPark/msa-learning-journey)
[![학습 진행률](https://img.shields.io/badge/학습진행률-1%2F60일-blue)](https://github.com/devRonPark/msa-learning-journey)

## 📋 프로젝트 개요

이 레포지토리는 백엔드 개발자로서 MSA 실무 경험을 체계적으로 쌓기 위한 60일간의 학습 여정을 기록합니다. 이론 학습부터 실제 마이크로서비스 구현, 운영까지 전 과정을 다룹니다.

### 🎯 학습 목표
- [ ] MSA 아키텍처 패턴 이해 및 적용
- [ ] Spring Cloud 생태계 활용 경험
- [ ] 서비스 간 통신 (동기/비동기) 구현
- [ ] 분산 시스템 운영 노하우 습득
- [ ] 실무에서 어필 가능한 포트폴리오 완성

## 🏛️ 시스템 아키텍처

### 📦 마이크로서비스 구성

| 서비스명 | 역할 | 기술 스택 | 포트 | 상태 |
|---------|------|----------|------|------|
| **User Service** | 사용자 관리, 인증/인가 | Spring Boot, JWT, MySQL | 8081 | ⏳ 예정 |
| **Product Service** | 상품 관리, 카탈로그 | Spring Boot, Redis, MySQL | 8082 | ⏳ 예정 |
| **Order Service** | 주문 처리, 주문 이력 | Spring Boot, MySQL | 8083 | ⏳ 예정 |
| **Payment Service** | 결제 처리 | Spring Boot, MySQL | 8084 | ⏳ 예정 |
| **Notification Service** | 알림 발송 | Spring Boot, RabbitMQ | 8085 | ⏳ 예정 |

### 🔧 인프라 구성

| 컴포넌트 | 역할 | 기술 | 포트 | 상태 |
|---------|------|------|------|------|
| **API Gateway** | 라우팅, 인증, 로드밸런싱 | Spring Cloud Gateway | 8080 | ⏳ 예정 |
| **Service Discovery** | 서비스 등록/발견 | Eureka Server | 8761 | ⏳ 예정 |
| **Message Queue** | 비동기 메시징 | RabbitMQ | 5672 | ⏳ 예정 |
| **Monitoring** | 메트릭 수집/시각화 | Prometheus, Grafana | 3000, 9090 | ⏳ 예정 |
| **Logging** | 로그 수집/분석 | ELK Stack | 9200, 5601 | ⏳ 예정 |

## 📅 학습 계획 및 진행률

### 🗓️ 주차별 로드맵

<details>
<summary><strong>1주차: MSA 기초 이론 (Day 1-7)</strong></summary>

- [x] **Day 1**: Monolithic vs MSA 아키텍처 차이점 이해 ✅
- [ ] **Day 2**: MSA 장단점 및 도입 시점 분석
- [ ] **Day 3**: Domain Driven Design(DDD) 기초
- [ ] **Day 4**: 서비스 분해 전략 학습
- [ ] **Day 5**: MSA 필수 기술 스택 조사
- [ ] **Day 6**: Spring Cloud 생태계 이해
- [ ] **Day 7**: 1주차 학습 내용 정리

**진행률**: 1/7 (14.3%) 🔄
</details>

<details>
<summary><strong>2주차: 프로젝트 설계 및 환경 구성 (Day 8-14)</strong></summary>

- [ ] **Day 8**: 실습 프로젝트 주제 선정
- [ ] **Day 9**: 서비스 분해 설계
- [ ] **Day 10**: 데이터베이스 설계
- [ ] **Day 11**: 기술 스택 최종 결정
- [ ] **Day 12**: 개발 환경 구성
- [ ] **Day 13**: Git 레포지토리 구성
- [ ] **Day 14**: 2주차 정리 및 다음 주 계획

**진행률**: 0/7 (0%) ⏳
</details>

<details>
<summary><strong>3주차: User Service 개발 (Day 15-21)</strong></summary>

- [ ] **Day 15**: User Service 프로젝트 생성
- [ ] **Day 16**: User 도메인 모델 구현
- [ ] **Day 17**: User Service 비즈니스 로직 구현
- [ ] **Day 18**: User REST API 구현
- [ ] **Day 19**: JWT 인증 구현
- [ ] **Day 20**: User Service 테스트 작성
- [ ] **Day 21**: User Service Docker화

**진행률**: 0/7 (0%) ⏳
</details>

<details>
<summary><strong>4주차: Product Service 개발 (Day 22-28)</strong></summary>

- [ ] **Day 22**: Product Service 프로젝트 생성
- [ ] **Day 23**: Product 도메인 모델 구현
- [ ] **Day 24**: Product Service 비즈니스 로직 구현
- [ ] **Day 25**: Product REST API 구현
- [ ] **Day 26**: Redis 캐싱 적용
- [ ] **Day 27**: Product Service 테스트 작성
- [ ] **Day 28**: Product Service Docker화

**진행률**: 0/7 (0%) ⏳
</details>

<details>
<summary><strong>5주차: Order Service 개발 (Day 29-35)</strong></summary>

- [ ] **Day 29**: Order Service 프로젝트 생성
- [ ] **Day 30**: Order 도메인 모델 구현
- [ ] **Day 31**: Order Service 비즈니스 로직 구현
- [ ] **Day 32**: 서비스 간 HTTP 통신 구현
- [ ] **Day 33**: Order REST API 구현
- [ ] **Day 34**: Order Service 테스트 작성
- [ ] **Day 35**: Order Service Docker화

**진행률**: 0/7 (0%) ⏳
</details>

<details>
<summary><strong>6주차: API Gateway 및 Service Discovery (Day 36-42)</strong></summary>

- [ ] **Day 36**: Eureka Server 구현
- [ ] **Day 37**: 각 서비스를 Eureka Client로 등록
- [ ] **Day 38**: Spring Cloud Gateway 구현
- [ ] **Day 39**: Gateway 필터 구현
- [ ] **Day 40**: 로드 밸런싱 설정
- [ ] **Day 41**: Gateway 통합 테스트
- [ ] **Day 42**: Gateway Docker화

**진행률**: 0/7 (0%) ⏳
</details>

<details>
<summary><strong>7주차: 메시징 시스템 구현 (Day 43-49)</strong></summary>

- [ ] **Day 43**: RabbitMQ 환경 구성
- [ ] **Day 44**: Payment Service 생성
- [ ] **Day 45**: 주문-결제 비동기 메시징 구현
- [ ] **Day 46**: Notification Service 구현
- [ ] **Day 47**: 이벤트 기반 아키텍처 구현
- [ ] **Day 48**: 메시지 큐 에러 처리
- [ ] **Day 49**: 메시징 시스템 테스트

**진행률**: 0/7 (0%) ⏳
</details>

<details>
<summary><strong>8주차: Docker Compose 및 모니터링 (Day 50-56)</strong></summary>

- [ ] **Day 50**: Docker Compose 파일 작성
- [ ] **Day 51**: 환경별 설정 분리
- [ ] **Day 52**: Prometheus 모니터링 설정
- [ ] **Day 53**: Grafana 대시보드 구성
- [ ] **Day 54**: 헬스체크 구현
- [ ] **Day 55**: 로그 수집 시스템 구축
- [ ] **Day 56**: 서킷브레이커 패턴 적용

**진행률**: 0/7 (0%) ⏳
</details>

<details>
<summary><strong>9주차: 문서화 및 포트폴리오 정리 (Day 57-60)</strong></summary>

- [ ] **Day 57**: README.md 작성
- [ ] **Day 58**: API 문서화 (Swagger/OpenAPI)
- [ ] **Day 59**: 블로그 포스팅 1편 작성
- [ ] **Day 60**: 최종 테스트 및 배포 가이드 작성

**진행률**: 0/4 (0%) ⏳
</details>

### 📊 전체 진행률
**1 / 60일 완료** (1.7%)

## 🚀 빠른 시작

### 📋 사전 요구사항
- Java 17+
- Docker & Docker Compose
- IntelliJ IDEA (권장)
- Postman (API 테스트용)

### 🔧 로컬 실행 방법

```bash
# 1. 레포지토리 클론
git clone https://github.com/devRonPark/msa-learning-journey.git
cd msa-learning-journey

# 2. 전체 시스템 실행
docker-compose up -d

# 3. 서비스 상태 확인
curl http://localhost:8080/actuator/health
```

### 🌐 주요 엔드포인트

| 서비스 | URL | 설명 |
|--------|-----|------|
| API Gateway | http://localhost:8080 | 메인 진입점 |
| Eureka Dashboard | http://localhost:8761 | 서비스 디스커버리 |
| RabbitMQ Management | http://localhost:15672 | 메시지 큐 관리 |
| Grafana Dashboard | http://localhost:3000 | 모니터링 대시보드 |

## 📁 프로젝트 구조

```
msa-learning-journey/
├── 📁 docs/                    # 학습 문서 및 TIL
│   ├── daily-logs/             # 일별 학습 기록
│   ├── architecture/           # 아키텍처 설계 문서
│   └── troubleshooting/        # 문제 해결 과정
├── 📁 services/                # 마이크로서비스들
│   ├── user-service/           # 사용자 서비스
│   ├── product-service/        # 상품 서비스
│   ├── order-service/          # 주문 서비스
│   ├── payment-service/        # 결제 서비스
│   └── notification-service/   # 알림 서비스
├── 📁 infrastructure/          # 인프라 관련
│   ├── gateway/                # API Gateway
│   ├── discovery/              # Service Discovery
│   └── monitoring/             # 모니터링 설정
├── 📁 docker/                  # Docker 관련 파일
│   ├── docker-compose.yml      # 전체 시스템 구성
│   └── environments/           # 환경별 설정
└── 📁 scripts/                 # 유틸리티 스크립트
    ├── build.sh                # 빌드 스크립트
    └── deploy.sh               # 배포 스크립트
```

## 🛠️ 기술 스택

### Backend
![Java](https://img.shields.io/badge/Java-17-orange?style=flat-square&logo=java)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.1-green?style=flat-square&logo=spring)
![Spring Cloud](https://img.shields.io/badge/Spring%20Cloud-2022.0-green?style=flat-square&logo=spring)

### Database
![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?style=flat-square&logo=mysql)
![Redis](https://img.shields.io/badge/Redis-7.0-red?style=flat-square&logo=redis)

### Message Queue
![RabbitMQ](https://img.shields.io/badge/RabbitMQ-3.11-orange?style=flat-square&logo=rabbitmq)

### DevOps
![Docker](https://img.shields.io/badge/Docker-Latest-blue?style=flat-square&logo=docker)
![Prometheus](https://img.shields.io/badge/Prometheus-Latest-red?style=flat-square&logo=prometheus)
![Grafana](https://img.shields.io/badge/Grafana-Latest-orange?style=flat-square&logo=grafana)

### Testing
![JUnit](https://img.shields.io/badge/JUnit-5-green?style=flat-square&logo=junit5)
![Testcontainers](https://img.shields.io/badge/Testcontainers-1.18-blue?style=flat-square)

## 📚 학습 자료

### 📖 추천 도서
- 📕 **마이크로서비스 패턴** - 크리스 리처드슨
- 📗 **도메인 주도 설계** - 에릭 에반스
- 📘 **Spring in Action** - 크레이그 월즈

### 🎥 온라인 강의

### 🔗 유용한 링크
- [Spring Cloud 공식 문서](https://spring.io/projects/spring-cloud)
- [마이크로서비스 아키텍처 패턴](https://microservices.io/)
- [12 Factor App](https://12factor.net/)

## 📝 블로그 포스팅 시리즈

### 📄 작성 예정 글
- [ ] MSA 도입기: 프로젝트 설계부터 구현까지
- [ ] Spring Cloud Gateway로 API Gateway 구축하기
- [ ] RabbitMQ를 활용한 비동기 메시징 패턴
- [ ] Docker Compose로 MSA 환경 구축하기
- [ ] Prometheus와 Grafana로 MSA 모니터링하기

## 🤝 기여하기

이 프로젝트는 개인 학습용이지만, 피드백이나 개선 제안은 언제나 환영합니다!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📞 연락처

- **GitHub**: [@username](https://github.com/username)
- **Blog**: [블로그 주소](https://blog.example.com)
- **Email**: your.email@example.com

## 📄 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다. 자세한 내용은 [LICENSE](LICENSE) 파일을 참조하세요.

---

<p align="center">
  <strong>⭐ 이 프로젝트가 도움이 되었다면 Star를 눌러주세요! ⭐</strong>
</p>

<p align="center">
  <img src="https://github-readme-stats.vercel.app/api?username=username&show_icons=true&theme=radical" alt="GitHub Stats">
</p>
