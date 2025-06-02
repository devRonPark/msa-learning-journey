# Day 2 - MSA 장단점 및 도입 시점 분석

> **학습 기간**: 2025년 06월 02일 (월요일)  
> **학습 시간**: 2시간  
> **완료율**: 2/60일 (3.3%)

## 🎯 오늘의 학습 목표

- [x] MSA 도입의 장점과 단점을 구체적 사례와 함께 정리
- [x] 언제 MSA를 도입해야 하고, 언제는 피해야 하는지 판단 기준 학습
- [x] 실제 시나리오를 통한 MSA 문제 해결 능력 배양

## 📚 학습 내용

### 주요 개념

**1. MSA의 5가지 핵심 특징**

- 독립적 배포 가능
- 비즈니스 도메인 중심 설계
- API 기반 통신
- 분산 데이터 관리
- 기술 스택의 자유

**2. MSA의 주요 장점**

- **독립적 확장성**: 필요한 서비스만 선택적으로 스케일링
- **기술 스택 다양성**: 서비스별 최적 기술 선택 (Java-안정성, Node.js-속도, Python-ML)
- **장애 격리**: Netflix 사례 - 추천 서비스 다운되어도 스트리밍 서비스는 정상 운영
- **개발팀 자율성**: Amazon Two-Pizza Rule (6-8명 팀, 서비스별 완전한 소유권)
- **빠른 배포**: Netflix는 하루 수천 번 독립적 배포

**3. MSA의 주요 단점**

- **복잡성 폭증**: 서비스 간 통신 관리, 분산 트랜잭션 처리, 서비스 발견과 라우팅
- **네트워크 지연**: 모놀리식 메소드 호출(<1ms) vs MSA HTTP 호출(10-100ms)
- **데이터 일관성 문제**: 분산 트랜잭션에서의 부분 실패 처리
- **운영 오버헤드**: 서비스별 모니터링, 로그 통합 관리, 배포 파이프라인 복잡화
- **테스팅 복잡성**: 통합 테스트 환경 구축, 서비스 모킹 필요

**4. MSA 도입 의사결정 기준**

**도입 추천 조건:**

- 개발팀 15명 이상
- 서비스별 확장 요구사항 상이
- 명확한 비즈니스 도메인 경계
- 충분한 DevOps 역량

**모놀리식 유지 추천 조건:**

- 팀 규모 10명 이하
- MVP/프로토타입 단계
- 불분명한 도메인 경계
- DevOps 역량 부족

**5. Martin Fowler의 "Monolith First" 원칙**

- 작게 시작해서 경계를 찾아라
- 도메인 이해 후 분해하라
- Strangler Fig Pattern을 통한 점진적 전환

### 실습 내용

**실습 1: Black Friday 트래픽 분석**

- 서비스별 트래픽 증가율 분석: 결제(22.5배) > 주문(20배) > 상품조회(10배) > 사용자등록(1.6배)
- **핵심 깨달음**: 결제 서비스 트래픽이 가장 크지만, 주문 처리 서비스를 우선 확장해야 함
- **이유**: 결제는 주문 완료 후에만 실행되므로, 상류 서비스인 주문 처리가 병목이 되면 결제까지 도달하지 못함

**실습 2: 분산 트랜잭션 문제 해결 (Saga 패턴)**

- 시나리오: 게임 아이템 구매 (포인트 차감 → 아이템 추가 → 구매 기록)
- 문제 상황: 2단계(아이템 추가)에서 서버 오류 발생
- **해결 방안**: Saga 패턴의 보상 트랜잭션으로 포인트 차감을 롤백

**실습 3: MSA 도입 의사결정**

- 회사 상황: 개발팀 25명, MAU 100만, 소셜미디어 플랫폼, DevOps팀 3명
- **결론**: MSA 도입 추천
- **근거**: 배포 중단 문제 해결, 독립적 확장 가능, 충분한 인력과 DevOps 역량

### 코드 스니펫

