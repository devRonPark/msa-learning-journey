# Day 1 - Monolithic vs MSA 아키텍처 차이점

> **학습 기간**: 2025년 05월 31일 (토요일)  
> **학습 시간**: 2시간  
> **완료율**: 1/60일 (1.7%)

## 🎯 오늘의 학습 목표

- [ ] Monolithic 아키텍처의 정의와 문제점 이해
- [ ] MSA 아키텍처의 등장 배경과 핵심 특징 파악
- [ ] 두 아키텍처 패턴의 주요 차이점 정리

## 📚 학습 내용

### 주요 개념

### Monolithic 아키텍처

- 하나의 코드 베이스가 하나의 실행 환경에서 함께 동작하는 구조
- 모든 기능이 하나의 프로그램 안에 포함되어 있음
- 주요 문제점:
  - **개발 사이클 지연**: 작은 기능 하나를 수정하거나 새로운 기능을 추가할 때도 전체 애플리케이션을 테스트하고 컴파일한 후 배포해야 함. 예를 들어 사용자 프로필 수정 기능을 개선하더라도 결제, 주문, 상품 관리 등 모든 모듈이 함께 테스트되고 배포되어야 하므로 개발 속도가 현저히 느려짐.
  - **확장성 한계**: 애플리케이션 크기가 커질수록 빌드 시간, 테스트 시간이 기하급수적으로 증가하며, 여러 개발자가 동시에 작업할 때 코드 충돌이 빈번하게 발생. 또한 트래픽이 특정 기능(예: 결제) 에만 몰려도 전체 애플리케이션을 스케일 아웃해야 하므로 리소스 낭비가 심함.
  - **기술 스택 제약**: 전체 시스템이 하나의 프로그래밍 언어와 프레임워크에 묶여 있어, 새로운 기술을 도입하거나 특정 기능에 최적화된 기술을 사용하기 어려움. 예를 들어 실시간 처리에는 Node.js 가, 머신러닝에는 Python 이 적합하지만 전체가 Java 로 구성되어 있다면 선택의 여지가 없음.

### MSA(Microservices Architecture) 아키텍처

- 배포 단위를 작게 나누어 개발 및 배포 속도를 높이는 아키텍처
- 도메인 별로 단일 책임 원칙을 지키면서 서비스 분리
- 5가지 핵심 특징:
  1. **독립적인 서비스 분리**: 하나의 큰 애플리케이션을 기능별로 작은 서비스들로 나누는 것임. 예를 들어 쇼핑몰이라면 '사용자 관리', '상품 관리', '주문 처리', '결제' 를 각각 별도의 프로그램으로 만들어 운영. 각 서비스는 자신만의 데이터베이스를 가지므로 완전히 독립적으로 동작함.
  2. **비동기 통신**: 서비스끼리 대화할 때 즉시 답변을 기다리지 않고 메시지를 보내놓고 다른 일을 처리하는 방식임. 마치 이메일처럼 메시지를 보내고 나중에 답장을 받는 것과 비슷함. Kafka 같은 도구가 이런 메시지들을 안전하게 전달해주는 우체통 역할을 수행함.
  3. **기술 스택의 다양성**: 각 서비스마다 가장 적합한 프로그래밍 언어와 도구를 자유롭게 선택할 수 있음. 사용자 관리는 Java 로, 실시간 채팅은 Node.js 로, 데이터 분석은 Python 으로 만드는 식으로 각각의 특성에 맞는 최적의 기술을 사용함.
  4. **독립적인 배포와 확장**: 각 서비스를 따로따로 업데이트하고 배포할 수 있음. 결제 서비스에 문제가 생겨도 사용자 관리나 상품 조회는 정상 작동하며, 특정 서비스에만 트래픽이 몰리면 그 서비스만 서버를 추가해서 처리 능력을 높일 수 있음.
  5. **서비스 경계와 데이터 소유권**: 각 서비스는 자신의 데이터만 직접 관리하고, 다른 서비스의 데이터가 필요하면 반드시 API 를 통해 요청해야 함. 마치 각 부서가 자신의 서류함을 관리하고, 다른 부서 자료가 필요하면 공식적으로 요청하는 것과 같은 원리임.

### 실습 내용

아키텍처 비교 분석을 통한 이론 학습 위주로 진행

