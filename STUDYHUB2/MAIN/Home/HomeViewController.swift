import UIKit

import SnapKit
final class HomeViewController: UIViewController, UISearchBarDelegate {
  
  // MARK: - 화면구성
  lazy var bookmarkIconButton: UIButton = {
    let bookmarkIconButton = UIButton()
    let bookmarkIcon = UIImage(systemName: "bookmark.fill")
    
    bookmarkIconButton.setImage(bookmarkIcon, for: .normal)
    bookmarkIconButton.tintColor = UIColor(hexCode: "#C2C8CC")
    bookmarkIconButton.addTarget(self,
                                 action: #selector(bookmarkButtonTapped),
                                 for: .touchUpInside)
    return bookmarkIconButton
  }()
  
  lazy var bookmarkButton: UIButton = {
    let bookmarkButton = UIButton(type: .system)
    bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
    bookmarkButton.tintColor = .white
    bookmarkButton.addTarget(self,
                             action: #selector(bookmarkpageButtonTapped),
                             for: .touchUpInside)
    return bookmarkButton
  }()
  
  lazy var bellButton: UIButton = {
    let bellButton = UIButton(type: .system)
    bellButton.setImage(UIImage(systemName: "bell.badge"), for: .normal)
    bellButton.tintColor = .white
    return bellButton
  }()
  
  private let studyHubLabel: UILabel = {
    // Label for the "STUDY HUB" text
    let studyHubLabel = UILabel()
    studyHubLabel.text = "STUDY HUB"
    studyHubLabel.font = UIFont.boldSystemFont(ofSize: 18)
    studyHubLabel.textColor = .white
    return studyHubLabel
  }()
  
  private let smallLogoImageView: UIImageView = {
    // Image view for the small logo
    let smallLogoImageView = UIImageView(image: UIImage(named: "Image 3"))
    smallLogoImageView.contentMode = .scaleAspectFit
    return smallLogoImageView
  }()
  
  private let spacerView: UIView = {
    let spacerView = UIView()
    spacerView.setContentHuggingPriority(.defaultLow, for: .horizontal)
    return spacerView
  }()
  
  private let headerStackView: UIStackView = {
    let headerStackView = UIStackView()
    headerStackView.axis = .horizontal
    headerStackView.alignment = .center
    headerStackView.spacing = 8
    return headerStackView
  }()
  
  private let headerContentStackView: UIStackView = {
    let headerContentStackView = UIStackView()
    headerContentStackView.axis = .vertical
    headerContentStackView.spacing = 16
    return headerContentStackView
  }()
  
  private let largeImageStackView: UIStackView = {
    let largeImageStackView = UIStackView()
    largeImageStackView.axis = .vertical
    largeImageStackView.alignment = .center
    largeImageStackView.spacing = 8
    return largeImageStackView
  }()
  
  private let largeImageView: UIImageView = {
    let largeImageView = UIImageView(image: UIImage(named: "Image 2"))
    largeImageView.contentMode = .scaleAspectFill
    largeImageView.clipsToBounds = true
    return largeImageView
  }()
  
  lazy var detailsButton: UIButton = {
    let detailsButton = UIButton(type: .system)
    detailsButton.setTitle("알아보기", for: .normal)
    detailsButton.setTitleColor(.white, for: .normal)
    detailsButton.backgroundColor = UIColor(hexCode: "FF5935")
    detailsButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    detailsButton.layer.cornerRadius = 8
    detailsButton.addTarget(self, action: #selector(detailsButtonTapped), for: .touchUpInside)
    return detailsButton
  }()
  
  private let labelButtonStackView: UIStackView = {
    let labelButtonStackView = UIStackView()
    labelButtonStackView.axis = .horizontal
    labelButtonStackView.alignment = .center
    labelButtonStackView.spacing = 8
    return labelButtonStackView
  }()
  
  lazy var searchIconButton: UIButton = {
    let searchIconButton = UIButton(type: .system)
    searchIconButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
    searchIconButton.tintColor = .black
    searchIconButton.addTarget(self,
                               action: #selector(searchIconButtonTapped),
                               for: .touchUpInside)
    return searchIconButton
  }()
  
  private let searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.placeholder = "관심있는 스터디를 검색해 보세요"
    searchBar.backgroundImage = UIImage() 
    return searchBar
  }()
  
  private let newStudyLabel: UILabel = {
    let newStudyLabel = UILabel()
    newStudyLabel.text = "NEW! 모집 중인 스터디예요"
    newStudyLabel.font = UIFont.boldSystemFont(ofSize: 18)
    newStudyLabel.textColor = .black
    
    let attributedText = NSMutableAttributedString(string: "NEW! 모집 중인 스터디예요")
    attributedText.addAttribute(.foregroundColor,
                                value: UIColor(hexCode: "FF5935"),
                                range: NSRange(location: 0, length: 4))
    newStudyLabel.attributedText = attributedText
    return newStudyLabel
  }()
  
