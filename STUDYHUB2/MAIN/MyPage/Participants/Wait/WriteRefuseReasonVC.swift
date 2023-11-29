//
//  WriteRefuseReasonVC.swift
//  STUDYHUB2
//
//  Created by 최용헌 on 2023/11/29.
//

import UIKit

import SnapKit

protocol WriteRefuseReasonVCDelegate: AnyObject{
  func completeButtonTapped(reason: String)
}

final class WriteRefuseReasonVC: NaviHelper {
  weak var delegate: WriteRefuseReasonVCDelegate?
  
  private lazy var titlelabel = createLabel(title: "해당 참여자를 거절하게 된 이유를 적어주세요 😢",
                                            textColor: .black,
                                            fontSize: 16)
  
  private lazy var reasonTextView: UITextView = {
    let textView = UITextView()
    textView.text = "ex) 욕설 등의 부적절한 말을 사용했습니다, 저희 스터디와 맞지 않습니다"
    textView.textColor = .bg70
    textView.layer.cornerRadius = 10
    return textView
  }()
  
  private lazy var countContentLabel: UILabel = {
    let label = UILabel()
    label.textColor = .bg70
    label.text = "0/200"
    return label
  }()
  
  private lazy var bottomLabel = createLabel(title: "- 해당 내용은 사용자에게 전송돼요",
                                             textColor: .bg60,
                                             fontSize: 12)
  
  private lazy var completeButton: UIButton = {
    let button = UIButton()
    button.setTitle("완료", for: .normal)
    button.setTitleColor(UIColor.white, for: .normal)
    button.backgroundColor = .o30
    button.titleLabel?.font = UIFont(name: "Pretendard", size: 16)
    button.addAction(UIAction { _ in
      self.delegate?.completeButtonTapped(reason: self.reasonTextView.text)
    }, for: .touchUpInside)
    return button
  }()

  // MARK: - viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItemSetting()
    redesignNavigationbar()
    
    setupLayout()
    makeUI()
  }
  
  func redesignNavigationbar(){
    navigationItem.rightBarButtonItems = .none
    self.navigationItem.title = "거절사유"
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
  }
  
  func setupLayout(){
    [
      titlelabel,
      reasonTextView,
      countContentLabel,
      bottomLabel,
      completeButton
    ].forEach {
      view.addSubview($0)
    }
  }
  
  func makeUI(){
    titlelabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
      $0.leading.equalToSuperview().offset(10)
    }
    
    reasonTextView.snp.makeConstraints {
      $0.top.equalTo(titlelabel.snp.bottom).offset(10)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(186)
    }
    
    countContentLabel.snp.makeConstraints {
      $0.trailing.equalTo(reasonTextView)
      $0.top.equalTo(reasonTextView)
    }
    
    completeButton.snp.makeConstraints {
      $0.bottom.equalToSuperview().offset(-30)
      $0.leading.equalToSuperview().offset(10)
      $0.trailing.equalToSuperview().offset(-10)
      $0.height.equalTo(55)
    }
    
    bottomLabel.snp.makeConstraints {
      $0.bottom.equalTo(completeButton.snp.top).offset(10)
      $0.leading.equalTo(completeButton.snp.leading)
    }
  }
}

extension WriteRefuseReasonVC {
  override func textViewDidBeginEditing(_ textView: UITextView) {
    // TextColor로 처리합니다. text로 처리하게 된다면 placeholder와 같은걸 써버리면 동작이 이상하겠죠?
    if textView.textColor == UIColor.bg70 {
      textView.text = nil // 텍스트를 날려줌
      textView.textColor = UIColor.black
    }
  }
  // UITextView의 placeholder
  override func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = "ex) 욕설 등의 부적절한 말을 사용했습니다, 저희 스터디와 맞지 않습니다"
      textView.textColor = UIColor.bg70
    }
  }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    let currentText = textView.text ?? ""
    guard let stringRange = Range(range, in: currentText) else { return false }
    
    let changedText = currentText.replacingCharacters(in: stringRange, with: text)
    
    countContentLabel.text = "\(changedText.count)/200"
    return changedText.count <= 199
  }
}