```java
// 온라인 게임 아이템 구매 Saga 패턴 구현
@Service
public class ItemPurchaseSagaService {

    @Autowired
    private AccountService accountService;

    @Autowired
    private InventoryService inventoryService;

    @Autowired
    private OrderService orderService;

    // Saga 진행 상황을 저장할 저장소
    private Map<String, ItemPurchaseSaga> sagaStorage = new ConcurrentHashMap<>();

    /**
     * 아이템 구매 Saga 시작
     */
    public String startPurchase(Long userId, String itemId, int price) {
        // 1. Saga 객체 생성
        String sagaId = UUID.randomUUID().toString();
        ItemPurchaseSaga saga = new ItemPurchaseSaga(sagaId, userId, itemId, price);
        sagaStorage.put(sagaId, saga);

        System.out.println("🚀 Saga 시작: " + sagaId);

        // 2. 첫 번째 단계 실행
        executeStep1_DeductMoney(saga);

        return sagaId;
    }

    /**
     * 1단계: 게임머니 차감
     */
    private void executeStep1_DeductMoney(ItemPurchaseSaga saga) {
        System.out.println("💰 1단계: 게임머니 차감 시도...");

        try {
            MoneyDeductResult result = accountService.deductMoney(
                saga.getUserId(), saga.getPrice()
            );

            if (result.isSuccess()) {
                saga.setMoneyDeducted(true);
                saga.setMoneyTransactionId(result.getTransactionId());

                System.out.println("✅ 1단계 성공: " + saga.getPrice() + "원 차감 완료");
                executeStep2_AddItem(saga);  // 다음 단계 실행

            } else {
                System.out.println("❌ 1단계 실패: " + result.getErrorMessage());
                completeSaga(saga, "FAILED_INSUFFICIENT_MONEY");
            }

        } catch (Exception e) {
            System.out.println("💀 1단계 예외 발생: " + e.getMessage());
            completeSaga(saga, "FAILED_MONEY_SERVICE_ERROR");
        }
    }

    /**
     * 2단계: 아이템 지급
     */
    private void executeStep2_AddItem(ItemPurchaseSaga saga) {
        System.out.println("🎒 2단계: 아이템 지급 시도...");

        try {
            ItemAddResult result = inventoryService.addItem(
                saga.getUserId(), saga.getItemId()
            );

            if (result.isSuccess()) {
                saga.setItemAdded(true);
                saga.setItemTransactionId(result.getTransactionId());

                System.out.println("✅ 2단계 성공: " + saga.getItemId() + " 지급 완료");
                executeStep3_RecordPurchase(saga);  // 다음 단계 실행

            } else {
                System.out.println("❌ 2단계 실패: " + result.getErrorMessage());
                System.out.println("🔄 1단계 롤백 시작...");
                compensateStep1_RefundMoney(saga);  // 보상 트랜잭션 실행
            }

        } catch (Exception e) {
            System.out.println("💀 2단계 예외 발생: " + e.getMessage());
            System.out.println("🔄 1단계 롤백 시작...");
            compensateStep1_RefundMoney(saga);
        }
    }

    /**
     * 보상 트랜잭션: 게임머니 환불
     */
    private void compensateStep1_RefundMoney(ItemPurchaseSaga saga) {
        System.out.println("💸 보상 트랜잭션: 게임머니 환불 시도...");

        if (!saga.isMoneyDeducted()) {
            System.out.println("⚠️ 돈 차감이 안되어 있어서 환불할 필요 없음");
            completeSaga(saga, "COMPENSATION_COMPLETED");
            return;
        }

        try {
            RefundResult result = accountService.refundMoney(
                saga.getUserId(),
                saga.getPrice(),
                saga.getMoneyTransactionId()  // 원래 거래 ID로 환불
            );

            if (result.isSuccess()) {
                saga.setMoneyDeducted(false);  // 롤백 완료 표시
                System.out.println("✅ 보상 트랜잭션 성공: " + saga.getPrice() + "원 환불 완료");
                completeSaga(saga, "COMPENSATION_COMPLETED");

            } else {
                System.out.println("❌ 보상 트랜잭션 실패: " + result.getErrorMessage());
                System.out.println("🚨 수동 처리 필요! 사용자에게 " + saga.getPrice() + "원 환불 요망");
                completeSaga(saga, "COMPENSATION_FAILED");
            }

        } catch (Exception e) {
            System.out.println("💀 보상 트랜잭션 예외: " + e.getMessage());
            System.out.println("🚨 긴급! 수동 처리 필요!");
            completeSaga(saga, "COMPENSATION_FAILED");
        }
    }
}
```

