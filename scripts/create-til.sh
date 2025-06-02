#!/bin/bash

# =============================================================================
# MSA Learning Journey - TIL 자동화 스크립트
# =============================================================================

# 설정 변수
PROJECT_ROOT="$(pwd)"
DOCS_DIR="$PROJECT_ROOT/docs"
DAILY_LOGS_DIR="$DOCS_DIR/daily-logs"
START_DATE="2025-05-31"  # 프로젝트 시작일

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# =============================================================================
# 함수 정의
# =============================================================================

# 날짜 계산 함수
calculate_day_number() {
    local current_date=$(date +%Y-%m-%d)
    # 날짜를 타임스탬프로 변환 (macOS/Linux 호환)
    if date -d "$START_DATE" +%s > /dev/null 2>&1; then
        # GNU date 사용 가능 (Linux)
        start_timestamp=$(date -d "$START_DATE" +%s)
        current_timestamp=$(date -d "$current_date" +%s)
    else
        # BSD date 사용 (macOS)
        start_timestamp=$(date -jf "%Y-%m-%d" "$START_DATE" +%s)
        current_timestamp=$(date +%s)
    fi

    local diff_days=$(( (current_timestamp - start_timestamp) / 86400 + 1 ))
    echo $diff_days
}

# 주차 계산 함수
calculate_week_number() {
    local day_num=$1
    echo $(( (day_num - 1) / 7 + 1 ))
}

# 진행률 계산 함수
calculate_progress() {
    local day_num=$1
    local progress=$(( day_num * 100 / 60 ))
    echo $progress
}

# 디렉토리 생성 함수
create_directories() {
    local week_num=$1
    local week_dir="$DAILY_LOGS_DIR/week-$(printf "%02d" $week_num)"
    
    if [ ! -d "$week_dir" ]; then
        mkdir -p "$week_dir"
        echo -e "${GREEN}✅ Created directory: week-$(printf "%02d" $week_num)${NC}"
    fi
}

