//
//  MyPostViewController.swift
//  STUDYHUB2
//
//  Created by 최용헌 on 2023/11/17.
//

import UIKit

import SnapKit

final class MyPostViewController: NaviHelper {
  let myPostDataManager = MyPostInfoManager.shared
  var myPostDatas: [MyPostInfo] = []

  var countPostNumber = 1 {
    didSet {
      totalPostCountLabel.text = "전체 \(countPostNumber)"
    }
  }
  
  private lazy var totalPostCountLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "Pretendard", size: 14)
    return label
  }()
  
  private lazy var deleteAllButton: UIButton = {
    let button = UIButton()
    button.setTitle("전체삭제", for: .normal)
    button.setTitleColor(UIColor.bg70, for: .normal)
    button.titleLabel?.font = UIFont(name: "Pretendard", size: 14)
    return button
  }()
  
  // MARK: - 작성한 글 없을 때
  private lazy var emptyImage: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "EmptyPostImg")
    return imageView
  }()
  
  private lazy var emptyLabel: UILabel = {
    let label = UILabel()
    label.text = "작성한 글이 없어요\n새로운 스터디 활동을 시작해 보세요!"
    label.numberOfLines = 0
    label.textColor = .bg70
    return label
  }()
  
  private lazy var writePostButton: UIButton = {
    let button = UIButton()
    button.setTitle("글 작성하기", for: .normal)
    button.setTitleColor(UIColor.white, for: .normal)
    button.backgroundColor = .o50
    button.layer.cornerRadius = 5
    return button
  }()
  
  // MARK: - 작성한 글 있을 때
  private lazy var myPostCollectionView: UICollectionView = {
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

    getMyPostData {
      self.setupLayout()
      self.makeUI()
    }
  }
  
  // MARK: - setupLayout
  func setupLayout(){
    [
      totalPostCountLabel,
      deleteAllButton
    ].forEach {
      view.addSubview($0)
    }
    
    if countPostNumber > 0 {
      view.addSubview(scrollView)
      scrollView.addSubview(myPostCollectionView)
    } else {
      [
        emptyImage,
        emptyLabel,
        writePostButton
      ].forEach {
        view.addSubview($0)
      }
    }
  }
  
  // MARK: - makeUI
  func makeUI(){
    totalPostCountLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(10)
      make.leading.equalToSuperview().offset(20)
    }
    
    deleteAllButton.snp.makeConstraints { make in
      make.top.equalTo(totalPostCountLabel)
      make.trailing.equalToSuperview().offset(-10)
      make.centerY.equalTo(totalPostCountLabel)
    }
    
    if countPostNumber > 0 {
      myPostCollectionView.snp.makeConstraints { make in
        make.width.equalToSuperview()
        make.height.equalTo(scrollView.snp.height)
      }
      
      scrollView.snp.makeConstraints { make in
        make.top.equalTo(totalPostCountLabel.snp.bottom).offset(20)
        make.leading.trailing.bottom.equalTo(view)
      }
    }else {
      emptyImage.snp.makeConstraints { make in
        make.centerX.equalToSuperview()
        make.centerY.equalToSuperview().offset(-20)
        make.height.equalTo(210)
        make.width.equalTo(180)
      }
      
      emptyLabel.setLineSpacing(spacing: 15)
      emptyLabel.textAlignment = .center
      emptyLabel.changeColor(label: emptyLabel,
                        wantToChange: "새로운 스터디 활동을 시작해 보세요!",
                        color: .bg60)
      emptyLabel.snp.makeConstraints { make in
        make.centerX.equalTo(emptyImage)
        make.top.equalTo(emptyImage.snp.bottom).offset(20)
      }
      
      writePostButton.snp.makeConstraints { make in
        make.centerX.equalTo(emptyImage)
        make.top.equalTo(emptyLabel).offset(70)
        make.width.equalTo(195)
        make.height.equalTo(47)
      }
    }

  }
  
  private func registerCell() {
    myPostCollectionView.delegate = self
    myPostCollectionView.dataSource = self
    
    myPostCollectionView.register(MyPostCell.self,
                                    forCellWithReuseIdentifier: MyPostCell.id)
  }
  
  // MARK: - navigationbar 재설정
  func redesignNavigationbar(){
    navigationItem.rightBarButtonItems = .none
    self.navigationItem.title = "작성한 글"
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
  }

  func getMyPostData(completion: @escaping () -> Void) {
    DispatchQueue.global().async {
      self.myPostDataManager.getMyPostDataFromApi {
        DispatchQueue.main.async {
          self.myPostDatas = self.myPostDataManager.getMyPostData()
          self.countPostNumber = self.myPostDatas.count
          self.myPostCollectionView.reloadData()
          completion()
        }
      }
    }
  }
}

// MARK: - collectionView
extension MyPostViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return myPostDatas.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      didSelectItemAt indexPath: IndexPath) {
    let postedVC = PostedStudyViewController()
    self.navigationController?.pushViewController(postedVC, animated: true)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath)  -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPostCell.id,
                                                  for: indexPath) as! MyPostCell
    
    cell.delegate = self
    cell.majorLabel.text = convertMajor(myPostDatas[indexPath.row].major,
                                        isEnglish: false)
    cell.titleLabel.text = myPostDatas[indexPath.row].title
    cell.infoLabel.text = myPostDatas[indexPath.row].content
    cell.remainCount = myPostDatas[indexPath.row].remainingSeat
     

    return cell
  }
}

// 셀의 각각의 크기
extension MyPostViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 350, height: 181)
  }
}

// MARK: - MyPostcell 함수
extension MyPostViewController: MyPostCellDelegate{
  func menuButtonTapped(in cell: MyPostCell) {
      let viewControllerToPresent = BottomSheet()
      if #available(iOS 15.0, *) {
        if let sheet = viewControllerToPresent.sheetPresentationController {
          if #available(iOS 16.0, *) {
            sheet.detents = [.custom(resolver: { context in
              return 228.0
            })]
          } else {
            // Fallback on earlier versions
          }
          sheet.largestUndimmedDetentIdentifier = nil
          sheet.prefersScrollingExpandsWhenScrolledToEdge = false
          sheet.prefersEdgeAttachedInCompactHeight = true
          sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
          sheet.preferredCornerRadius = 20
        }
      } else {
        // Fallback on earlier versions
      }
      present(viewControllerToPresent, animated: true, completion: nil)
  }
  
  func closeButtonTapped(in cell: MyPostCell){
    let popupVC = PopupViewController(title: "이 글의 모집을 마감할까요?",
                                      desc: "마감하면 다시 모집할 수 없어요")
    popupVC.modalPresentationStyle = .overFullScreen
    self.present(popupVC, animated: false)
  }
}
