# =============================================================================
# scripts/commit-helper.sh - 커밋 도우미 스크립트
# =============================================================================

#!/bin/bash

commit_helper() {
    echo "🤖 MSA Learning Journey 커밋 도우미"
    echo "=================================="
    
    # 변경된 파일 확인
    local changed_files=$(git diff --name-only)
    
    if [ -z "$changed_files" ]; then
        echo "❌ 커밋할 변경사항이 없습니다."
        exit 1
    fi
    
    echo "📁 변경된 파일들:"
    echo "$changed_files"
    echo ""
    
    # 커밋 타입 선택
    echo "📝 커밋 타입을 선택하세요:"
    echo "1) feat     - 새로운 기능 추가"
    echo "2) fix      - 버그 수정"
    echo "3) docs     - 문서 수정/추가"
    echo "4) style    - 코드 포맷팅"
    echo "5) refactor - 코드 리팩토링"
    echo "6) test     - 테스트 코드"
    echo "7) chore    - 빌드, 설정 수정"
    
    read -p "선택 (1-7): " type_choice
    
    case $type_choice in
        1) commit_type="feat" ;;
        2) commit_type="fix" ;;
        3) commit_type="docs" ;;
        4) commit_type="style" ;;
        5) commit_type="refactor" ;;
        6) commit_type="test" ;;
        7) commit_type="chore" ;;
        *) echo "❌ 잘못된 선택입니다."; exit 1 ;;
    esac
    
    # 스코프 선택 (선택사항)
    echo ""
    echo "🎯 스코프를 입력하세요 (선택사항, 예: user-service, til, gateway):"
    read -p "스코프: " scope
    
    # 커밋 메시지 입력
    echo ""
    read -p "📝 커밋 메시지를 입력하세요: " message
    
    # 커밋 메시지 구성
    if [ -n "$scope" ]; then
        full_message="$commit_type($scope): $message"
    else
        full_message="$commit_type: $message"
    fi
    
    echo ""
    echo "🔍 커밋 미리보기:"
    echo "  $full_message"
    echo ""
    
    read -p "커밋하시겠습니까? (y/n): " -n 1 -r
    echo ""
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git add .
        git commit -m "$full_message"
        echo "✅ 커밋 완료!"
        
        read -p "푸시하시겠습니까? (y/n): " -n 1 -r
        echo ""
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            git push
            echo "🚀 푸시 완료!"
        fi
    else
        echo "❌ 커밋이 취소되었습니다."
    fi
}