### 코드 스니펫

```yaml
# MSA 서비스 예시 구조
services:
  user-service:
    technology: Java/Spring Boot
    database: MySQL
    responsibility: 사용자 관리

  recommendation-service:
    technology: Python/Django
    database: MongoDB
    responsibility: 추천 시스템

  chat-service:
    technology: Node.js
    database: Redis
    responsibility: 실시간 채팅
```

## 💡 핵심 깨달음

- MSA 는 단순히 서비스를 작게 나누는 것이 아니라 **독립성** 과 **확작성** 을 확보하기 위한 아키텍처 패턴임.
- 각 서비스가 자신만의 데이터를 소유하고, 다른 서비스와는 API 를 통해서만 통신하는 것이 핵심임.
- 서비스 별로 최적의 기술 스택을 선택할 수 있어 개발 효율성 향상 가능함.

## 🤔 어려웠던 점

- 문제 상황: MSA 아키텍처에서 서비스 분리는 이해했지만, 왜 데이터베이스까지 도메인 별로 나눠야 하는지 그 필요성을 이해하기 어려웠음. 트랜잭션 격리 수준과 읽기 수준 개념이 등장했는데, 이 부분에 대한 사전 지식이 부족해서 개념 이해에 어려움이 있었음.
- 해결 과정: 최근 진행했던 부동산 CRM 프로젝트의 특정 기능을 예시로 들어서 이해해보았음. 중개인이 고객의 연락처를 변경하는 트랜잭션이 수행되는 도중, 매물 정보를 조회하는 트랜잭션에서 해당 매물과 연관된 상담 이력을 조회하면서 이 상담 이력에 고객의 연락처가 보여지는 상황을 생각해보니 이해가 되었음. 만약 고객 관리와 매물 관리가 하나의 데이터베이스를 공유한다면, 연락처 업데이트 중에 상담 이력 조회가 일관성 없는 데이터(변경 전 또는 후의 연락처) 를 보여줄 수 있는 문제가 발생할 수 있음.
- 참고 자료: 실제 프로젝트 경험과 연결해서 이해하는 것이 효과적이었음.

## 🔗 참고 자료

- NotebookLM 을 활용해서 MSA 키워드로 검색된 각종 영상 컨텐츠들을 활용함.

## ✅ 목표 달성도

- [ ] 달성한 목표
- [ ] 미완료 목표 (내일 이어서)

## 🎯 내일 계획

**Day 2**: MSA의 장단점 분석 및 도입 시점과 고려사항 학습

- MSA 도입의 장점과 단점을 구체적 사례와 함께 정리
- 언제 MSA를 도입해야 하고, 언제는 피해야 하는지 판단 기준 학습

## 📝 오늘의 Quiz

Q1. Monolithic 아키텍처의 3가지 주요 문제점은 무엇인가요?

<details>
<summary>정답 보기</summary>
1. 개발 사이클 지연 - 작은 기능 수정에도 전체 시스템 테스트/배포 필요
2. 확장성 한계 - 특정 기능에만 트래픽이 몰려도 전체 시스템 스케일 아웃 필요
3. 기술 스택 제약 - 하나의 기술 스택에 종속되어 최적화된 기술 선택 불가
</details>

Q2. MSA에서 각 서비스가 자신만의 데이터베이스를 가져야 하는 이유는 무엇인가요?

<details>
<summary>정답 보기</summary>
- 서비스 간 독립성 확보
- 데이터 일관성 문제 방지 (동시 접근 시 트랜잭션 충돌 방지)
- 각 서비스별 최적화된 데이터베이스 기술 선택 가능
- 한 서비스의 DB 문제가 다른 서비스에 영향을 주지 않음
</details>

Q3. Polyglot Architecture란 무엇이며, 어떤 장점이 있나요?

<details>
<summary>정답 보기</summary>
각 서비스마다 최적의 프로그래밍 언어와 기술 스택을 자유롭게 선택할 수 있는 아키텍처 방식
장점: 서비스 특성에 맞는 최적의 기술 활용으로 성능과 개발 효율성 향상
예시: 실시간 처리(Node.js), 데이터 분석(Python), 엔터프라이즈(Java) 등
</details>

---

**연속 학습일**: 1일 🔥
