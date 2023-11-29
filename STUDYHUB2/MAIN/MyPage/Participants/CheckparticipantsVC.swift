//
//  CheckParticipantsVC.swift
//  STUDYHUB2
//
//  Created by 최용헌 on 2023/11/24.
//

import UIKit

import SnapKit

final class CheckParticipantsVC: NaviHelper {
  
  private lazy var topItemStackView = createStackView(axis: .horizontal,
                                                      spacing: 10)
  private lazy var waitButton: UIButton = {
    let button = UIButton()
    button.setTitle("대기", for: .normal)
    button.setTitleColor(UIColor.black, for: .normal)
    button.titleLabel?.font = UIFont(name: "Pretendard", size: 16)
    button.setUnderline()
    button.addAction(UIAction { [weak self] _ in
      self?.waitButtonTapped()
    }, for: .touchUpInside)
    return button
  }()
  
  private lazy var participateButton: UIButton = {
    let button = UIButton()
    button.setTitle("참여", for: .normal)
    button.setTitleColor(UIColor.bg70, for: .normal)
    button.titleLabel?.font = UIFont(name: "Pretendard", size: 16)
    button.setUnderline()
    button.removeUnderline()
    button.addAction(UIAction { [weak self] _ in
      self?.participateButtonTapped()
    }, for: .touchUpInside)
    return button
  }()
  
  private lazy var refuseButton: UIButton = {
    let button = UIButton()
    button.setTitle("거절", for: .normal)
    button.setTitleColor(UIColor.bg70, for: .normal)
    button.titleLabel?.font = UIFont(name: "Pretendard", size: 16)
    button.setUnderline()
    button.removeUnderline()
    button.addAction(UIAction { [weak self] _ in
      self?.refusetButtonTapped()
    }, for: .touchUpInside)
    return button
  }()
  
  // MARK: - 참여자 있을 때
  private lazy var waitingCollectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .vertical
    flowLayout.minimumLineSpacing = 10
    
    let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    view.backgroundColor = .bg30
    view.clipsToBounds = false
    return view
  }()
  
  private lazy var participateCollectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .vertical
    flowLayout.minimumLineSpacing = 10
    
    let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    view.backgroundColor = .bg30
    view.clipsToBounds = false
    return view
  }()
  
  private lazy var refuseCollectionView: UICollectionView = {
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
    view.backgroundColor = .white
    
    navigationItemSetting()
    redesignNavigationbar()
    
    setupLayout()
    makeUI()
    
    registerCell()
  }
  
  // MARK: - setupLayout
  func setupLayout(){
    [
      waitButton,
      participateButton,
      refuseButton
    ].forEach {
      topItemStackView.addArrangedSubview($0)
    }
    
    scrollView.addSubview(waitingCollectionView)
    scrollView.addSubview(participateCollectionView)
    scrollView.addSubview(refuseCollectionView)
    
    participateCollectionView.isHidden = true
    refuseCollectionView.isHidden = true

    [
      topItemStackView,
      scrollView
    ].forEach {
      view.addSubview($0)
    }
    
  }
  
  // MARK: - makeUI
  func makeUI(){
    topItemStackView.distribution = .fillEqually
    topItemStackView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
      $0.leading.trailing.equalToSuperview()
    }
    
    waitingCollectionView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
      $0.width.equalToSuperview()
      $0.height.equalTo(scrollView.snp.height)
    }
    
    scrollView.snp.makeConstraints {
      $0.top.equalTo(topItemStackView.snp.bottom).offset(5)
      $0.leading.trailing.bottom.equalTo(view)
    }
  }
  
  // MARK: - collectionView
  private func registerCell() {
    waitingCollectionView.tag = 1
    waitingCollectionView.delegate = self
    waitingCollectionView.dataSource = self
    waitingCollectionView.register(WaitCell.self,
                                   forCellWithReuseIdentifier: WaitCell.id)
    
    participateCollectionView.tag = 2
    participateCollectionView.delegate = self
    participateCollectionView.dataSource = self
    participateCollectionView.register(ParticipateCell.self,
                                       forCellWithReuseIdentifier: ParticipateCell.id)
    
    refuseCollectionView.tag = 3
    refuseCollectionView.delegate = self
    refuseCollectionView.dataSource = self
    refuseCollectionView.register(RefuseCell.self,
                                  forCellWithReuseIdentifier: RefuseCell.id)
  }
  
  // MARK: - 네비게이션바 재설정
  func redesignNavigationbar(){
    navigationItem.rightBarButtonItems = .none
    self.navigationItem.title = "참여자"
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
  }
  
  func waitButtonTapped(){
    waitButton.resetUnderline()

    self.refuseButton.removeUnderline()
    self.participateButton.removeUnderline()
    
    waitingCollectionView.isHidden = false
    participateCollectionView.isHidden = true
    refuseCollectionView.isHidden = true
  }
  
  func participateButtonTapped(){
    participateButton.resetUnderline()

    self.refuseButton.removeUnderline()
    self.waitButton.removeUnderline()
    
    waitingCollectionView.isHidden = true
    participateCollectionView.isHidden = false
    refuseCollectionView.isHidden = true
  }
  
  func refusetButtonTapped(){
    refuseButton.resetUnderline()

    self.waitButton.removeUnderline()
    self.participateButton.removeUnderline()
    
    waitingCollectionView.isHidden = true
    participateCollectionView.isHidden = true
    refuseCollectionView.isHidden = false
  }
}

