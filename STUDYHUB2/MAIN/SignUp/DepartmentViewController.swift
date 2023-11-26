import UIKit
import SnapKit

final class DepartmentViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate, UITableViewDataSource {
    var email: String?
    var password: String?
    var gender: String?
    var nickname: String?
    var major: String?
    var selectedDepartment: String?
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 0, y: 315, width: view.bounds.width - 10, height: 30)
        if let searchBarTextField = searchBar.value(forKey: "searchField") as? UITextField {
            searchBarTextField.font = UIFont.boldSystemFont(ofSize: 14)
            searchBarTextField.attributedPlaceholder = NSAttributedString(
                string: "현재 재학 중인 학과를 적어주세요",
                attributes: [.foregroundColor:  UIColor(hexCode: "#636363"),]
            )
            searchBarTextField.textColor = UIColor(hexCode: "#FFFFFF")
            searchBarTextField.layer.masksToBounds = true
            searchBarTextField.backgroundColor = .clear
        }
        let searchImg = UIImage(named: "SearchImg")?.withRenderingMode(.alwaysOriginal)
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        return searchBar
    }()
    
    lazy var searchIconButton: UIButton = {
        let searchIconButton = UIButton(type: .system)
        searchIconButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchIconButton.tintColor = .white
        return searchIconButton
    }()
    
    private let availableDepartments = ["공연예술과", "IBE전공", "건설환경공학", "건축공학",
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
                                        "전기공학과","전자공학과","정보통신공학과","정치외교학과","중어중국학과","창의인개발학과",
                                        "체육교육과","컴퓨터공학부","테크노경영학과","패션산업학과","한국화전공(조형예술학부)",
                                        "해양학과","행정학과","화학과","환경공학" ]
    var matchingDepartments: [String] = []
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
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
        departmentLabel.textColor = UIColor(hexCode: "#A6A6A6")
        departmentLabel.font = UIFont.systemFont(ofSize: 14)
        return departmentLabel
    }()
    
    private let departmentTextFielddividerLine: UIView = {
        let departmentTextFielddividerLine = UIView()
        departmentTextFielddividerLine.backgroundColor = UIColor(hexCode: "#8F8F8F")
        return departmentTextFielddividerLine
    }()
    
    lazy var nextButton: UIButton = {
        let nextButton = UIButton(type: .system)
        nextButton.setTitle("다음", for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.backgroundColor = UIColor(hexCode: "FF5935")
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        nextButton.layer.cornerRadius = 10
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return nextButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUpLayout()
        makeUI()
    }
    
    func setUpLayout() {
        [
            titleLabel, searchBar, searchIconButton, progressLabel, departmentPromptLabel,
            departmentLabel, departmentTextFielddividerLine, tableView, nextButton
        ].forEach {
            view.addSubview($0)
        }
    }
    
    func makeUI() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-35)
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
        searchIconButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchBar.snp.centerY)
            make.trailing.equalTo(searchBar.snp.trailing).offset(-8)
            make.width.equalTo(20.85)
            make.height.equalTo(20.28)
        }
        departmentTextFielddividerLine.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.height.equalTo(1)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(departmentTextFielddividerLine.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.lessThanOrEqualTo(300)
        }
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(departmentTextFielddividerLine.snp.bottom).offset(350)
            make.height.equalTo(55)
            make.width.equalTo(400)
        }
    }
    
    @objc func nextButtonTapped() {
        let completeViewController = CompleteViewController()
        
        
        // 회원가입 정보 JSON 형식으로 생성
        let userData: [String: Any] = [
            "email": email ?? "",
            "gender": gender ?? "",
            "major": major ?? "",
            "nickname": nickname ?? "",
            "password": password ?? "",
        ]
        
        print("email: \(email)")
        print("gender: \(gender)")
        print("major: \(major)")
        print("nickname: \(nickname)")
        print("password: \(password)")


        
        
        // JSON 데이터를 서버로 전송
        if let jsonData = try? JSONSerialization.data(withJSONObject: userData),
           let url = URL(string: "https://study-hub.site:443/api/v1/users/signup") {

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
        
          let backButton = UIBarButtonItem()
        backButton.tintColor = .black
          navigationItem.backBarButtonItem = backButton
 
        navigationController?.pushViewController(completeViewController, animated: true)
      }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchIconButton.isHidden = true
        matchingDepartments = availableDepartments.filter { $0.contains(searchText) }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingDepartments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = matchingDepartments[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = UIColor(hexCode: "#202020")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDepartment = matchingDepartments[indexPath.row]
        searchBar.text = selectedDepartment
        matchingDepartments.removeAll()
        tableView.reloadData()
//        print("selectedDepartment: \(selectedDepartment)")
        
        if selectedDepartment == "컴퓨터공학부" {
            major = "COMPUTER_SCIENCE_ENGINEERING"
        } else if selectedDepartment == "정보통신공학과" {
            major = "INFORMATION_TELECOMMUNICATION_ENGINEERING"
        }
    }
    
    

}
