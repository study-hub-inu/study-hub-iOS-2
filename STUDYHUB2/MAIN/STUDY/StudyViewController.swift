import UIKit

import SnapKit

final class StudyViewController: NaviHelper {
  private lazy var recentButton: UIButton = {
    let button = UIButton()
    button.setTitle("최신순", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 16)
    button.frame = CGRect(x: 0, y: 0, width: 57, height: 30)
    button.addTarget(self, action: #selector(recentButtonTapped), for: .touchUpInside)
    
    return button
  }()
  
  let separateLine = UIView()
  
  private lazy var popularButton: UIButton = {
    let button = UIButton()
    button.setTitle("인기순", for: .normal)
    button.setTitleColor(.bg70, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 16)
    button.frame = CGRect(x: 0, y: 0, width: 57, height: 30)
    button.addTarget(self, action: #selector(popularButtonTapped), for: .touchUpInside)
    
    return button
  }()
  
  private lazy var countLabel = createLabel(title: "4개",
                                            textColor: .bg80,
                                            fontSize: 14)
  
  private lazy var divideLine = createDividerLine(height: 1)

  private lazy var emptyImage = UIImage(named: "EmptyStudy")
  private lazy var emptyImageView = UIImageView(image: emptyImage)
  
  private lazy var describeLabel = createLabel(
    title: "관련 스터디가 없어요\n지금 스터디를 만들어\n  팀원을 구해보세요!",
    textColor: .bg80,
    fontSize: 12)
  
  private lazy var addButton: UIButton = {
    let addButton = UIButton(type: .system)
    addButton.setTitle("+", for: .normal)
    addButton.setTitleColor(.white, for: .normal)
    addButton.backgroundColor = UIColor(hexCode: "FF5935")
    addButton.layer.cornerRadius = 30
    addButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
    addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    return addButton
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    navigationItemSetting()
    redesignNavigationbar()
    
    makeUI()
  }
  
  func makeUI(){
    view.addSubview(recentButton)
    view.addSubview(separateLine)
    view.addSubview(popularButton)
    view.addSubview(countLabel)
    view.addSubview(divideLine)
    view.addSubview(emptyImageView)
    view.addSubview(describeLabel)
    view.addSubview(addButton)

    recentButton.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.leading.equalToSuperview().offset(10)
    }
    
    separateLine.backgroundColor = .bg50
    separateLine.snp.makeConstraints { make in
      make.top.equalTo(recentButton).offset(10)
      make.bottom.equalTo(recentButton.snp.bottom).offset(-10)
      make.leading.equalTo(recentButton.snp.trailing).offset(10)
      make.width.equalTo(1)
    }
    
    popularButton.snp.makeConstraints { make in
      make.top.equalTo(recentButton)
      make.leading.equalTo(separateLine.snp.trailing).offset(10)
    }
    
    countLabel.snp.makeConstraints { make in
      make.centerY.equalTo(recentButton)
      make.trailing.equalToSuperview().offset(-10)
    }
    
    divideLine.backgroundColor = .bg30
    divideLine.snp.makeConstraints { make in
      make.top.equalTo(recentButton.snp.bottom).offset(10)
      make.leading.trailing.equalToSuperview()
    }
    
    emptyImageView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.centerY.equalToSuperview().offset(-50)
    }
    
    describeLabel.numberOfLines = 3
    describeLabel.changeColor(label: describeLabel, wantToChange: "지금 스터디를 만들어\n  팀원을 구해보세요!", color: .changeInfo)
    describeLabel.snp.makeConstraints { make in
      make.top.equalTo(emptyImageView.snp.bottom).offset(10)
      make.centerX.equalTo(emptyImageView)
    }
    
    addButton.snp.makeConstraints { make in
      make.width.height.equalTo(60) // Increase width and height as needed
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
      make.trailing.equalTo(view).offset(-16)
    }
  }
  
  // MARK: -  네비게이션바 재설정
  func redesignNavigationbar(){
    let logoImg = UIImage(named: "StudyImg")?.withRenderingMode(.alwaysOriginal)
    let logo = UIBarButtonItem(image: logoImg, style: .done, target: nil, action: nil)
    logo.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    logo.isEnabled = false
    
    let bookMarkImg = UIImage(named: "SearchImg_White")?.withRenderingMode(.alwaysOriginal)
    lazy var bookMark = UIBarButtonItem(
      image: bookMarkImg,
      style: .plain,
      target: self,
      action: #selector(searchButtonTapped))
    bookMark.imageInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
    
    let alertBellImg = UIImage(named: "BellImgWithWhite")?.withRenderingMode(.alwaysOriginal)
    lazy var alertBell = UIBarButtonItem(
      image: alertBellImg,
      style: .plain,
      target: self,
      action: nil)
    alertBell.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    navigationItem.leftBarButtonItem = logo
    navigationItem.rightBarButtonItems = [alertBell, bookMark]
  }
  
  @objc func searchButtonTapped() {
    print("아직")
  }
  
  @objc func addButtonTapped() {
    let createStudyViewController = CreateStudyViewController()
    let navigationController = UINavigationController(rootViewController: createStudyViewController)
    navigationController.modalPresentationStyle = .fullScreen
    
    // Present the navigation controller modally
    present(navigationController, animated: true, completion: nil)
  }
  
  @objc func recentButtonTapped(){
    print("1")
    recentButton.setTitleColor(.black, for: .normal)
    popularButton.setTitleColor(.bg70, for: .normal)
    
  }
  
  @objc func popularButtonTapped(){
    print("2")
    recentButton.setTitleColor(.bg70, for: .normal)
    popularButton.setTitleColor(.black, for: .normal)
  }
}
