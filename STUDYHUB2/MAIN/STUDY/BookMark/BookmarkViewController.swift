
import UIKit

import SnapKit

// 로그인, 비로그인 나눠야함
final class BookmarkViewController: NaviHelper {
  
  // MARK: - 화면 구성
  var countNumber: Int = 4
  private lazy var totalCountLabel = createLabel(title: "전체 \(countNumber)",
                                                 textColor: .bg80,
                                                 fontType: "Pretendard",
                                                 fontSize: 16)
  
  private lazy var deleteAllButton: UIButton = {
    let button = UIButton()
    button.setTitle("전체삭제", for: .normal)
    button.setTitleColor(.bg70, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 14)
    button.frame = CGRect(x: 0, y: 0, width: 57, height: 30)
    button.addTarget(self, action: #selector(deleteAllButtonTapped), for: .touchUpInside)
    
    return button
  }()
  
  private lazy var emptyMainImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "EmptyBookMarkImg")
    return imageView
  }()
  
  private lazy var emptyMainLabel = createLabel(title: "북마크 글이 없어요\n관심있는 스터디를 저장해 보세요!",
                                                textColor: .bg70,
                                                fontType: "Pretendard",
                                                fontSize: 16)
  
  private lazy var bookMarkCollectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .vertical
    flowLayout.minimumLineSpacing = 10
    
    let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    view.backgroundColor = .bg30
    view.clipsToBounds = false
    return view
  }()
  
  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.backgroundColor = .bg30
    return scrollView
  }()
  
  // MARK: - viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .bg30
    
    navigationItemSetting()
    redesignNavigationbar()
    
    registerCell()
    
    setupLayout()
    makeUI()
  }
  
  // MARK: - 네비게이션 바 재설정
  func redesignNavigationbar(){
    navigationItem.rightBarButtonItems = .none
  }
  
  // MARK: - setupLayout
  func setupLayout(){
    if countNumber > 0 {
      [
        totalCountLabel,
        deleteAllButton,
        scrollView
      ].forEach {
        view.addSubview($0)
      }
      
      scrollView.addSubview(bookMarkCollectionView)
    } else {
      [
        totalCountLabel,
        deleteAllButton,
        emptyMainImageView,
        emptyMainLabel
      ].forEach {
        view.addSubview($0)
      }
    }
  }
  
  // MARK: - makeUI
  func makeUI(){
    totalCountLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
      make.leading.equalToSuperview().offset(20)
    }
    
    deleteAllButton.snp.makeConstraints { make in
      make.centerY.equalTo(totalCountLabel)
      make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
    }
    
    if countNumber > 0 {
      bookMarkCollectionView.snp.makeConstraints { make in
        make.width.equalToSuperview()
        make.height.equalTo(scrollView.snp.height)
      }
      
      scrollView.snp.makeConstraints { make in
        make.top.equalTo(totalCountLabel.snp.bottom).offset(20)
        make.leading.trailing.bottom.equalTo(view)
      }
    } else {
      emptyMainImageView.snp.makeConstraints { make in
        make.centerX.equalToSuperview()
        make.centerY.equalToSuperview().offset(-50)
      }
      
      emptyMainLabel.numberOfLines = 2
      emptyMainLabel.textAlignment = .center
      emptyMainLabel.changeColor(label: emptyMainLabel,
                                 wantToChange: "관심있는 스터디를 저장해 보세요!", color: .bg60)
      emptyMainLabel.snp.makeConstraints { make in
        make.top.equalTo(emptyMainImageView.snp.bottom)
        make.centerX.equalTo(emptyMainImageView)
      }
    }
    
  }
  
  private func registerCell() {
    bookMarkCollectionView.delegate = self
    bookMarkCollectionView.dataSource = self
    
    bookMarkCollectionView.register(BookMarkCell.self,
                                    forCellWithReuseIdentifier: BookMarkCell.id)
  }
  @objc func deleteAllButtonTapped(){
    // postID 수정 필요
    let popupVC = PopupViewController(title: "",
                                      desc: "북마크를 모두 삭제할까요?",
                                      postID: 1, bottomeSheet: nil)
    popupVC.modalPresentationStyle = .overFullScreen
    self.present(popupVC, animated: false)
  }
}

// MARK: - collectionView
extension BookmarkViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
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
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookMarkCell.id,
                                                  for: indexPath)
    
    return cell
  }
}

// 셀의 각각의 크기
extension BookmarkViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 350, height: 210)
  }
}

