import UIKit

import SnapKit

final class SearchViewController: UIViewController {
  
  // MARK: - 화면구성
  private let headerStackView: UIStackView = {
    let headerStackView = UIStackView()
    headerStackView.axis = .horizontal
    headerStackView.alignment = .center
    headerStackView.spacing = 8
    return headerStackView
  }()
  
  lazy var backButton: UIButton = {
    // Back button
    let backButton = UIButton(type: .system)
    backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
    backButton.tintColor = .white
    backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    return backButton
  }()
  
  private let spacerView: UIView = {
    let spacerView = UIView()
    spacerView.setContentHuggingPriority(.defaultLow, for: .horizontal)
    return spacerView
  }()
  
  lazy var bookmarkButton: UIButton = {
    // Bookmark button
    let bookmarkButton = UIButton(type: .system)
    bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
    bookmarkButton.tintColor = .white
    bookmarkButton.addTarget(self, action: #selector(bookmarkpageButtonTapped), for: .touchUpInside)
    return bookmarkButton
  }()
  
  lazy var bellButton: UIButton = {
    let bellButton = UIButton(type: .system)
    bellButton.setImage(UIImage(systemName: "bell"), for: .normal)
    bellButton.tintColor = .white
    return bellButton
  }()
  
  private let headerContentStackView: UIStackView = {
    // Header content stack view
    let headerContentStackView = UIStackView()
    headerContentStackView.axis = .vertical
    headerContentStackView.spacing = 16
    return headerContentStackView
  }()
  
  private let searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.placeholder = "관심있는 스터디를 검색해 보세요"
    searchBar.backgroundImage = UIImage()
    return searchBar
  }()
  
  private let recentallStackView: UIStackView = {
    // Recent all stack view
    let recentallStackView = UIStackView()
    recentallStackView.axis = .vertical
    return recentallStackView
  }()
  
  private let recentaskStackView: UIStackView = {
    let recentaskStackView = UIStackView()
    recentaskStackView.axis = .horizontal
    recentaskStackView.spacing = 16
    return recentaskStackView
  }()
  
  private let recentaskLabel: UILabel = {
    // Recent ask label
    let recentaskLabel = UILabel()
    recentaskLabel.text = "최근 검색어"
    recentaskLabel.textColor = .black
    recentaskLabel.font = UIFont.systemFont(ofSize: 15)
    return recentaskLabel
  }()
  
  lazy var deleteButton: UIButton = {
    // Delete button
    let deleteButton = UIButton(type: .system)
    deleteButton.setTitle("삭제", for: .normal)
    deleteButton.setTitleColor(UIColor(hexCode: "#636363"), for: .normal)
    deleteButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    return deleteButton
  }()
  
  
  private let norecentaskLabel: UILabel = {
    let norecentaskLabel = UILabel()
    norecentaskLabel.text = "최근 검색어가 없습니다"
    norecentaskLabel.textColor = UIColor(hexCode: "#C2C8CC")
    norecentaskLabel.font = UIFont.systemFont(ofSize: 15)
    return norecentaskLabel
  }()
  
  private let recentallStackViewDividerLine: UIView = {
    let recentallStackViewDividerLine = UIView()
    recentallStackViewDividerLine.backgroundColor = UIColor(hexCode: "#F3F5F6")
    return recentallStackViewDividerLine
  }()
  
  private let recommendStackView: UIStackView = {
    let recommendStackView = UIStackView()
    recommendStackView.axis = .horizontal
    recommendStackView.spacing = 16
    return recommendStackView
  }()
  
  private let recommendLabel: UILabel = {
    // Recommend label
    let recommendLabel = UILabel()
    recommendLabel.text = "추천 검색어"
    recommendLabel.textColor = .black
    recommendLabel.font = UIFont.systemFont(ofSize: 15)
    return recommendLabel
  }()
  
  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.backgroundColor = .white
    return scrollView
  }()
  
  // MARK: - viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    
    setUpLayout()
    makeUI()
    
  }
  
  func makeUI(){
    headerStackView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
      make.leading.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().offset(-16)
    }
    
    headerContentStackView.snp.makeConstraints { make in
      make.top.equalTo(headerStackView.snp.bottom).offset(16)
      make.leading.trailing.equalToSuperview()
    }

    recentallStackViewDividerLine.snp.makeConstraints { make in
      make.height.equalTo(10)
    }
    
    scrollView.snp.makeConstraints { make in
      make.top.equalTo(headerStackView.snp.bottom).offset(16)
      make.leading.trailing.bottom.equalToSuperview()
    }
    
    headerContentStackView.snp.makeConstraints { make in
      make.edges.equalTo(scrollView)
      make.width.equalTo(scrollView)
    }
  }
  
  func setUpLayout() {
    view.addSubview(headerStackView)
    view.addSubview(headerContentStackView)
    view.addSubview(scrollView)

    headerStackView.addArrangedSubview(backButton)
    headerStackView.addArrangedSubview(spacerView)
    headerStackView.addArrangedSubview(bookmarkButton)
    headerStackView.addArrangedSubview(bellButton)
  
    headerContentStackView.addArrangedSubview(searchBar)
    headerContentStackView.addArrangedSubview(recentallStackView)
    headerContentStackView.addArrangedSubview(recentallStackViewDividerLine)
    headerContentStackView.addArrangedSubview(recommendStackView)
    
    recentallStackView.addArrangedSubview(recentaskStackView)
    recentallStackView.addArrangedSubview(norecentaskLabel)
    
    recentaskStackView.addArrangedSubview(recentaskLabel)
    recentaskStackView.addArrangedSubview(deleteButton)
    
    recommendStackView.addArrangedSubview(recommendLabel)
    
    scrollView.addSubview(headerContentStackView)
  }
  
  @objc func goBack() {
    self.dismiss(animated: true, completion: nil)
  }
  
  @objc func bookmarkpageButtonTapped() {
    let bookmarkViewController = BookmarkViewController()
    let navigationController = UINavigationController(rootViewController: bookmarkViewController)
    navigationController.modalPresentationStyle = .fullScreen
    present(navigationController, animated: true, completion: nil)
  }
}