  lazy var viewAllButton: UIButton = {
    // "전체>" button
    let viewAllButton = UIButton(type: .system)
    viewAllButton.setTitle("전체>", for: .normal)
    viewAllButton.setTitleColor(.gray, for: .normal)
    viewAllButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    return viewAllButton
  }()
  
  lazy var interestButton: UIButton = {
    let interestButton = UIButton(type: .system)
    interestButton.setTitle("관심사", for: .normal)
    interestButton.setTitleColor(UIColor(hexCode: "FF5935"), for: .normal)
    interestButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    interestButton.backgroundColor = UIColor(hexCode: "#FFF1EE")
    interestButton.layer.cornerRadius = 8
    return interestButton
  }()
  
  private let titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.text = "제목 (최대 2줄)"
    titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
    titleLabel.textColor = .black
    return titleLabel
  }()
  
  private let buttonLabelStackView: UIStackView = {
    let buttonLabelStackView = UIStackView()
    buttonLabelStackView.axis = .vertical
    buttonLabelStackView.alignment = .center
    buttonLabelStackView.spacing = 8
    return buttonLabelStackView
  }()
  
  private let bottomButtonsLabelStackView: UIStackView = {
    let bottomButtonsLabelStackView = UIStackView()
    bottomButtonsLabelStackView.axis = .horizontal
    bottomButtonsLabelStackView.alignment = .center
    bottomButtonsLabelStackView.spacing = 8
    return bottomButtonsLabelStackView
  }()
  
  private let grayBorderedView: UIView = {
    let grayBorderedView = UIView()
    grayBorderedView.backgroundColor = .clear
    grayBorderedView.layer.borderWidth = 1
    grayBorderedView.layer.borderColor = UIColor(hexCode: "#C2C8CC").cgColor
    grayBorderedView.layer.cornerRadius = 8
    
    let grayBorderedViewHeightConstraint = grayBorderedView.heightAnchor.constraint(equalToConstant: 179)
    grayBorderedViewHeightConstraint.priority = .defaultHigh
    grayBorderedViewHeightConstraint.isActive = true
    return grayBorderedView
  }()
  
  private let imageTextLabelStackView: UIStackView = {
    let imageTextLabelStackView = UIStackView()
    imageTextLabelStackView.axis = .horizontal
    imageTextLabelStackView.alignment = .center
    imageTextLabelStackView.spacing = 8
    return imageTextLabelStackView
  }()
  
  private let smallImageView: UIImageView = {
    let smallImageView = UIImageView(image: UIImage(systemName: "flame.fill"))
    smallImageView.contentMode = .scaleAspectFit
    smallImageView.tintColor = UIColor(hexCode: "FF5935") // Set color
    return smallImageView
  }()
  
  private let textLabel: UILabel = {
    let textLabel = UILabel()
    textLabel.text = "마감이 임박한 스터디예요"
    textLabel.font = UIFont.boldSystemFont(ofSize: 18)
    textLabel.textColor = .black
    
    // Apply attributed text to change color of "HUB"
    let textAttributedText = NSMutableAttributedString(string: "마감이 임박한 스터디예요")
    textAttributedText.addAttribute(.foregroundColor, value: UIColor(hexCode: "FF5935"),
                                    range: NSRange(location: 0, length: 2))
    textLabel.attributedText = textAttributedText
    
    return textLabel
  }()
  
  private let additionalContentBelowStackView: UIStackView = {
    let additionalContentBelowStackView = UIStackView()
    additionalContentBelowStackView.axis = .vertical
    additionalContentBelowStackView.spacing = -30
    return additionalContentBelowStackView
  }()
  
  lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.addSubview(headerContentStackView)
    scrollView.backgroundColor = .white
    return scrollView
  }()
  
  // MARK: -  viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
   
    setUpLayout()
    makeUI()
  }
  
  // MARK: - setuplayout
  func setUpLayout(){
    
    headerStackView.addArrangedSubview(smallLogoImageView)
    headerStackView.addArrangedSubview(studyHubLabel)
    headerStackView.addArrangedSubview(spacerView)
    headerStackView.addArrangedSubview(bookmarkButton)
    headerStackView.addArrangedSubview(bellButton)
    
    view.addSubview(headerStackView)
    view.addSubview(scrollView)
    
    largeImageStackView.addArrangedSubview(largeImageView)
    largeImageStackView.addArrangedSubview(detailsButton)
    
    headerContentStackView.addArrangedSubview(largeImageStackView)
    
    searchBar.addSubview(searchIconButton)
    searchBar.delegate = self
    
    headerContentStackView.addArrangedSubview(searchBar)
    headerContentStackView.addArrangedSubview(labelButtonStackView)
    headerContentStackView.addArrangedSubview(grayBorderedView)
    headerContentStackView.addArrangedSubview(additionalContentBelowStackView)
    headerContentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    headerContentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    
    labelButtonStackView.addArrangedSubview(newStudyLabel)
    labelButtonStackView.addArrangedSubview(viewAllButton)
    
    buttonLabelStackView.addArrangedSubview(interestButton)
    buttonLabelStackView.addArrangedSubview(titleLabel)
    
    bottomButtonsLabelStackView.addArrangedSubview(buttonLabelStackView)
    bottomButtonsLabelStackView.addArrangedSubview(UIView()) // Spacer
    bottomButtonsLabelStackView.addArrangedSubview(bookmarkIconButton)
    
    grayBorderedView.addSubview(bottomButtonsLabelStackView)
    
    smallImageView.heightAnchor.constraint(equalToConstant: 110).isActive = true
    smallImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
    
    imageTextLabelStackView.addArrangedSubview(smallImageView)
    imageTextLabelStackView.addArrangedSubview(textLabel)
    
    additionalContentBelowStackView.addArrangedSubview(imageTextLabelStackView)
  }
  
  // MARK: - makeUI
  func makeUI(){
    // 상단바 stackView 알림, 북마크 , titleLabel
    headerStackView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
      make.leading.equalTo(view.snp.leading).offset(16)
      make.trailing.equalTo(view.snp.trailing).offset(-16)
    }
    
    headerContentStackView.snp.makeConstraints { make in
      make.top.equalTo(scrollView.snp.top)
      make.leading.equalTo(scrollView.snp.leading)
      make.trailing.equalTo(scrollView.snp.trailing)
      make.bottom.equalTo(scrollView.snp.bottom)
      make.width.equalTo(scrollView.snp.width)
    }
    
    largeImageView.snp.makeConstraints { make in
      make.height.equalTo(234)
      make.leading.trailing.equalTo(headerContentStackView)
      make.top.equalTo(headerContentStackView.snp.top)
    }
    
    detailsButton.snp.makeConstraints { make in
      make.height.equalTo(40)
      make.leading.equalTo(largeImageView.snp.leading).offset(20)
      make.trailing.equalTo(largeImageView.snp.trailing).offset(-250)
      make.bottom.equalTo(largeImageView.snp.bottom).offset(-20)
    }
    
    searchBar.snp.makeConstraints { make in
      make.height.equalTo(40)
      make.top.equalTo(detailsButton.snp.bottom).offset(30)
      make.leading.trailing.equalTo(headerStackView)
    }
    
    newStudyLabel.snp.makeConstraints { make in
      make.top.equalTo(labelButtonStackView.snp.top).offset(-10)
      make.leading.equalTo(labelButtonStackView.snp.leading).offset(15)
      make.trailing.equalTo(labelButtonStackView.snp.trailing).offset(-80)
    }
    
    smallImageView.snp.makeConstraints { make in
      make.leading.equalTo(imageTextLabelStackView.snp.leading).offset(15)
    }
    
    grayBorderedView.snp.makeConstraints { make in
      make.leading.equalTo(headerContentStackView.snp.leading).offset(10)
      make.trailing.equalTo(headerContentStackView.snp.trailing).offset(-150)
    }
    
    bottomButtonsLabelStackView.snp.makeConstraints { make in
      make.top.equalTo(grayBorderedView.snp.top).offset(-10)
      make.leading.equalTo(grayBorderedView.snp.leading).offset(10)
      make.trailing.equalTo(grayBorderedView.snp.trailing).offset(-8)
      make.bottom.equalTo(grayBorderedView.snp.bottom).offset(-80)
    }
    
    searchIconButton.snp.makeConstraints { make in
      make.centerY.equalTo(searchBar.snp.centerY)
      make.trailing.equalTo(searchBar.snp.trailing).offset(-8)
      make.width.equalTo(20)
      make.height.equalTo(20)
    }
    
    scrollView.snp.makeConstraints { make in
      make.top.equalTo(headerStackView.snp.bottom).offset(16)
      make.leading.equalTo(view.snp.leading)
      make.trailing.equalTo(view.snp.trailing)
      make.bottom.equalTo(view.snp.bottom)
    }
  }
  
  // MARK: - 이동하는 함수 -> 하나로 만들기
  @objc func detailsButtonTapped() {
    let detailsViewController = DetailsViewController()
    let navigationController = UINavigationController(rootViewController: detailsViewController)
    navigationController.modalPresentationStyle = .fullScreen
    present(navigationController, animated: true, completion: nil)
  }
  
  @objc func searchIconButtonTapped() {
    let searchViewController = SearchViewController()
    let navigationController = UINavigationController(rootViewController: searchViewController)
    navigationController.modalPresentationStyle = .fullScreen
    present(navigationController, animated: true, completion: nil)
  }
  
  @objc func bookmarkpageButtonTapped() {
    let bookmarkViewController = BookmarkViewController()
    let navigationController = UINavigationController(rootViewController: bookmarkViewController)
    
    navigationController.modalPresentationStyle = .fullScreen
    present(navigationController, animated: true, completion: nil)
  }
  
  // Function to handle bookmark button tap
  @objc func bookmarkButtonTapped() {
    if bookmarkIconButton.tintColor == UIColor(hexCode: "#C2C8CC") {
      bookmarkIconButton.tintColor = UIColor(hexCode: "FF5935")
      
    } else {
      bookmarkIconButton.tintColor = UIColor(hexCode: "#C2C8CC")
    }
  }
  
}

