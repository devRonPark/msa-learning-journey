# Day 3 - Domain Driven Design(DDD) 기초

> **학습 기간**: 2025년 06월 02일 (월요일)
> **학습 시간**: 약 1시간 30분
> **완료율**: 3/60일 (5.0%)

## 🎯 오늘의 학습 목표

- [x] DDD의 기본 개념 이해하기 (집합체, 집합체 루트, 바운디드 컨텍스트)
- [x] 데이터 일관성 보장 방법과 레포지토리 패턴 이해하기
- [x] DDD가 실제 설계에 어떻게 적용되는지 사례로 살펴보기

## 📚 학습 내용

### 주요 개념

- **집합체(Aggregate)**: 관련된 도메인 객체들을 하나로 묶어 복잡도를 관리하는 단위
- **집합체 루트(Aggregate Root)**: 집합체를 대표하며 외부에서 접근과 변경을 담당하는 핵심 엔티티
- **바운디드 컨텍스트(Bounded Context)**: 의미가 달라질 수 있는 도메인 개념들의 경계를 설정해 명확한 의미를 유지하는 영역
- **데이터 일관성 보장**: 집합체 루트를 통해 트랜잭션 범위를 관리해 무결성을 유지
- **레포지토리 패턴(Repository)**: 도메인 로직과 데이터 접근 로직을 분리하여 유연한 저장소 교체와 관리 가능

### 실습 내용

- 게시글(Post)와 댓글(Comment) 집합체 설계
- RESTful API 설계 시 집합체 루트를 기준으로 URL 설계하기
- 고객, 매물, 계약 도메인에서 집합체와 바운디드 컨텍스트 분리 사례

### 코드 스니펫

```java
// Post Aggregate Root 예시
public class Post {
    private Long id;
    private String title;
    private String content;
    private List<Comment> comments;

    public void addComment(Comment comment) {
        comments.add(comment);
        // 추가 비즈니스 로직 처리
    }

    // 댓글 수정, 삭제 등의 내부 로직도 Post에서 관리
}
```

## 💡 핵심 깨달음

- DDD는 단순 기능 구현을 넘어 비즈니스 본질과 사용자 경험을 중심으로 설계하는 방법론이다.
- 동일한 엔티티라도 바운디드 컨텍스트에 따라 다르게 설계되고 해석될 수 있다는 점이 인상적이었다.
- 레포지토리 패턴 덕분에 도메인 로직과 저장소 접근이 분리되어 유지보수와 확장성이 좋아진다.

## 🤔 어려웠던 점

- 문제 상황: 아직까지 DDD 기반 설계 방식이 익숙하지 않아 여전히 기능 구현 시 ERD 중심 모델링으로 생각하게 되는 부분. 그리고 API 구현 시에도 CRUD 중점으로 생각하게 됨.
- 해결 과정: 앞으로 다양한 주제의 핵심 기능이 담긴 토이 프로젝트를 통한 실습하며 익숙해질 예정.
- 참고 자료: DDD 공식 문서, 관련 블로그, 토비의 스프링 등

## 🔗 참고 자료

- [Domain-Driven Design 공식 홈페이지](https://domainlanguage.com/ddd/)
- [Vaughn Vernon의 Implementing Domain-Driven Design](https://www.amazon.com/Implementing-Domain-Driven-Design-Vaughn-Vernon/dp/0321834577)
- [DDD 소개 블로그](https://jojoldu.tistory.com/295)

## ✅ 목표 달성도

- [x] DDD 기본 개념 이해
- [x] 데이터 일관성 및 레포지토리 패턴 이해
- [ ] DDD 기반 프로젝트 설계 및 구현 (계속 학습 중)

## 🎯 내일 계획

- 실제 프로젝트에 DDD 적용하며 프롬프트 관리 서비스를 주제로 하는 토이 프로젝트 구현해보기

---

**연속 학습일**: 1일 🔥
