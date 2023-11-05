import UIKit

class DepartmentselectViewController: UIViewController, UISearchBarDelegate {
    
//    weak var delegate: DepartmentSelectionDelegate?

    
    private let deleteButton = UIButton(type: .system)
    private let searchResultButton = UIButton(type: .system)
    
    // DepartmentselectViewController 클래스 내에 프로퍼티 추가
    var selectedDepartments: [String] = [] // 선택된 학과를 저장할 배열
    var departmentButtons: [UIButton] = [] // 선택된 학과를 나타내는 버튼을 저장할 배열
    
    private let headerContentStackView = UIStackView()
    private let searchBar = UISearchBar()
    private let infoLabel1 = UILabel()
    private let infoLabel2 = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        // 키보드 내리기를 위한 탭 제스처 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
        
        // Create the top stack view for the header
        let headerStackView = UIStackView()
        headerStackView.axis = .horizontal
        headerStackView.alignment = .center
        headerStackView.spacing = 8
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Back button
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the backButton and studyLabel to the header stack view
        headerStackView.addArrangedSubview(backButton)
        
        // "관련학과" label
        let associatedepartLabel = UILabel()
        associatedepartLabel.text = "관련학과"
        associatedepartLabel.textColor = .white
        associatedepartLabel.font = UIFont.boldSystemFont(ofSize: 18)
        associatedepartLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerStackView.addArrangedSubview(associatedepartLabel)
        
        // "완료" button
        let doneButton = UIButton(type: .system)
        doneButton.setTitle("완료", for: .normal)
        doneButton.setTitleColor(UIColor(hexCode: "FF5935"), for: .normal)
        doneButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Spacer view to push the bookmarkButton and bellButton to the right
        let spacerView = UIView()
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        spacerView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        headerStackView.addArrangedSubview(spacerView)
        
        // Add the bookmarkButton and bellButton to the header stack view
        headerStackView.addArrangedSubview(doneButton)
        
        // Add the header stack view to the view
        view.addSubview(headerStackView)
        
        headerContentStackView.axis = .vertical
        headerContentStackView.spacing = 16
        headerContentStackView.translatesAutoresizingMaskIntoConstraints = false

        
        // Search Bar
        searchBar.placeholder = "관련학과를 입력해주세요"
        searchBar.backgroundImage = UIImage() // Remove background image
        searchBar.delegate = self // Set the delegate to self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        headerContentStackView.addArrangedSubview(searchBar)
        
        // Create labels for additional information
        infoLabel1.text = "- 해당 스터디와 관련된 학과를 선택해주세요"
        infoLabel1.textColor = .gray
        infoLabel1.font = UIFont.systemFont(ofSize: 14)
        infoLabel1.translatesAutoresizingMaskIntoConstraints = false
        
        infoLabel2.text = "- 관련 학과는 1개만 선택할 수 있어요"
        infoLabel2.textColor = .gray
        infoLabel2.font = UIFont.systemFont(ofSize: 14)
        infoLabel2.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the info labels to the header content stack view
        headerContentStackView.addArrangedSubview(infoLabel1)
        headerContentStackView.addArrangedSubview(infoLabel2)
        
        // Create a scroll view to make the content scrollable
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(headerContentStackView)
        view.addSubview(scrollView)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            // Header stack view constraints
            headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -60),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // "스터디 만들기" label constraints
            associatedepartLabel.centerXAnchor.constraint(equalTo: headerStackView.centerXAnchor, constant: 16),
            
            // Spacer view constraints
            spacerView.widthAnchor.constraint(equalTo: headerStackView.widthAnchor, multiplier: 0.2),
            
            // "완료" button constraints
            doneButton.trailingAnchor.constraint(equalTo: headerStackView.trailingAnchor),
            
            // Search bar constraints
            searchBar.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
