//
//  MyPostViewController.swift
//  STUDYHUB2
//
//  Created by 최용헌 on 2023/11/17.
//

import UIKit

import SnapKit

final class MyPostViewController: NaviHelper {
  
  var countPostNumber = 4
  private lazy var totalPostCountLabel: UILabel = {
    let label = UILabel()
    label.text = "전체 \(countPostNumber)"
    return label
  }()
  
  private lazy var deleteAllButton: UIButton = {
    let button = UIButton()
    button.setTitle("전체삭제", for: .normal)
    button.setTitleColor(UIColor.bg70, for: .normal)
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

    setupLayout()
    makeUI()
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
}

// MARK: - collectionView
extension MyPostViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
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
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPostCell.id,
                                                  for: indexPath)
    
    return cell
  }
}

// 셀의 각각의 크기
extension MyPostViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 350, height: 210)
  }
}

