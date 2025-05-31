# =============================================================================
# scripts/progress-tracker.sh - 학습 진행률 추적
# =============================================================================

#!/bin/bash

track_progress() {
    echo "📊 MSA Learning Journey 진행률 리포트"
    echo "====================================="
    
    local total_days=60
    local completed_days=0
    local current_week=1
    
    # 완료된 TIL 파일 개수 계산
    for week in {01..09}; do
        local week_dir="docs/daily-logs/week-$week"
        if [ -d "$week_dir" ]; then
            local week_files=$(find "$week_dir" -name "day-*.md" | wc -l)
            completed_days=$((completed_days + week_files))
            
            if [ $week_files -gt 0 ]; then
                current_week=$((10#$week))
            fi
        fi
    done
    
    local progress_percent=$((completed_days * 100 / total_days))
    local remaining_days=$((total_days - completed_days))
    
    echo "📈 전체 진행률: $completed_days/$total_days일 ($progress_percent%)"
    echo "📅 현재 주차: Week $current_week/9"
    echo "⏰ 남은 학습일: $remaining_days일"
    echo ""
    
    # 주차별 진행률 표시
    echo "📋 주차별 진행률:"
    for week in {1..9}; do
        local week_dir="docs/daily-logs/week-$(printf "%02d" $week)"
        local week_files=0
        
        if [ -d "$week_dir" ]; then
            week_files=$(find "$week_dir" -name "day-*.md" | wc -l)
        fi
        
        local week_progress=$((week_files * 100 / 7))
        printf "  Week %d: %d/7일 (%d%%) " $week $week_files $week_progress
        
        # 진행률 바 표시
        local filled=$((week_progress / 10))
        printf "["
        for i in {1..10}; do
            if [ $i -le $filled ]; then
                printf "■"
            else
                printf "□"
            fi
        done
        printf "]\n"
    done
    
    echo ""
    echo "🎯 목표까지: $(( (total_days - completed_days) ))일 남음"
    
    if [ $completed_days -ge $total_days ]; then
        echo "🎉 축하합니다! MSA 학습 과정을 완주하셨습니다! 🎓"
    fi
}