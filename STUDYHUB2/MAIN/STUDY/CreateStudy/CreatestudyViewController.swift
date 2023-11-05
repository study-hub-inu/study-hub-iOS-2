import UIKit

import SnapKit

class CreateStudyViewController: UIViewController {
  
  let tokenManager = TokenManager.shared
  private var selectedDepartments: [String] = [] // 선택된 학과를 저장할 배열
  var genderType: String?
  var contactMethod: String?
  var postDataSender: SendPostData?
  // 선택한 학과를 저장할 프로퍼티
  var selectedDepartment: String? {
    didSet {
      // selectedDepartment가 설정되면 버튼을 생성
      if let department = selectedDepartment {
        addDepartmentButton(department)
      }
    }
  }
  
  // MARK: - UI설정
  private lazy var completeButton: UIButton = {
    let completeButton = UIButton()
    completeButton.setTitle("완료하기", for: .normal)
    completeButton.setTitleColor(.white, for: .normal)
    completeButton.backgroundColor = UIColor(hexCode: "#FF5530")
    completeButton.layer.cornerRadius = 5
    completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
    return completeButton
  }()
  
  private lazy var categoryStackView = createStackView(axis: .vertical,
                                                       spacing: 16)
  private lazy var departmentButtonStackView = createStackView(axis: .vertical,
                                                               spacing: 16)
  // 성별버튼
  private lazy var allGenderButton = createContactButton(title: "무관",
                                                         selector: #selector(genderButtonTapped(_:)))
  
  private lazy var maleOnlyButton = createContactButton(title: "남자만",
                                                        selector:#selector(genderButtonTapped(_:)))
  private lazy var femaleOnlyButton = createContactButton(title: "여자만",
                                                          selector: #selector(genderButtonTapped(_:)))
  // 대면 비대면 버튼
  private lazy var contactButton = createContactButton(title: "대면",
                                                       selector: #selector(meetButtonTapped(_:)))
  
  private lazy var untactButton = createContactButton(title: "비대면",
                                                      selector: #selector(meetButtonTapped(_:)))
  
  private lazy var mixmeetButton = createContactButton(title: "혼합",
                                                       selector: #selector(meetButtonTapped(_:)))
  
  // 벌금버튼
  private lazy var haveFineButton = createFineButton(selector: #selector(haveFineButtonTapped(_:)))
  
  private lazy var noFineButton = createFineButton(selector: #selector(noFineButtonTapped(_:)))
  
  private lazy var fineButtonsStackView = createStackView(axis: .horizontal,
                                                          spacing: 10)
  private lazy var finefixStackView = createStackView(axis: .vertical,
                                                      spacing: 10)
  
  private lazy var periodStackView = createStackView(axis: .vertical,
                                                     spacing: 16)
  
  private lazy var startDateButton = createDateButton(selector: #selector(startDateButtonTapped))
  private lazy var endDateButton = createDateButton(selector: #selector(endDateButtonTapped))
  
  private lazy var chatLinkTextField = createTextField(title: "채팅방 링크를 첨부해 주세요")

  private lazy var studyproduceTextView: UITextView = {
    let tv = UITextView()
    tv.text = "스터디에 대해 알려주세요\n (운영 방법, 대면 여부,벌금,공부 인증 방법 등)"
    tv.textColor = UIColor.lightGray
    tv.font = UIFont.systemFont(ofSize: 15)
    tv.layer.borderWidth = 1.0
    tv.layer.borderColor = UIColor.lightGray.cgColor
    tv.layer.cornerRadius = 5.0
    tv.delegate = self
    tv.adjustUITextViewHeight()
    return tv
  }()

  private lazy var fineAmountTextField = createTextField(title: "금액을 알려주세요")
  
  private lazy var studymemberTextField = createTextField(title: "스터디 인원을 알려주세요")
  private lazy var studytitleTextField = createTextField(title: "제목을 적어주세요")
  
  let startDatePicker = UIDatePicker()
  let startDateTextField = UITextField()
  var selectedStartDate: Date?
  
  let endDatePicker = UIDatePicker()
  let endDateTextField = UITextField()
  var selectedEndDate: Date?
  
  private let headerStackView: UIStackView = {
    let headerStackView = UIStackView()
    headerStackView.axis = .horizontal
    headerStackView.alignment = .center
    headerStackView.spacing = 8
    return headerStackView
  }()
  
  private lazy var backButton: UIButton = {
    let backButton = UIButton(type: .system)
    backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
    backButton.tintColor = .white
    backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    return backButton
  }()
  
  private lazy var createStudyLabel = createLabel(title: "스터디 만들기",
                                                  textColor: .white,
                                                  fontSize: 18)
  
  private lazy var headerContentStackView = createStackView(axis: .vertical,
                                                            spacing: 40)
  
  private lazy var chatLinkStackView = createStackView(axis: .vertical,
                                                       spacing: 16)
  
  private lazy var chatLinkLabel = createLabel(title: "채팅방 링크",
                                               textColor: .black,
                                               fontSize: 18)
  
  
  private lazy var descriptionLabel = createLabel(title: "참여코드가 없는 카카오톡 오픈 채팅방 링크로 첨부",
                                                  textColor: .gray,
                                                  fontSize: 14)
  
  private let chatLinkDividerLine: UIView = {
    let chatLinkDividerLine = UIView()
    chatLinkDividerLine.backgroundColor = UIColor(hexCode: "#F3F5F6")
    return chatLinkDividerLine
  }()
  
  private lazy var studyinfoStackView = createStackView(axis: .vertical,
                                                        spacing: 16)
  
  private lazy var studytitleLabel = createLabel(title: "스터디 제목",
                                                 textColor: .black, fontSize: 18)
  
  private lazy var studyproduceLabel = createLabel(title: "내용",
                                                   textColor: .black, fontSize: 18)
  
  private let studyinfoStackViewDividerLine: UIView = {
    let studyinfoStackViewDividerLine = UIView()
    studyinfoStackViewDividerLine.backgroundColor = UIColor(hexCode: "#F3F5F6")
    return studyinfoStackViewDividerLine
  }()
  
  private lazy var associatedepartLabel = createLabel(title: "관련 학과 선택",
                                                      textColor: .black,
                                                      fontSize: 18)
  
  private lazy var periodLabel = createLabel(title: "기간",
                                             textColor: .black,
                                             fontSize: 18)
  
  private lazy var startLabel = createLabel(title: "시작하는 날",
                                            textColor: .black,
                                            fontSize: 18)
  
  
  private lazy var endLabel = createLabel(title: "종료하는 날",
                                          textColor: .black,
                                          fontSize: 18)
  
  
  private lazy var genderLabel = createLabel(title: "성별",
                                             textColor: .black,
                                             fontSize: 18)
  
  private lazy var studymembercountLabel = createLabel(title: "인원",
                                                       textColor: .black,
                                                       fontSize: 18)
  
  private lazy var studymemberLabel = createLabel(title: "스터디 팀원",
                                                  textColor: .black,
                                                  fontSize: 18)
  
  private lazy var studymethodLabel = createLabel(title: "스터디 방식",
                                                  textColor: .black,
                                                  fontSize: 18)
  
  private lazy var meetLabel = createLabel(title: "대면 여부",
                                           textColor: .black,
                                           fontSize: 18)
  
  private lazy var fineLabel = createLabel(title: "벌금",
                                           textColor: .black,
                                           fontSize: 18)
  
  private lazy var haveFineLabel = createLabel(title: "있어요",
                                               textColor: .black,
                                               fontSize: 16)
  
  private lazy var noFineLabel = createLabel(title: "없어요",
                                             textColor: .black,
                                             fontSize: 16)
  
  private lazy var associatedepartStackView = createStackView(axis: .horizontal,
                                                              spacing: 16)
  
  private lazy var studymemberStackView = createStackView(axis: .vertical,
                                                          spacing: 16)
  
  private lazy var genderButtonsStackView = createStackView(axis: .horizontal,
                                                            spacing: 16)
  
  private lazy var meetButtonsStackView = createStackView(axis: .horizontal,
                                                          spacing: 16)
  
  private lazy var description4Label = createLabel(title: "최대 50명 참여 가능",
                                                   textColor: UIColor(hexCode: "#A1AAB0"),
                                                   fontSize: 12)
  
  private lazy var countLabel = createLabel(title: "명",
                                            textColor: UIColor(hexCode: "#68737D"),
                                            fontSize: 15)
  
  private lazy var description5Label = createLabel(title: "참여자의 성별 선택",
                                                   textColor: UIColor(hexCode: "#A1AAB0"),
                                                   fontSize: 12)
  
  
  private lazy var studymethodStackView = createStackView(axis: .vertical,
                                                          spacing: 16)
  
  
  private lazy var description6Label = createLabel(title: "대면이나 혼합일 경우, 관련 내용에 대한 계획을 소개에 적어주세요",
                                                   textColor: UIColor(hexCode: "#A1AAB0"),
                                                   fontSize: 12)
  
  private lazy var categoryStackViewDividerLine = createDividerLine(height: 10)
  private lazy var grayDividerLine = createDividerLine(height: 2)
  private lazy var studymemberStackViewDividerLine = createDividerLine(height: 10)
  private lazy var grayDividerLine2 = createDividerLine(height: 2)
  private lazy var studymethodStackViewDividerLine = createDividerLine(height: 10)
  private lazy var grayDividerLine3 = createDividerLine(height: 2)
  
  private lazy var associatedepartButton: UIButton = {
    let associatedepartButton = UIButton(type: .system)
    associatedepartButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
    associatedepartButton.tintColor = .black
    associatedepartButton.addTarget(self, action: #selector(departmentArrowButtonTapped), for: .touchUpInside)
    return associatedepartButton
  }()
  
  let scrollView = UIScrollView()
  
  // MARK: - viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    
    setUpLayout()
    makeUI()
  }

  // MARK: - setUpLayout
  func setUpLayout(){
    headerStackView.addArrangedSubview(backButton)
    headerStackView.addArrangedSubview(createStudyLabel)
    
    view.addSubview(headerStackView)
    
    headerContentStackView.addArrangedSubview(chatLinkStackView)
    headerContentStackView.addArrangedSubview(chatLinkDividerLine)
    headerContentStackView.addArrangedSubview(studyinfoStackView)
    
    // 키보드 내리기를 위한 탭 제스처 추가
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
    view.addGestureRecognizer(tapGesture)
    
    chatLinkDividerLine.heightAnchor.constraint(equalToConstant: 10).isActive = true
   
    chatLinkTextField.clearButtonMode = .always
    chatLinkStackView.addArrangedSubview(chatLinkLabel)
    chatLinkStackView.addArrangedSubview(descriptionLabel)
    chatLinkStackView.addArrangedSubview(chatLinkTextField)
    
    studyproduceTextView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    
    studyinfoStackViewDividerLine.heightAnchor.constraint(equalToConstant: 10).isActive = true
    
    studyinfoStackView.addArrangedSubview(studytitleLabel)
    studyinfoStackView.addArrangedSubview(studytitleTextField)
    studyinfoStackView.addArrangedSubview(studyproduceLabel)
    studyinfoStackView.addArrangedSubview(studyproduceTextView)
    
    headerContentStackView.addArrangedSubview(studyinfoStackViewDividerLine)
    headerContentStackView.addArrangedSubview(categoryStackView)
    headerContentStackView.addArrangedSubview(categoryStackViewDividerLine)
    headerContentStackView.addArrangedSubview(studymemberStackView)
    headerContentStackView.addArrangedSubview(studymethodStackViewDividerLine)
    headerContentStackView.addArrangedSubview(studymethodStackView)
    headerContentStackView.addArrangedSubview(studymemberStackViewDividerLine)
    headerContentStackView.addArrangedSubview(periodStackView)
    
    categoryStackView.addArrangedSubview(associatedepartStackView)
    categoryStackView.addArrangedSubview(departmentButtonStackView)

    associatedepartStackView.addArrangedSubview(associatedepartLabel)
    associatedepartStackView.addArrangedSubview(associatedepartButton)
    
    studymemberTextField.addSubview(countLabel)
    
    genderButtonsStackView.distribution = .fillEqually
    genderButtonsStackView.addArrangedSubview(allGenderButton)
    genderButtonsStackView.addArrangedSubview(maleOnlyButton)
    genderButtonsStackView.addArrangedSubview(femaleOnlyButton)
    
    studymemberStackView.addArrangedSubview(studymemberLabel)
    studymemberStackView.addArrangedSubview(grayDividerLine)
    studymemberStackView.addArrangedSubview(studymembercountLabel)
    studymemberStackView.addArrangedSubview(description4Label)
    studymemberStackView.addArrangedSubview(studymemberTextField)
    studymemberStackView.addArrangedSubview(genderLabel)
    studymemberStackView.addArrangedSubview(description5Label)
    studymemberStackView.addArrangedSubview(genderButtonsStackView)

    meetButtonsStackView.distribution = .fillEqually
    meetButtonsStackView.addArrangedSubview(mixmeetButton)
    meetButtonsStackView.addArrangedSubview(contactButton)
    meetButtonsStackView.addArrangedSubview(untactButton)
    
    fineButtonsStackView.addArrangedSubview(haveFineButton)
    fineButtonsStackView.addArrangedSubview(haveFineLabel)
    fineButtonsStackView.addArrangedSubview(noFineButton)
    fineButtonsStackView.addArrangedSubview(noFineLabel)
    
    studymethodStackView.addArrangedSubview(studymethodLabel)
    studymethodStackView.addArrangedSubview(grayDividerLine2)
    studymethodStackView.addArrangedSubview(meetLabel)
    studymethodStackView.addArrangedSubview(description6Label)
    studymethodStackView.addArrangedSubview(meetButtonsStackView)
    studymethodStackView.addArrangedSubview(fineLabel)
    studymethodStackView.addArrangedSubview(fineButtonsStackView)
    studymethodStackView.addArrangedSubview(finefixStackView)
    
    // Add UI elements to the headerContentStackView
    periodStackView.addArrangedSubview(periodLabel)
    periodStackView.addArrangedSubview(grayDividerLine3)
    periodStackView.addArrangedSubview(startLabel)
    periodStackView.addArrangedSubview(startDateButton)
    periodStackView.addArrangedSubview(endLabel)
    periodStackView.addArrangedSubview(endDateButton)
    // Add the completeButton to the periodStackView
    periodStackView.addArrangedSubview(completeButton)
    
    // Constraints for the "완료하기" button
    completeButton.leadingAnchor.constraint(equalTo: periodStackView.leadingAnchor,
                                            constant: 16).isActive = true
    completeButton.trailingAnchor.constraint(equalTo: periodStackView.trailingAnchor,
                                             constant: -16).isActive = true
    completeButton.heightAnchor.constraint(equalToConstant: 57).isActive = true
    
    // Create a scroll view to make the content scrollable
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(headerContentStackView)
    view.addSubview(scrollView)
    
    scrollView.backgroundColor = .white
    
    headerContentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
  }
  // MARK: - makeUI
  func makeUI(){
    headerStackView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.leading.equalTo(view.snp.leading).offset(-60)
      make.trailing.equalTo(view.snp.trailing).offset(-16)
    }
    
    createStudyLabel.snp.makeConstraints { make in
      make.centerX.equalTo(headerStackView.snp.centerX).offset(100)
    }
    headerContentStackView.snp.makeConstraints { make in
      make.top.equalTo(scrollView.snp.top).offset(30)
      make.leading.trailing.bottom.equalTo(scrollView)
      make.width.equalTo(scrollView)
    }
    
    chatLinkLabel.snp.makeConstraints { make in
      make.leading.equalTo(chatLinkStackView).offset(16)
      make.trailing.equalTo(chatLinkStackView).offset(10)
    }
    
    descriptionLabel.snp.makeConstraints { make in
      make.top.equalTo(chatLinkLabel.snp.bottom).offset(10)
      make.leading.equalTo(chatLinkStackView).offset(16)
      make.trailing.equalTo(chatLinkStackView).offset(100)
    }
    
    chatLinkTextField.snp.makeConstraints { make in
      make.leading.equalTo(chatLinkStackView).offset(16)
      make.trailing.equalTo(chatLinkStackView)
      make.width.equalTo(chatLinkStackView).offset(-50)
      make.height.equalTo(50)
    }
    
    studytitleLabel.snp.makeConstraints { make in
      make.top.equalTo(studyinfoStackView.snp.top).offset(-20)
      make.leading.equalTo(studyinfoStackView).offset(16)
      make.trailing.equalTo(studyinfoStackView).offset(5)
    }
    
    studytitleTextField.snp.makeConstraints { make in
      make.leading.equalTo(studyinfoStackView).offset(16)
      make.trailing.equalTo(chatLinkTextField)
      make.height.equalTo(50)
    }
    
    studyproduceLabel.snp.makeConstraints { make in
      make.top.equalTo(studytitleTextField.snp.bottom).offset(20)
      make.leading.equalTo(studyinfoStackView).offset(16)
      make.trailing.equalTo(studyinfoStackView).offset(10)
    }
    
    studyproduceTextView.snp.makeConstraints { make in
      make.leading.equalTo(studyinfoStackView).offset(16)
      make.trailing.equalTo(studyinfoStackView)
      make.width.equalTo(studyinfoStackView).offset(-50)
    }
    // (3) 카테고리 뷰
    associatedepartStackView.snp.makeConstraints { make in
      make.leading.equalTo(categoryStackView).offset(16)
      make.trailing.equalTo(categoryStackView)
    }
    
    associatedepartButton.snp.makeConstraints { make in
      make.leading.equalTo(studyproduceTextView.snp.trailing).offset(-20)
      make.trailing.equalTo(studyproduceTextView.snp.trailing)
    }
    
    // (4) 스터디멤버 뷰
    studymemberLabel.snp.makeConstraints { make in
      make.top.equalTo(studymemberStackView).offset(-20)
      make.leading.equalTo(studymemberStackView).offset(16)
      make.trailing.equalTo(studymemberStackView).offset(5)
    }
    
    grayDividerLine.snp.makeConstraints { make in
      make.leading.equalTo(studymemberStackView).offset(0)
      make.trailing.equalTo(studymemberStackView).offset(10)
    }
    
    studymembercountLabel.snp.makeConstraints { make in
      make.leading.equalTo(studymemberStackView).offset(16)
      make.trailing.equalTo(studymemberStackView).offset(5)
    }
    
    description4Label.snp.makeConstraints { make in
      make.top.equalTo(studymembercountLabel.snp.bottom).offset(10)
      make.leading.equalTo(studymemberStackView).offset(16)
      make.trailing.equalTo(studymemberStackView).offset(100)
    }
    
    studymemberTextField.snp.makeConstraints { make in
      make.leading.equalTo(studymemberStackView).offset(16)
      make.trailing.equalTo(studymemberStackView)
      make.width.equalTo(studymemberStackView).offset(-50)
      make.height.equalTo(50)
    }
    
    countLabel.snp.makeConstraints { make in
      make.centerY.equalTo(studymemberTextField)
      make.trailing.equalTo(studymemberTextField).offset(-8)
      make.width.equalTo(20)
      make.height.equalTo(20)
    }
    
    genderLabel.snp.makeConstraints { make in
      make.leading.equalTo(studymemberStackView.snp.leading).offset(16)
      make.trailing.equalTo(studymemberStackView.snp.trailing).offset(10)
    }
    
    description5Label.snp.makeConstraints { make in
      make.top.equalTo(genderLabel.snp.bottom).offset(10)
      make.leading.equalTo(studymemberStackView.snp.leading).offset(16)
      make.trailing.equalTo(studymemberStackView.snp.trailing).offset(10)
    }
    
    genderButtonsStackView.snp.makeConstraints { make in
      make.trailing.equalTo(studymemberStackView.snp.trailing).offset(-100)
      make.top.equalTo(description5Label.snp.bottom).offset(8)
      make.height.equalTo(30)
    }
    
    studymethodLabel.snp.makeConstraints { make in
      make.top.equalTo(studymethodStackView.snp.top).offset(-20)
      make.leading.equalTo(studymethodStackView).offset(16)
      make.trailing.equalTo(studymethodStackView).offset(5)
    }
    meetLabel.snp.makeConstraints { make in
      make.leading.equalTo(studymethodStackView).offset(16)
      make.trailing.equalTo(studymethodStackView).offset(5)
    }
    
    description6Label.snp.makeConstraints { make in
      make.top.equalTo(meetLabel.snp.bottom).offset(10)
      make.leading.equalTo(studymethodStackView).offset(16)
      make.trailing.equalTo(studymethodStackView).offset(100)
    }
    
    meetButtonsStackView.snp.makeConstraints { make in
      make.trailing.equalTo(studymethodStackView).offset(-150)
    }
    
    fineLabel.snp.makeConstraints { make in
      make.leading.equalTo(studymethodStackView).offset(16)
      make.trailing.equalTo(studymethodStackView).offset(100)
    }
    
    fineButtonsStackView.snp.makeConstraints { make in
      make.leading.equalTo(studymethodStackView).offset(16)
      make.trailing.equalTo(studymethodStackView).offset(50)
    }
    
    grayDividerLine2.snp.makeConstraints { make in
      make.leading.equalTo(studymethodStackView)
      make.trailing.equalTo(studymethodStackView).offset(10)
    }
    // 스터디기간 뷰
    periodLabel.snp.makeConstraints { make in
      make.top.equalTo(periodStackView.snp.top).offset(-20)
      make.leading.equalTo(periodStackView).offset(16)
      make.trailing.equalTo(periodStackView).offset(5)
    }
    
    grayDividerLine3.snp.makeConstraints { make in
      make.leading.equalTo(periodStackView)
      make.trailing.equalTo(periodStackView).offset(10)
    }
    
    startLabel.snp.makeConstraints { make in
      make.leading.equalTo(periodStackView).offset(16)
      make.trailing.equalTo(periodStackView).offset(10)
    }
    startDateButton.snp.makeConstraints { make in
      make.leading.equalTo(periodStackView).offset(16)
      make.trailing.equalTo(periodStackView).offset(-16)
      make.height.equalTo(50)
    }
    
    endLabel.snp.makeConstraints { make in
      make.leading.equalTo(periodStackView).offset(16)
      make.trailing.equalTo(periodStackView).offset(10)
    }
    
    endDateButton.snp.makeConstraints { make in
      make.leading.equalTo(periodStackView).offset(16)
      make.trailing.equalTo(periodStackView).offset(-16)
      make.height.equalTo(50)
    }
    
    endDateButton.snp.makeConstraints { make in
      make.bottom.equalTo(completeButton.snp.top).offset(-40)
    }
    
    scrollView.snp.makeConstraints { make in
      make.top.equalTo(headerStackView.snp.bottom).offset(16)
      make.leading.equalTo(view)
      make.trailing.equalTo(view)
      make.bottom.equalTo(view)
    }
  }
  
  // 선택한 학과에 대한 버튼을 생성하고 departmentButtonStackView에 추가하는 함수
  func addDepartmentButton(_ department: String) {
      // Department 버튼과 삭제 버튼을 수평으로 나열하는 스택 뷰 생성
      lazy var buttonStackView: UIStackView = createStackView(axis: .horizontal, spacing: 0)
      buttonStackView.distribution = .fill // 뷰들이 스택 뷰의 전체 너비를 채우도록 설정
      buttonStackView.alignment = .center // 수직 방향 가운데 정렬

      departmentButtonStackView.addArrangedSubview(buttonStackView)

      // Department 버튼 생성
      let departmentButton = UIButton(type: .system)
      departmentButton.backgroundColor = UIColor(hexCode: "F3F5F6")
      departmentButton.setTitleColor(UIColor(hexCode: "68737D"), for: .normal)
      departmentButton.setTitle(department, for: .normal)
      departmentButton.layer.cornerRadius = 20
      departmentButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
      departmentButton.contentHorizontalAlignment = .center // 텍스트 정렬
    

      // 삭제 버튼 생성
      let deleteButton = UIButton(type: .system)
      deleteButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
      deleteButton.tintColor = .lightGray

      // 문자열 길이에 따라 버튼 가로 길이 동적 조절
      let buttonWidth = department.width(withConstrainedHeight: 30, font: departmentButton.titleLabel!.font)
      departmentButton.widthAnchor.constraint(equalToConstant: buttonWidth + 50).isActive = true

      buttonStackView.addArrangedSubview(departmentButton)
      buttonStackView.addArrangedSubview(deleteButton)
  }

  
  // 키보드 내리기 위한 탭 제스처 핸들러
  @objc func handleTap() {
    // 키보드를 내립니다.
    view.endEditing(true)
  }
  
  // MARK: - 벌금 있을 때 함수
  @objc func haveFineButtonTapped(_ sender: UIButton) {
    sender.isSelected = !sender.isSelected
    noFineButton.isSelected = !sender.isSelected
    
    if sender.isSelected {
      // Create a label for "어떤 벌금인가요?"
      let fineTypeLabel = createLabel(title:"어떤 벌금인가요?",
                                      textColor: UIColor(hexCode: "#49545C"),
                                      fontSize: 14)
      
      // Create a text field for chat link input
      let fineTypesTextField = createTextField(title: "지각비, 결석비 등")
  
      // Create a text field for "얼마인가요?"
      let fineAmountLabel = createLabel(title: "얼마인가요?",
                                        textColor: UIColor(hexCode: "#49545C"),
                                        fontSize: 14)
      // Create a label for
      let countLabel2 = createLabel(title: "원",
                                    textColor: UIColor(hexCode: "#68737D"),
                                    fontSize: 15)
      
      lazy var maxFineLabel = createLabel(title: "최대 99,999원",
                                          textColor: UIColor(hexCode: "#A1AAB0"),
                                          fontSize: 12)
      
      fineAmountTextField.addSubview(countLabel2)
      
      finefixStackView.addArrangedSubview(fineTypeLabel)
      finefixStackView.addArrangedSubview(fineTypesTextField)
      finefixStackView.addArrangedSubview(fineAmountLabel)
      finefixStackView.addArrangedSubview(fineAmountTextField)
      finefixStackView.addArrangedSubview(maxFineLabel)
      
      // Constraints for chatLinkTextField
      fineTypesTextField.snp.makeConstraints { make in
        make.leading.equalTo(fineButtonsStackView)
        make.trailing.equalTo(fineButtonsStackView)
        make.width.equalTo(fineButtonsStackView).offset(-30)
      }
      
      fineAmountTextField.snp.makeConstraints { make in
        make.leading.equalTo(fineButtonsStackView)
        make.trailing.equalTo(fineButtonsStackView)
        make.width.equalTo(fineButtonsStackView).offset(-30)
      }
      
      countLabel2.snp.makeConstraints { make in
        make.centerY.equalTo(fineAmountTextField)
        make.trailing.equalTo(fineAmountTextField).offset(-8)
        make.width.equalTo(20)
        make.height.equalTo(20)
      }
      
      maxFineLabel.snp.makeConstraints { make in
        make.top.equalTo(fineAmountTextField.snp.bottom).offset(10)
      }
      
    } 
  }
  
  // MARK: - 완료버튼 누를 때 함수
  @objc func completeButtonTapped() {
    // 성별, 스터디방식 버튼에 따라서 내용이 안바뀜
    let studyData = CreateStudyRequest(
      chatUrl: chatLinkTextField.text ?? "",
      close: false,
      content: studyproduceTextView.text ?? "",
      gender: genderType ?? "null",
      major: "COMPUTER_SCIENCE_ENGINEERING",
      penalty: Int(fineAmountTextField.text ?? "0") ?? 0 ,
      studyEndDate: (endDateTextField.text ?? "").dateConvert(),
      studyPerson: Int(studymemberTextField.text ?? "") ?? 0,
      studyStartDate: (startDateTextField.text ?? "").dateConvert(),
      studyWay: contactMethod ?? "CONTACT",
      title: studytitleTextField.text ?? "")
    
    print(studyData)
    
    PostManager.shared.fetchUser(postData: studyData) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let userData):
        self.postDataSender?.sendData(data: userData)
        print(userData)
      case .failure(let error):
        print("Error: \(error)")
      }
    }
  }


  // MARK: - 벌금 없을 때 함수
  @objc func noFineButtonTapped(_ sender: UIButton) {
    sender.isSelected = !sender.isSelected
    haveFineButton.isSelected = !sender.isSelected
    
    // Remove the labels and text fields from the finefixStackView
    finefixStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
  }
  
  @objc func departmentArrowButtonTapped() {
    let departmentselectViewController = DepartmentselectViewController()
    let navigationController = UINavigationController(rootViewController: departmentselectViewController)
    navigationController.modalPresentationStyle = .fullScreen
    present(navigationController, animated: true, completion: nil)
  }

  // MARK: - 성별 눌렸을 때 함수
  @objc func genderButtonTapped(_ sender: UIButton) {
    // Reset colors of all buttons
    allGenderButton.backgroundColor = .white
    allGenderButton.setTitleColor(.gray, for: .normal)
    
    maleOnlyButton.backgroundColor = .white
    maleOnlyButton.setTitleColor(.gray, for: .normal)
    
    femaleOnlyButton.backgroundColor = .white
    femaleOnlyButton.setTitleColor(.gray, for: .normal)
    
    // Set the tapped button to orange background
    sender.layer.borderColor = UIColor(hexCode: "#FF5530").cgColor
    sender.setTitleColor(UIColor(hexCode: "#FF5530"), for: .normal)
    
    guard let gender = sender.titleLabel?.text else { return }
    genderType = gender
    // MALE FEMALE null
    if genderType == "남자만" {
      genderType = "MALE"
    }
    else if genderType == "여자만" {
      genderType = "FEMALE"
    }
    else {
      genderType = "null"
    }
  }
  
  // MARK: - 스터디 방식 눌렸을 때 함수
  @objc func meetButtonTapped(_ sender: UIButton) {
    // Reset colors of all buttons
    contactButton.backgroundColor = .white
    contactButton.setTitleColor(.gray, for: .normal)
    
    untactButton.backgroundColor = .white
    untactButton.setTitleColor(.gray, for: .normal)
    
    mixmeetButton.backgroundColor = .white
    mixmeetButton.setTitleColor(.gray, for: .normal)
    
    // Set the tapped button to orange background
    sender.layer.borderColor = UIColor(hexCode: "#FF5530").cgColor
    sender.setTitleColor(UIColor(hexCode: "#FF5530"), for: .normal)
    // CONTACT UNCONTACT MIX
    guard let contact = sender.titleLabel?.text else{ return }
    contactMethod = contact
    if contactMethod == "대면" {
      contactMethod = "CONTACT"
    }
    else if contactMethod == "비대면" {
      contactMethod = "UNCONTACT"
    }
    else {
      contactMethod = "MIX"
    }
  }
  
  // MARK: - date 선택
  @objc func startDateButtonTapped() {
    // Create a date picker
    startDatePicker.datePickerMode = .date
    startDatePicker.preferredDatePickerStyle = .inline // You can choose the style you prefer
    startDatePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
    
    // Create an input view for the date picker
    startDateTextField.inputView = startDatePicker
    
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissDatePicker))
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    toolbar.setItems([flexibleSpace, doneButton], animated: false)
    startDateTextField.inputAccessoryView = toolbar
    
    // Add the text field to the view
    view.addSubview(startDateTextField)
    
    // Set up constraints for the text field (adjust as needed)
    startDateTextField.translatesAutoresizingMaskIntoConstraints = false
    startDateTextField.topAnchor.constraint(equalTo: startDateButton.bottomAnchor, constant: -35).isActive = true
    startDateTextField.leadingAnchor.constraint(equalTo: periodStackView.leadingAnchor, constant: 40).isActive = true
    startDateTextField.trailingAnchor.constraint(equalTo: periodStackView.trailingAnchor, constant: -16).isActive = true
    
    // Show the date picker
    startDateTextField.becomeFirstResponder()
  }
  
  @objc func datePickerValueChanged() {
    // Update the selectedStartDate when the date picker's value changes
    selectedStartDate = startDatePicker.date
    updateStartDateTextField() // Update the text field to display the selected date
  }
  
  @objc func dismissDatePicker() {
    // Dismiss the date picker when the Done button is tapped
    startDateTextField.resignFirstResponder()
  }
  
  func updateStartDateTextField() {
    // Update the text field with the selected date
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy년 MM월 dd일" // You can choose the date format you prefer
    startDateTextField.textColor = .black
    startDateTextField.text = dateFormatter.string(from: selectedStartDate ?? Date())
    
    // Hide the "선택하기" title of startDateButton
    startDateButton.setTitle("", for: .normal)
  }
  
  @objc func endDateButtonTapped() {
    // Create a date picker
    endDatePicker.datePickerMode = .date
    endDatePicker.preferredDatePickerStyle = .inline // You can choose the style you prefer
    endDatePicker.addTarget(self, action: #selector(endDatePickerValueChanged), for: .valueChanged)
    
    endDateTextField.textColor = .black
    endDateTextField.inputView = endDatePicker
    
    // Set titleTextField's inputAccessoryView to a toolbar with a done button
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissEndDatePicker))
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    toolbar.setItems([flexibleSpace, doneButton], animated: false)
    endDateTextField.inputAccessoryView = toolbar
    
    // Assign the toolbar as the input accessory view for the date picker
    endDateTextField.inputAccessoryView = toolbar
    
    // Add the text field to the view
    view.addSubview(endDateTextField)
    
    // Set up constraints for the text field (adjust as needed)
    endDateTextField.translatesAutoresizingMaskIntoConstraints = false
    endDateTextField.topAnchor.constraint(equalTo: endDateButton.bottomAnchor, constant: -35).isActive = true
    endDateTextField.leadingAnchor.constraint(equalTo: periodStackView.leadingAnchor, constant: 40).isActive = true
    endDateTextField.trailingAnchor.constraint(equalTo: periodStackView.trailingAnchor, constant: -16).isActive = true
    
    // Show the date picker
    endDateTextField.becomeFirstResponder()
  }
  
  @objc func endDatePickerValueChanged() {
    // Update the selectedEndDate when the date picker's value changes
    selectedEndDate = endDatePicker.date
    updateEndDateTextField() // Update the text field to display the selected date
  }
  
  @objc func dismissEndDatePicker() {
    // Dismiss the date picker when the Done button is tapped
    endDateTextField.resignFirstResponder()
  }
  
  func updateEndDateTextField() {
    // Update the text field with the selected date
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy년 MM월 dd일" // You can choose the date format you prefer
    endDateTextField.text = dateFormatter.string(from: selectedEndDate ?? Date())
    // Hide the "선택하기" title of endDateButton
    endDateButton.setTitle("", for: .normal)
  }
  
  // Function to handle back button tap and navigate back to HomeViewController
  @objc func goBack() {
    
    self.dismiss(animated: true, completion: nil)
  }
  
}

protocol SendPostData {
  func sendData(data: CreateStudyRequest)
}
