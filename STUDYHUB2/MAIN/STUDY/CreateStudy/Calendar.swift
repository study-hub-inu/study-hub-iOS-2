import UIKit

import FSCalendar
import SnapKit

class CalendarViewController: UIViewController {
  // delegate로 전달해보자
  private var previousVC = CreateStudyViewController()
  private var calendar: FSCalendar?
  var selectDate: String?
  let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy년 MM월" // 원하는 날짜 형식으로 설정
    return formatter
  }()
  
  var delegate: ChangeDateProtocol?
  var buttonSelect: Bool?
  private lazy var titleLabel = createLabel(title: dateFormatter.string(from: calendar!.currentPage),
                                            textColor: .black,
                                            fontSize: 18)
  
  private lazy var previousButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysTemplate),
                    for: .normal)
    button.tintColor = .black
    button.addTarget(self, action: #selector(self.prevCurrentPage), for: .touchUpInside)
    return button
  }()
  
  // 다음 주 이동 버튼
  private lazy var nextButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate),
                    for: .normal)
    button.tintColor = .black
    button.addTarget(self, action: #selector(self.nextCurrentPage), for: .touchUpInside)
    return button
  }()
  
  private lazy var completeButton: UIButton = {
    let button = UIButton()
    button.setTitle("완료", for: .normal)
    button.setTitleColor(.o50, for: .normal)  // 텍스트 색상을 변경합니다.
    button.addTarget(self, action: #selector(self.completeButtonTapped), for: .touchUpInside)
    return button
  }()
  
  private let today: Date = {
    return Date()
  }()
  
  private var currentPage: Date?
  
  var selectedDate: Date = Date()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // FSCalendar를 생성하고 초기화합니다.
    calendar = FSCalendar(frame: .zero)
    
    // 옵셔널 체이닝을 사용하여 `calendar`에 접근하고 뷰에 추가합니다.
    if let cal = calendar {
      view.addSubview(cal)
      cal.snp.makeConstraints { make in
        make.top.equalTo(view.snp.top).offset(100)
        make.leading.trailing.bottom.equalTo(view)
      }
    }
    
    view.addSubview(titleLabel)
    // titleLabel 제약 설정
    titleLabel.snp.makeConstraints { make in
      make.leading.equalTo(calendar!).offset(50)
      make.top.equalTo(calendar!).offset(-60)
    }
    view.addSubview(previousButton)
    // previousButton 제약 설정
    previousButton.snp.makeConstraints { make in
      make.centerY.equalTo(titleLabel)
      make.trailing.equalTo(titleLabel.snp.leading).offset(-20)
    }
    view.addSubview(nextButton)
    // nextButton 제약 설정
    nextButton.snp.makeConstraints { make in
      make.centerY.equalTo(titleLabel)
      make.leading.equalTo(titleLabel.snp.trailing).offset(20)
    }
    
    view.addSubview(completeButton)
    completeButton.snp.makeConstraints { make in
      make.centerY.equalTo(titleLabel)
      make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
    }
    
    calendar?.allowsMultipleSelection = false
    
    setupCalendarUI()
    
    view.backgroundColor = .white
  }
  
  func setupCalendarUI(){
    calendar?.delegate = self
    calendar?.dataSource = self
    // 상단 요일을 한글로 변경
    self.calendar?.calendarWeekdayView.weekdayLabels[0].text = "일"
    self.calendar?.calendarWeekdayView.weekdayLabels[1].text = "월"
    self.calendar?.calendarWeekdayView.weekdayLabels[2].text = "화"
    self.calendar?.calendarWeekdayView.weekdayLabels[3].text = "수"
    self.calendar?.calendarWeekdayView.weekdayLabels[4].text = "목"
    self.calendar?.calendarWeekdayView.weekdayLabels[5].text = "금"
    self.calendar?.calendarWeekdayView.weekdayLabels[6].text = "토"
    
    calendar?.headerHeight = 0
    calendar?.appearance.titleTodayColor = .o50 //Today에 표시되는 특정 글자색
    calendar?.appearance.todayColor = .o10 //Today에 표시되는 선택 전 동그라미 색
    calendar?.appearance.todaySelectionColor = .white  //Today에 표시되는 선택 후 동그라미 색
    // 숫자들 글자 폰트 및 사이즈 지정
    calendar?.appearance.titleFont = UIFont.systemFont(ofSize: 18)
    
    self.calendar?.appearance.weekdayTextColor = UIColor.bg80
    
    // 양옆 년도, 월 지우기
    calendar?.appearance.headerMinimumDissolvedAlpha = 0.0
    // 달에 유효하지 않은 날짜의 색 지정
    self.calendar?.appearance.titlePlaceholderColor = UIColor.white.withAlphaComponent(0.2)
    // 평일 날짜 색
    self.calendar?.appearance.titleDefaultColor = UIColor.black.withAlphaComponent(0.8)
  }
  
  // 날짜 선택 시 콜백 메소드
  public func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-dd"
    selectDate = dateFormatter.string(from: date)
    calendar.appearance.selectionColor = .o50
    calendar.appearance.titleTodayColor = .black
    calendar.appearance.todayColor = .white
  }
  
  @objc private func nextCurrentPage(_ sender: UIButton) {
    let cal = Calendar.current
    var dateComponents = DateComponents()
    dateComponents.weekOfMonth = 1
    
    self.currentPage = cal.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
    self.calendar?.setCurrentPage(self.currentPage!, animated: true)
  }
  
  @objc private func prevCurrentPage(_ sender: UIButton) {
    let cal = Calendar.current
    var dateComponents = DateComponents()
    dateComponents.weekOfMonth = -1
    
    self.currentPage = cal.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
    self.calendar?.setCurrentPage(self.currentPage!, animated: true)
  }
  
  @objc private func completeButtonTapped(_ sender: UIButton) {
    if selectedDate == nil {
      selectedDate = self.today
    }
    guard let data = selectDate else { return }
    if buttonSelect == true {
      delegate?.dataSend(data: data, buttonTag: 1)

    } else {
      delegate?.dataSend(data: data, buttonTag: 2)
    }
    
    self.dismiss(animated: true, completion: nil)
    
  }
}

extension Date {
  static func today() -> Date {
    return Date()
  }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
  func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
    self.titleLabel.text = self.dateFormatter.string(from: calendar.currentPage)
  }
}

protocol ChangeDateProtocol {
  func dataSend(data: String, buttonTag: Int)
}


