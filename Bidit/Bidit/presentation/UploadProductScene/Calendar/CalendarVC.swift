//
//  CalendarVC.swift
//  Bidit
//
//  Created by JeongMin Ko on 2022/07/10.
//

import Foundation
import UIKit
import FSCalendar
import RxSwift

class CalendarVC : UIViewController{
    
    let disPoseBag = DisposeBag()
    let calendarContainer = UIView()
    
    let prevBtn = UIButton()
    let nextBtn = UIButton()
    
    var calendar = FSCalendar()
    //확인 버튼
    let checkBtn = UIButton()
    
    
    private var currentPage: Date?
    private lazy var today: Date = {
        return Date()
    }()
    
    
    var dateComponents : DateComponents?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        bind()
        
        self.view.backgroundColor = .systemBackground
        self.dateComponents = DateComponents()
        //월화수목금토일 세팅
        calendar.locale = Locale(identifier: "ko_KR")
        
        // 헤더 폰트 설정
        calendar.appearance.headerTitleFont = UIFont(name: "NotoSansKR-Medium", size: 16)

        // Weekday 폰트 설정
        calendar.appearance.weekdayFont = UIFont(name: "NotoSansKR-Regular", size: 10)

        // 각각의 일(날짜) 폰트 설정 (ex. 1 2 3 4 5 6 ...)
        calendar.appearance.titleFont = UIFont(name: "NotoSansKR-Regular", size: 14)
        
        
        // 헤더의 날짜 포맷 설정
        calendar.appearance.headerDateFormat = "YYYY년 MM월"

        // 헤더의 폰트 색상 설정
        calendar.appearance.headerTitleColor = .black
        
        calendar.appearance.headerTitleFont = .systemFont(ofSize: 16, weight: .bold)

        // 헤더의 폰트 정렬 설정
        // .center & .left & .justified & .natural & .right
        calendar.appearance.headerTitleAlignment = .left
        

        // 헤더 높이 설정
        calendar.headerHeight = 60

        // 헤더 양 옆(전달 & 다음 달) 글씨 투명도
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0   // 0.0 = 안보이게 됩니다.
        
        calendar.calendarHeaderView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(-56)
            $0.top.equalToSuperview().offset(16)
            $0.width.equalTo(280)
            $0.height.equalTo(20)
        }
    }
    
    
    func layout(){
        
        self.view.layer.cornerRadius = 20
        self.view.addSubview(calendarContainer)
        calendarContainer.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.trailing.equalToSuperview().offset(16)
            $0.width.equalTo(view.snp.width)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(288)
        }
        
        calendarContainer.addSubview(calendar)
        calendar.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        calendar.addSubview(prevBtn)
        calendar.addSubview(nextBtn)
        
        prevBtn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        nextBtn.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        prevBtn.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(60)
            $0.top.equalToSuperview().offset(16)
            $0.width.height.equalTo(20)
        }
        nextBtn.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(18)
            $0.top.equalToSuperview().offset(16)
            $0.width.height.equalTo(20)
        }
        
        self.view.addSubview(checkBtn)
        checkBtn.snp.makeConstraints{
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(calendarContainer.snp.bottom).offset(16)
            $0.width.equalTo(340)
            $0.height.equalTo(40)
        }
        checkBtn.setImage(UIImage(named: "calendar_check_btn_img"), for: .normal)
        
        
    }
    
    
    //moveUp이 true라면 다음달, false라면 이전달로 현재 페이지를 옮겨

    private func scrollCurrentPage(isPrev: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = isPrev ? -1 : 1
            
        self.currentPage = cal.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.calendar.setCurrentPage(self.currentPage!, animated: true)
    }
    
    func bind(){
        self.prevBtn.rx.tap
            .subscribe(onNext : {
                self.scrollCurrentPage(isPrev: true)
            }).disposed(by: disPoseBag)
        
        self.nextBtn.rx.tap
            .subscribe(onNext : {
                self.scrollCurrentPage(isPrev: false)
            }).disposed(by: disPoseBag)
    }
   
    
}