# TIL 템플릿 생성 함수
create_til_template() {
    local day_num=$1
    local week_num=$2
    local current_date=$(date +%Y년\ %m월\ %d일)
    local current_weekday=$(date +%A)
    local progress=$(calculate_progress $day_num)
    
    local week_dir="$DAILY_LOGS_DIR/week-$(printf "%02d" $week_num)"
    local til_file="$week_dir/day-$(printf "%02d" $day_num).md"
    
    # 학습 주제 매핑 (60일 계획 기반)
    local topic=$(get_learning_topic $day_num)
    
    cat > "$til_file" << EOF
# Day $day_num - $topic

> **학습 기간**: $current_date ($current_weekday)  
> **학습 시간**: _시간  
> **완료율**: $day_num/60일 ($progress.0%)

## 🎯 오늘의 학습 목표
- [ ] 목표 1
- [ ] 목표 2
- [ ] 목표 3

## 📚 학습 내용

### 주요 개념


### 실습 내용


### 코드 스니펫
\`\`\`java
// 중요한 코드나 설정
\`\`\`

## 💡 핵심 깨달음
- 배운 점 1
- 배운 점 2
- 배운 점 3

## 🤔 어려웠던 점
- 문제 상황:
- 해결 과정:
- 참고 자료:

## 🔗 참고 자료
- [링크 1](URL)
- [링크 2](URL)

## ✅ 목표 달성도
- [ ] 달성한 목표
- [ ] 미완료 목표 (내일 이어서)

## 🎯 내일 계획
[내일 학습할 내용 간략히]

---
**연속 학습일**: $day_num일 🔥
EOF

    echo -e "${GREEN}📝 Created TIL template: day-$(printf "%02d" $day_num).md${NC}"
    echo -e "${BLUE}📍 Location: $til_file${NC}"
}

# 학습 주제 매핑 함수
get_learning_topic() {
    local day=$1
    
    case $day in
        1) echo "Monolithic vs MSA 아키텍처 차이점" ;;
        2) echo "MSA 장단점 및 도입 시점 분석" ;;
        3) echo "Domain Driven Design(DDD) 기초" ;;
        4) echo "서비스 분해 전략 학습" ;;
        5) echo "MSA 필수 기술 스택 조사" ;;
        6) echo "Spring Cloud 생태계 이해" ;;
        7) echo "1주차 학습 내용 정리" ;;
        8) echo "실습 프로젝트 주제 선정" ;;
        9) echo "서비스 분해 설계" ;;
        10) echo "데이터베이스 설계" ;;
        11) echo "기술 스택 최종 결정" ;;
        12) echo "개발 환경 구성" ;;
        13) echo "Git 레포지토리 구성" ;;
        14) echo "2주차 정리 및 다음 주 계획" ;;
        15) echo "User Service 프로젝트 생성" ;;
        16) echo "User 도메인 모델 구현" ;;
        17) echo "User Service 비즈니스 로직 구현" ;;
        18) echo "User REST API 구현" ;;
        19) echo "JWT 인증 구현" ;;
        20) echo "User Service 테스트 작성" ;;
        21) echo "User Service Docker화" ;;
        *) echo "MSA 학습 진행" ;;
    esac
}

# README 업데이트 함수
update_progress_in_readme() {
    local day_num=$1
    local progress=$(calculate_progress $day_num)
    
    # README.md의 진행률 업데이트 (sed 사용)
    if [ -f "$PROJECT_ROOT/README.md" ]; then
        sed -i "s/학습진행률-[0-9]*%2F60일/학습진행률-$progress%2F60일/g" "$PROJECT_ROOT/README.md"
        sed -i "s/\*\*[0-9]* \/ 60일 완료\*\*/\*\*$day_num \/ 60일 완료\*\*/g" "$PROJECT_ROOT/README.md"
        echo -e "${GREEN}📊 Updated progress in README.md: $progress%${NC}"
    fi
}

# 주간 회고 템플릿 생성 함수
create_weekly_summary() {
    local week_num=$1
    local start_day=$(( (week_num - 1) * 7 + 1 ))
    local end_day=$(( week_num * 7 ))
    local current_date=$(date +%Y.%m.%d)
    
    local summary_file="$DAILY_LOGS_DIR/week-$(printf "%02d" $week_num)/weekly-summary.md"
    
    cat > "$summary_file" << EOF
# Week $week_num 학습 회고 (Day $start_day-$end_day)

> **기간**: $current_date 기준  
> **주차**: $week_num/9주차

## 🎯 이번 주 목표
- [ ] 주요 목표 1
- [ ] 주요 목표 2
- [ ] 주요 목표 3

## 📊 학습 성과
| 항목 | 계획 | 실제 | 달성률 |
|------|------|------|--------|
| 학습 시간 | 7시간 | _시간 | _%  |
| 구현 기능 | _개 | _개 | _%  |
| 문서 작성 | _개 | _개 | _%  |

## 💪 잘한 점
- 성과 1
- 성과 2
- 성과 3

## 🔄 개선점
- 부족했던 점
- 다음 주 개선 방향

## 📚 주요 학습 내용
1. **핵심 개념**: 
2. **실습 결과**: 
3. **문제 해결**: 

## 🎯 다음 주 계획
[다음 주 중점 학습 내용]

---
**누적 학습일**: $end_day일 🔥
EOF

    echo -e "${GREEN}📋 Created weekly summary template${NC}"
}

# 통계 출력 함수
show_statistics() {
    local day_num=$1
    local week_num=$2
    local progress=$(calculate_progress $day_num)
    local remaining_days=$((60 - day_num))
    
    echo -e "\n${BLUE}📊 MSA 학습 진행 현황${NC}"
    echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo -e "${GREEN}📅 현재 날짜${NC}: $(date +%Y-%m-%d)"
    echo -e "${GREEN}📈 학습 진행${NC}: Day $day_num/60 ($progress%)"
    echo -e "${GREEN}📋 현재 주차${NC}: Week $week_num/9"
    echo -e "${GREEN}⏰ 남은 날짜${NC}: $remaining_days일"
    echo -e "${GREEN}🔥 연속 학습${NC}: $day_num일"
    echo ""
}

# 메인 함수
main() {
    echo -e "${BLUE}🚀 MSA Learning Journey - TIL 자동화 도구${NC}"
    echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # 현재 날짜 기준 Day 계산
    local day_num=$(calculate_day_number)
    local week_num=$(calculate_week_number $day_num)
    
    # 60일 초과 체크
    if [ $day_num -gt 60 ]; then
        echo -e "${YELLOW}🎉 60일 학습 과정이 완료되었습니다!${NC}"
        echo -e "${GREEN}📚 축하합니다! MSA 마스터가 되셨네요! 🎓${NC}"
        exit 0
    fi
    
    # 디렉토리 생성
    create_directories $week_num
    
    # TIL 템플릿 생성
    create_til_template $day_num $week_num
    
    # 주간 회고 생성 (주차 마지막 날)
    if [ $((day_num % 7)) -eq 0 ]; then
        create_weekly_summary $week_num
    fi
    
    # README 진행률 업데이트
    update_progress_in_readme $day_num
    
    # 통계 출력
    show_statistics $day_num $week_num
    
    echo -e "${GREEN}✅ TIL 템플릿 생성 완료!${NC}"
    echo -e "${YELLOW}💡 이제 학습 내용을 채워넣으세요!${NC}"
    
    # 파일 열기 (선택사항)
    read -p "생성된 TIL 파일을 바로 열까요? (y/n): " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        local til_file="$DAILY_LOGS_DIR/week-$(printf "%02d" $week_num)/day-$(printf "%02d" $day_num).md"
        if command -v code &> /dev/null; then
            code "$til_file"
        elif command -v vim &> /dev/null; then
            vim "$til_file"
        else
            echo -e "${YELLOW}📝 파일 위치: $til_file${NC}"
        fi
    fi
}

# =============================================================================
# 스크립트 실행
# =============================================================================

# 도움말 출력
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    echo "MSA Learning Journey TIL 자동화 도구"
    echo ""
    echo "사용법:"
    echo "  $0                  현재 날짜 기준으로 TIL 템플릿 생성"
    echo "  $0 --help          도움말 출력"
    echo "  $0 --stats         진행 현황만 출력"
    echo ""
    echo "기능:"
    echo "  - 자동으로 Day 번호 계산"
    echo "  - 학습 주제 자동 매핑"
    echo "  - 주차별 디렉토리 생성"
    echo "  - README 진행률 업데이트"
    echo "  - 주간 회고 템플릿 생성"
    exit 0
fi

# 통계만 출력
if [ "$1" = "--stats" ]; then
    local day_num=$(calculate_day_number)
    local week_num=$(calculate_week_number $day_num)
    show_statistics $day_num $week_num
    exit 0
fi

# 메인 실행
main