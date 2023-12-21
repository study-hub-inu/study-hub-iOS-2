
import UIKit

import SnapKit

// 토스트팝업 추가하기
final class DepartmentselectViewController: NaviHelper {
  var previousVC: CreateStudyViewController?
  
  private lazy var majorSet = ["공연예술과", "IBE전공", "건설환경공학", "건축공학",
                               "경영학부", "경제학과", "국어교육과", "국어국문학과",
                               "기계공학과","데이터과학과","도시건축학","도시공학과",
                               "도시행정학과","독어독문학과","동북아통상전공","디자인학부",
                               "무역학부","문헌정보학과","물리학과","미디어커뮤니케이션학과",
                               "바이오-로봇 시스템 공학과","법학부", "불어불문학과","사회복지학과",
                               "산업경영공학과","생명공학부(나노바이오공학전공)","생명공학부(생명공학전공)",
                               "생명과학부(분자의생명전공)","생명과학부(생명과학전공)","서양화전공(조형예술학부)",
                               "세무회계학과","소비자학과","수학과","수학교육과", "스마트물류공학전공", "스포츠과학부",
                               "신소재공학과","안전공학과","에너지화학공학","역사교육과","영어교육과","영어영문학과",
                               "운동건강학부","유아교육과","윤리교육과","일본지역문화학과","일어교육과","임베디드시스템공과",
                               "전기공학과","전자공학과","정보통신학과","정치외교학과","중어중국학과","창의인개발학과",
                               "체육교육과","컴퓨터공학부","테크노경영학과","패션산업학과","한국화전공(조형예술학부)",
                               "해양학과","행정학과","화학과","환경공학" ]
  
  var resultDepartments: [String] = []
  var selectedMajor: String?
  
  private let searchController = UISearchBar.createSearchBar()
  
  private lazy var resultTableView: UITableView = {
    let tableView = UITableView()
    tableView.register(CustomCell.self,
                       forCellReuseIdentifier: CustomCell.cellId)
    tableView.backgroundColor = .white
    tableView.separatorInset.left = 0
    tableView.layer.cornerRadius = 10
    return tableView
  }()
  
  private lazy var describeLabel = createLabel(
    title: "- 관련학과는 1개만 선택할 수 있어요 \n- 다양한 학과와 관련된 스터디라면, '공통'을 선택해 주세요",
    textColor: .bg60,
    fontType: "Pretendard",
    fontSize: 12)

  private lazy var selectMajorLabel: BasePaddingLabel = {
    let label = BasePaddingLabel(padding: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
    label.textColor = .bg80
    label.font = UIFont.systemFont(ofSize: 14)
    return label
  }()
  
  private lazy var cancelButton: UIButton = {
    let button = UIButton()
    let img = UIImage(named: "DeleteImg")
    button.setImage(img, for: .normal)
    button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    return button
  }()
  
  
  // MARK: - viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    navigationItemSetting()
    redesignNavigationbar()
    
    setupLayout()
    makeUI()
  }
  // MARK: - setupLayout
  func setupLayout(){
    [
      searchController,
      describeLabel
    ].forEach {
      view.addSubview($0)
    }
  }
  // MARK: - makeUI
  func makeUI() {
    searchController.delegate = self
    
    resultTableView.delegate = self
    resultTableView.dataSource = self
    
    searchController.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().offset(10)
      make.width.equalToSuperview().multipliedBy(0.95)
    }
    
    describeLabel.numberOfLines = 2
    describeLabel.snp.makeConstraints { make in
      make.top.equalTo(searchController.snp.bottom).offset(10)
      make.leading.equalTo(searchController.snp.leading)
    }
  }
  
  // MARK: - 네비게이션바 재설정
  func redesignNavigationbar(){
    let rightButtonImg = UIImage(named: "DeCompletedImg.png")?.withRenderingMode(.alwaysOriginal)
    let rightButton = UIBarButtonItem(image: rightButtonImg,
                                      style: .plain,
                                      target: self,
                                      action: #selector(redesingRightButtonTapped))
    self.navigationItem.rightBarButtonItem = rightButton
    
    self.navigationItem.title = "관련학과"
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
  }
  
  @objc func redesingRightButtonTapped(){
    guard let major = selectedMajor else { return }

    previousVC?.addDepartmentButton(major)
    self.navigationController?.popViewController(animated: true)

  }
  
  @objc func cancelButtonTapped(){
    describeLabel.isHidden = false
    selectMajorLabel.isHidden = true
    cancelButton.isHidden = true
    resultTableView.isHidden = true
    
    selectedMajor = nil
  }
}


