
import UIKit

import SnapKit

// 로그인, 비로그인 나눠야함
final class BookmarkViewController: NaviHelper {
  
  // MARK: - 화면 구성
  var countNumber: Int = 0
  private lazy var totalCountLabel = createLabel(title: "전체 \(countNumber)",
                                                 textColor: .bg80,
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
                                                fontSize: 16)
  
  // MARK: - viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .bg30
    
    navigationItemSetting()
    redesignNavigationbar()
    
    setupLayout()
    makeUI()
  
  }
  
  // MARK: - 네비게이션 바 재설정
  func redesignNavigationbar(){
    navigationItem.rightBarButtonItems = .none
    
    navigationController?.navigationBar.topItem?.title = "북마크"
    navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
  }
  
  // MARK: - setupLayout
  func setupLayout(){
    [
      totalCountLabel,
      deleteAllButton,
      emptyMainImageView,
      emptyMainLabel
    ].forEach {
      view.addSubview($0)
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
  
  @objc func deleteAllButtonTapped(){
    print("alldelete")
  }
  
}