```java
// Saga 상태 관리 객체
public class ItemPurchaseSaga {
    private String sagaId;              // 이 구매 과정의 고유 ID
    private Long userId;                // 구매하는 사용자
    private String itemId;              // 구매할 아이템
    private int price;                  // 아이템 가격

    // 각 단계의 완료 상태를 추적
    private boolean moneyDeducted = false;      // 돈을 차감했는가?
    private boolean itemAdded = false;          // 아이템을 지급했는가?
    private boolean purchaseRecorded = false;   // 구매를 기록했는가?

    // 실패 시 롤백에 필요한 정보들
    private String moneyTransactionId;          // 돈 차감 거래 ID
    private String itemTransactionId;           // 아이템 지급 거래 ID
    private String orderTransactionId;          // 주문 기록 ID

    // 현재 진행 상황을 확인하는 메소드
    public boolean isCompleted() {
        return moneyDeducted && itemAdded && purchaseRecorded;
    }

    public boolean hasFailed() {
        // 어떤 단계가 실행되었지만 완료되지 않은 경우
        return (moneyDeducted && !itemAdded) ||
               (itemAdded && !purchaseRecorded);
    }

    // 생성자, getter, setter...
}
```

## 💡 핵심 깨달음

- **MSA는 만능이 아니다**: 복잡성이 크게 증가하므로 충분한 규모와 역량이 있을 때만 도입해야 함
- **의존성 순서가 중요하다**: 트래픽 증가율만 보고 확장하면 안 되고, 서비스 간 의존 관계를 고려해야 함 (주문 → 결제 순서)
- **분산 환경에서는 부분 실패가 필연적이다**: Saga 패턴 같은 보상 메커니즘을 미리 설계해야 함
- **Saga 패턴의 핵심**: "큰 트랜잭션을 작은 단계들로 나누고, 실패하면 이미 한 일들을 되돌린다"
- **상태 추적의 중요성**: 각 단계의 완료 여부와 트랜잭션 ID를 저장해야 정확한 롤백이 가능함

## 🤔 어려웠던 점

- **문제 상황**: 분산 트랜잭션에서 부분 실패 처리 방법이 복잡함
- **해결 과정**: Saga 패턴의 보상 트랜잭션 개념을 게임 아이템 구매 시나리오로 구체적으로 이해
- **핵심 학습**: 모놀리식에서는 `@Transactional` 하나로 해결되던 것이 MSA에서는 각 단계별 성공/실패 처리 + 보상 트랜잭션 구현이 필요함

## 🔗 참고 자료

- [Martin Fowler - Microservices](https://martinfowler.com/articles/microservices.html)
- [Netflix Technology Blog](https://netflixtechblog.com/)
- [Sam Newman - Building Microservices (책)](https://www.amazon.com/Building-Microservices-Designing-Fine-Grained-Systems/dp/1491950358)
- [Spring Cloud 공식 문서](https://spring.io/projects/spring-cloud)

## ✅ 목표 달성도

- [x] MSA 장단점을 실제 사례(Netflix, Amazon)와 함께 정리
- [x] MSA 도입 의사결정 체크리스트 학습 및 실제 케이스 분석
- [x] Saga 패턴을 통한 분산 트랜잭션 문제 해결 방법 완전 이해
- [x] 3가지 실습을 통한 MSA 실무 문제 해결 능력 배양

## 🎯 내일 계획

**Day 3: DDD 기초 및 서비스 분해 전략**

- Domain-Driven Design 핵심 개념 학습
- Bounded Context를 통한 올바른 서비스 경계 설정
- Event Storming을 활용한 도메인 모델링 실습
- MSA 전환 로드맵 작성 및 단계적 적용 전략

---

**연속 학습일**: 1일 🔥🔥