//            searchIconButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
//            searchIconButton.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
//            searchIconButton.widthAnchor.constraint(equalToConstant: 20),
//            searchIconButton.heightAnchor.constraint(equalToConstant: 20),
//
            // Info labels constraints
            infoLabel1.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 50),
            infoLabel2.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 20),
            
            // Header content stack view constraints
            headerContentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            headerContentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            headerContentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            headerContentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            headerContentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Scroll view constraints
            scrollView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        // Set the background color of the scrollView to black
        scrollView.backgroundColor = .white
        
        // Set the scroll view's content size to fit the content
        headerContentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    // UISearchBarDelegate에서 검색 버튼을 누를 때 호출되는 메서드
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            // 입력된 텍스트가 비어 있지 않으면 버튼을 만듭니다.
            createSearchButton(withText: searchText)
            
            // 검색 바 초기화
            searchBar.text = ""
            
            // 라벨 삭제
            infoLabel1.removeFromSuperview()
            infoLabel2.removeFromSuperview()
        }
    }

    func createSearchButton(withText text: String) {
        // 버튼 생성
        // Stack view for the newStudyLabel and viewAllButton
        
        searchResultButton.backgroundColor = UIColor(hexCode: "F3F5F6")
        searchResultButton.setTitleColor(UIColor(hexCode: "68737D"), for: .normal)
        searchResultButton.setTitle(text, for: .normal)
        searchResultButton.layer.cornerRadius = 20
        searchResultButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        searchResultButton.contentHorizontalAlignment = .center // 텍스트를 왼쪽으로 정렬
        
        // 문자열 길이에 따라 버튼 가로 길이 동적 조절
        let buttonWidth = text.width(withConstrainedHeight: 30, font: searchResultButton.titleLabel!.font)
        searchResultButton.widthAnchor.constraint(equalToConstant: buttonWidth + 50).isActive = true
        
        // Back button
        deleteButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        deleteButton.tintColor = .lightGray
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        // 생성된 버튼을 배열에 추가
        departmentButtons.append(searchResultButton)
        // 생성된 버튼을 배열에 추가
        departmentButtons.append(deleteButton)
        
        // 버튼을 UI에 추가 (예: 스택 뷰에 추가)
        headerContentStackView.addArrangedSubview(searchResultButton)
        // 버튼을 UI에 추가 (예: 스택 뷰에 추가)
        headerContentStackView.addArrangedSubview(deleteButton)
        
        // 적절한 제약 조건 추가 (버튼 크기 설정, 여기서는 제약 조건을 추가해야 할 수도 있음)
        NSLayoutConstraint.activate([
            searchResultButton.leadingAnchor.constraint(equalTo: headerContentStackView.leadingAnchor, constant: 10),
            searchResultButton.trailingAnchor.constraint(equalTo: headerContentStackView.trailingAnchor, constant: -200),
            searchResultButton.heightAnchor.constraint(equalToConstant: 30),
            
            deleteButton.topAnchor.constraint(equalTo: searchResultButton.topAnchor, constant: 2),
//            deleteButton.leadingAnchor.constraint(equalTo: headerContentStackView.leadingAnchor, constant: -240),
            deleteButton.trailingAnchor.constraint(equalTo: headerContentStackView.trailingAnchor, constant: -50),
            
        ])
    }
    
    @objc func deleteButtonTapped(sender: UIButton) {
        headerContentStackView.removeArrangedSubview(searchResultButton)
        headerContentStackView.removeArrangedSubview(deleteButton)
        searchResultButton.removeFromSuperview()
        deleteButton.removeFromSuperview()
        
    }
    

//    @objc func doneButtonTapped() {
////        print("선택된 학과: \(searchResultButton.currentTitle)")
//        if searchResultButton.currentTitle != nil {
//                // 첫 번째 버튼의 제목을 가져와 선택된 학과로 사용합니다.
////                print("선택된 학과: \(searchResultButton.currentTitle)")
////                print("선택된 학과: \(searchResultButton.currentTitle)")
//            }
//        dismiss(animated: true, completion: nil)
//    }
   
    
    @objc func doneButtonTapped() {
        if let selectedDepartment = searchResultButton.currentTitle {
            // 선택한 학과를 CreateStudyViewController로 전달
            let createVC = CreateStudyViewController()

            // CreateStudyViewController의 categoryStackView에 버튼을 추가
            createVC.addDepartmentButton(selectedDepartment)
            
            // CreateStudyViewController를 표시
            present(createVC, animated: true, completion: nil)
        }
    }
    
    
    
    // 키보드 내리기 위한 탭 제스처 핸들러
    @objc func handleTap() {
        // 키보드를 내립니다.
        view.endEditing(true)
    }
    
    // Function to handle back button tap and navigate back to CreateStudyViewController
    @objc func goBack() {
        self.dismiss(animated: true, completion: nil)
    }
}