// MARK: - CollectionView
extension CheckParticipantsVC: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath)  -> UICollectionViewCell {
    if collectionView.tag == 1 {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WaitCell.id,
                                                    for: indexPath) as! WaitCell
      cell.delegate = self
      return cell

    } else if collectionView.tag == 2{
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ParticipateCell.id,
                                                    for: indexPath) as! ParticipateCell
      return cell

    } else {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RefuseCell.id,
                                                    for: indexPath) as! RefuseCell
      return cell
    }
  }
}

// 셀의 각각의 크기
extension CheckParticipantsVC: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    if collectionView.tag == 1 {
      return CGSize(width: 350, height: 181)
    } else if collectionView.tag == 2 {
      return CGSize(width: 335, height: 86)
    } else {
      return CGSize(width: 335, height: 174)
    }
  }
}

// MARK: - bottomSheet
extension CheckParticipantsVC: ParticipantsCellDelegate {
  func refuseButtonTapped(in cell: WaitCell) {
    let bottomVC = RefuseBottomSheet()
    bottomVC.delegate = self
    
    if #available(iOS 15.0, *) {
      if let sheet = bottomVC.sheetPresentationController {
        if #available(iOS 16.0, *) {
          sheet.detents = [.custom(resolver: { context in
            return 387
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
    present(bottomVC, animated: true, completion: nil)
  }
  
  func acceptButtonTapped(in cell: WaitCell) {
    let popupVC = PopupViewController(title: "이 신청자를 수락할까요?",
                                      desc: "수락 후,취소가 어려워요",
                                      leftButtonTitle: "아니요",
                                      rightButtonTilte: "수락")
    popupVC.modalPresentationStyle = .overFullScreen
    self.present(popupVC, animated: false)
    
    popupVC.popupView.rightButtonAction = { [weak self] in
      guard let self = self else { return }
      print("수락탭")
      popupVC.dismiss(animated: true)
      self.showToast(message: "수락이 완료됐어요", alertCheck: true)
    }
  }
}

// MARK: - 거절(기타사유)로 할 경우 화면이동
extension CheckParticipantsVC: RefuseBottomSheetDelegate {
  func didTapRefuseButton(withReason reason: String) {
    let refuseWriteVC = WriteRefuseReasonVC()
    refuseWriteVC.delegate = self
    
    if let navigationController = self.navigationController {
      navigationController.pushViewController(refuseWriteVC, animated: true)
    } else {
      self.present(refuseWriteVC, animated: true, completion: nil)
    }
  }
}

extension CheckParticipantsVC: WriteRefuseReasonVCDelegate {
  func completeButtonTapped(reason: String) {
    print(reason)
    showToast(message: "거절이 완료됐어요", alertCheck: true)
  }
}
