import UIKit

import SnapKit

// searchResultCell이랑 같은 형식 , collectionview랑 추가버튼 같이 뜨게 수정해야함
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
  
  var studyCount = 2
  private lazy var countLabel = createLabel(title: "\(studyCount)개",
                                            textColor: .bg80,
                                            fontSize: 14)
  
  private lazy var divideLine = createDividerLine(height: 1)
  
  private lazy var emptyImage = UIImage(named: "EmptyStudy")
  private lazy var emptyImageView = UIImageView(image: emptyImage)
  
  private lazy var describeLabel = createLabel(
    title: "관련 스터디가 없어요\n지금 스터디를 만들어\n  팀원을 구해보세요!",
    textColor: .bg80,
    fontSize: 12)
  
  // 스터디가 있는 경우
  private lazy var contentView = UIView()
  private lazy var resultCollectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .vertical
    flowLayout.minimumLineSpacing = 10
    
    let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    view.backgroundColor = .white
    view.clipsToBounds = false
    
    return view
  }()
  
  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.backgroundColor = .white
    return scrollView
  }()
  
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
    
    setupCollectionView()
    
    setupLayout()
    makeUI()
  }
  
  // MARK: - setupLayout
  func setupLayout(){
    if studyCount > 0 {
      [
        recentButton,
        separateLine,
        popularButton,
        countLabel,
        divideLine,
        scrollView
      ].forEach {
        view.addSubview($0)
      }
      
      scrollView.addSubview(contentView)
      contentView.addSubview(resultCollectionView)
      contentView.addSubview(addButton)
    }else {
      [
        recentButton,
        separateLine,
        popularButton,
        countLabel,
        divideLine,
        emptyImageView,
        describeLabel,
        addButton
      ].forEach {
        view.addSubview($0)
      }
    }
  }
  
  func setupCollectionView(){
    resultCollectionView.delegate = self
    resultCollectionView.dataSource = self
    
    resultCollectionView.register(SearchResultCell.self,
                                  forCellWithReuseIdentifier: SearchResultCell.id)
  }
  // MARK: - makeUI
  func makeUI(){
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
    
    if studyCount > 0 {
      resultCollectionView.snp.makeConstraints { make in
        make.top.equalTo(contentView).offset(20)
        make.leading.trailing.equalTo(contentView)
        make.width.equalToSuperview()
        make.height.equalTo(1200)
      }
      
      addButton.snp.makeConstraints { make in
        make.width.height.equalTo(60)
        make.bottom.equalTo(scrollView.frameLayoutGuide).offset(-30)
        make.trailing.equalTo(scrollView.frameLayoutGuide).offset(-30)
      }
      
      contentView.snp.makeConstraints { make in
        make.edges.equalTo(scrollView.contentLayoutGuide)
        make.width.equalTo(scrollView.frameLayoutGuide)
        make.height.equalTo(1200)

      }
      
      scrollView.snp.makeConstraints { make in
        make.top.equalTo(divideLine.snp.bottom).offset(10)
        make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
      }
    }else {
      emptyImageView.snp.makeConstraints { make in
        make.centerX.equalToSuperview()
        make.centerY.equalToSuperview().offset(-50)
      }
      
      describeLabel.numberOfLines = 3
      describeLabel.changeColor(label: describeLabel, wantToChange: "지금 스터디를 만들어\n  팀원을 구해보세요!",
                                color: .changeInfo)
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

// MARK: - collectionView
extension StudyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      didSelectItemAt indexPath: IndexPath) {
    
    let postedVC = PostedStudyViewController()
    
    self.navigationController?.pushViewController(postedVC, animated: true)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCell.id,
                                                  for: indexPath)
    return cell
  }
}

// 셀의 각각의 크기
extension StudyViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: 350, height: 247)
    
  }
}

