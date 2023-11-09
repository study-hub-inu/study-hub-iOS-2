import UIKit

import SnapKit

final class DepartmentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  var email: String?
  var password: String?
  var gender: String?
  var nickname: String?
  var major: String?
  
  var selectedDepartment: String?
  
  let departments = ["국어국문학과", "영어영문학과", "독어독문학과", "불어불문학과",
                     "중어중국학과", "수학과", "물리학과", "화학과", "패션산업학과",
                     "해양학과", "사회복지학과", "컴퓨터공학과", "정보통신공학과"]
  
  // MARK: - 화면구성
  lazy var departmentButton: UIButton = {
    let departmentButton = UIButton()
    departmentButton.frame = CGRect(x: -40, y: 315, width: view.bounds.width - 40, height: 30)
    departmentButton.setTitle("현재 재학 중인 학과를 적어주세요", for: .normal)
    departmentButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
    departmentButton.setTitleColor(.gray, for: .normal)
    departmentButton.backgroundColor = UIColor.black
    departmentButton.addTarget(self,
                               action: #selector(showDepartments),
                               for: .touchUpInside)
    return departmentButton
  }()
  
  lazy var departmentTableView: UITableView = {
    let departmentTableView = UITableView()
    departmentTableView.isHidden = true
    departmentTableView.frame = CGRect(x: 20,
                                       y: departmentButton.frame.maxY,
                                       width: view.bounds.width - 40,
                                       height: 200)
    departmentTableView.dataSource = self
    departmentTableView.delegate = self
    departmentTableView.backgroundColor = .black
    return departmentTableView
  }()
  
  private let titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.text = "회원가입"
    titleLabel.textColor = .white
    titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
    return titleLabel
  }()
  
  private let progressLabel: UILabel = {
    let progressLabel = UILabel()
    progressLabel.text = "4/4"
    progressLabel.textColor = .gray
    progressLabel.font = UIFont.boldSystemFont(ofSize: 20)
    return progressLabel
  }()
  
  private let departmentPromptLabel: UILabel = {
    let departmentPromptLabel = UILabel()
    departmentPromptLabel.text = "학과를 알려주세요"
    departmentPromptLabel.textColor = .white
    departmentPromptLabel.font = UIFont.boldSystemFont(ofSize: 22)
    return departmentPromptLabel
  }()
  
  private let departmentLabel: UILabel = {
    let departmentLabel = UILabel()
    departmentLabel.text = "학과"
    departmentLabel.textColor = .white
    return departmentLabel
  }()
  
  private let departmentTextFielddividerLine: UIView = {
    let departmentTextFielddividerLine = UIView()
    departmentTextFielddividerLine.backgroundColor = .gray
    return departmentTextFielddividerLine
  }()
  
  lazy var nextButton: UIButton = {
    let nextButton = UIButton(type: .system)
    nextButton.setTitle("다음", for: .normal)
    nextButton.setTitleColor(.white, for: .normal)
    nextButton.backgroundColor = UIColor(hexCode: "FF5935")
    nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    nextButton.layer.cornerRadius = 10
    nextButton.addTarget(self,
                         action: #selector(nextButtonTapped),
                         for: .touchUpInside)
    return nextButton
  }()
  
  // MARK: - viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .black
    
    setUpLayout()
    makeUI()
    
  }
  
  // Function to toggle visibility of departmentTableView
  @objc func showDepartments() {
    departmentTableView.isHidden = !departmentTableView.isHidden
  }
  
  // MARK: - setUpLayout
  func setUpLayout(){
    [
      titleLabel,
      progressLabel,
      departmentPromptLabel,
      departmentLabel,
      departmentButton,
      departmentTableView,
      departmentTextFielddividerLine,
      nextButton
    ].forEach {
      view.addSubview($0)
    }
    
  }
  
  // MARK: - makeUI
  func makeUI(){
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-40)
      make.centerX.equalToSuperview()
    }
    
    progressLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(50)
      make.trailing.equalTo(view.snp.trailing).offset(-350)
    }
    
    departmentPromptLabel.snp.makeConstraints { make in
      make.top.equalTo(progressLabel.snp.bottom).offset(10)
      make.leading.equalTo(view.snp.leading).offset(20)
    }
    
    departmentLabel.snp.makeConstraints { make in
      make.top.equalTo(departmentPromptLabel.snp.bottom).offset(80)
      make.leading.equalTo(view.snp.leading).offset(15)
    }
    
    // Divider line constraints
    departmentTextFielddividerLine.snp.makeConstraints { make in
      make.leading.trailing.equalTo(view)
      make.top.equalTo(departmentButton.snp.bottom)
      make.height.equalTo(1)
    }
    
    nextButton.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(departmentTextFielddividerLine.snp.bottom).offset(350)
      make.height.equalTo(55)
      make.width.equalTo(400)
    }
    
  }
    
  // MARK: - 함수
  @objc func nextButtonTapped() {
    let completeViewController = CompleteViewController()
    
    // 학과 선택에 따라 major 값을 설정
    if let selectedDepartment = selectedDepartment {
      if selectedDepartment == "컴퓨터공학과" {
        major = "COMPUTER_SCIENCE_ENGINEERING"
      } else if selectedDepartment == "정보통신공학과" {
        major = "INFORMATION_TELECOMMUNICATION_ENGINEERING"
      }
    }
    
    // 회원가입 정보 JSON 형식으로 생성
    let userData: [String: Any] = [
      "email": email ?? "",
      "gender": gender ?? "",
      "major": major ?? "",
      "nickname": nickname ?? "",
      "password": password ?? "",
    ]
    
    
    // JSON 데이터를 서버로 전송
    if let jsonData = try? JSONSerialization.data(withJSONObject: userData),
       let url = URL(string: "https://study-hub.site:443/api/users/signup") {
      
      var request = URLRequest(url: url)
      request.httpMethod = "POST"
      request.httpBody = jsonData
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      
      URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let data = data {
          // 서버 응답 데이터 처리
          if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
            print("서버 응답: \(json)")
          }
        } else if let error = error {
          print("네트워크 오류: \(error.localizedDescription)")
        }
      }.resume()
    }
    
    // Use the navigation controller to push the CompleteViewController onto the navigation stack
    navigationController?.pushViewController(completeViewController, animated: true)
  }
  
  // UITableViewDataSource methods
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return departments.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: "departmentCell")
    cell.textLabel?.text = departments[indexPath.row]
    cell.textLabel?.textColor = .gray // Set the text color of the items in the departmentTableView to gray
    cell.backgroundColor = .black // Set the background color of the cells to black
    return cell
  }
  // UITableViewDelegate method
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let selectedDepartment = departments[indexPath.row]
    
    // Update the department button text with the selected department name
    departmentButton.setTitle(selectedDepartment, for: .normal)
    
    // Store the selected department name for later use if needed
    self.selectedDepartment = selectedDepartment
    
    // Hide the departmentTableView after selection
    departmentTableView.isHidden = true
    
    
  }
}