extension DepartmentselectViewController: UISearchBarDelegate {
  // 검색(Search) 버튼을 눌렀을 때 호출되는 메서드
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let keyword = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
    
    let matchingDepartments = majorSet.filter { $0.contains(keyword) }
    
    if matchingDepartments.isEmpty {
      print("검색 결과가 없음")
      // 검색 결과가 없을 때의 처리를 할 수 있습니다.
    } else {
      print("검색 결과: \(matchingDepartments)")
      searchTapped(department: matchingDepartments)
    }
    
    reloadTalbeView()
  }
  
  func searchTapped(department: [String]){
    describeLabel.isHidden = true
    selectMajorLabel.isHidden = true
    cancelButton.isHidden = true
    resultTableView.isHidden = false
    
    view.setNeedsLayout()
    view.layoutIfNeeded()
    
    view.addSubview(resultTableView)
    resultTableView.snp.makeConstraints { make in
      make.top.equalTo(describeLabel.snp.bottom).offset(-30)
      make.leading.trailing.equalTo(searchController)
      make.bottom.equalTo(view).offset(-10)
    }
    resultDepartments = department
  }
}


// MARK: - cell 함수
extension DepartmentselectViewController: UITableViewDelegate, UITableViewDataSource {
  // UITableViewDataSource 함수
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return resultDepartments.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = resultTableView.dequeueReusableCell(withIdentifier: CustomCell.cellId,
                                                   for: indexPath) as! CustomCell
    
    cell.backgroundColor = .bg20
    
    if indexPath.row < resultDepartments.count {
      let department = resultDepartments[indexPath.row]
      cell.name.text = department
    }
    
    return cell
  }
  
  // UITableViewDelegate 함수 (선택)
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // resultDepartments가 nil이 아닌 경우에만 실행
    
    if indexPath.row < resultDepartments.count {
      let selectedMajor = resultDepartments[indexPath.row]
      cellTapped(selectedCell: selectedMajor)
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 70
  }
  
  func reloadTalbeView(){
    resultTableView.reloadData()
  }
  
  // cell이 선택되었을 때 ui변경
  func cellTapped(selectedCell: String){
    let labelText = selectedCell
    let labelSize = (labelText as NSString).size(withAttributes: [NSAttributedString.Key.font: selectMajorLabel.font!])
    
    if selectMajorLabel.text != nil {
      showToast(message: "관련학과는 1개만 선택이 가능해요", alertCheck: false)
    }
    
    selectMajorLabel.text = selectedCell
    selectMajorLabel.clipsToBounds = true
    selectMajorLabel.layer.cornerRadius = 15
    selectMajorLabel.backgroundColor = .bg30
    selectMajorLabel.textAlignment = .left
    
    selectedMajor = selectMajorLabel.text
    
    resultTableView.isHidden = true
    
    selectMajorLabel.isHidden = false
    cancelButton.isHidden = false
    
    view.addSubview(selectMajorLabel)
    view.addSubview(cancelButton)
    
    selectMajorLabel.snp.makeConstraints { make in
      make.top.equalTo(describeLabel.snp.bottom).offset(-30)
      make.leading.equalTo(searchController).offset(10)
      make.width.equalTo(labelSize.width + 40)
      make.height.equalTo(30)
    }
    
    cancelButton.snp.makeConstraints { make in
      make.centerY.equalTo(selectMajorLabel.snp.centerY)
      make.leading.equalTo(selectMajorLabel.snp.trailing).offset(-25)
    }
    view.layoutIfNeeded()
  }
}
