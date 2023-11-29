//
//  WaitCell.swift
//  STUDYHUB2
//
//  Created by 최용헌 on 2023/11/29.
//

import UIKit

import SnapKit

final class WaitCell: UICollectionViewCell {
  static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }

  private lazy var profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "ProfileAvatar_change")
    return imageView
  }()
  
  private lazy var majorLabel: UILabel = {
    let label = UILabel()
    label.text = "경영학부"
    label.textColor = .bg80
    label.font = UIFont(name: "Pretendard", size: 12)
    return label
  }()
  
  private lazy var nickNameLabel: UILabel = {
    let label = UILabel()
    label.text = "경영이"
    label.textColor = .black
    label.font = UIFont(name: "Pretendard", size: 14)
    return label
  }()
  
  private lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.text = "2023. 9 . 8 신청 "
    label.textColor = .bg70
    label.font = UIFont(name: "Pretendard", size: 12)
    return label
  }()
  
  private lazy var describeTextView: UITextView = {
    let textView = UITextView()
    textView.textColor = .bg80
    textView.backgroundColor = .bg20
    textView.text = "안녕하세요, 저는 경영학부에 재학 중입니다. 지각이나 잠수 없이 열심히 참여하겠습니다. 잘 부탁드립니다 :)"
    return textView
  }()
  
  private lazy var lineView = UIView()
  
  private lazy var buttonStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.spacing = 10
    return stackView
  }()
  
  private lazy var refuseButton: UIButton = {
    let button = UIButton()
    button.setTitle("거절", for: .normal)
    button.setTitleColor(UIColor.bg80, for: .normal)
    button.addAction(UIAction { _ in
      print("거절")
    }, for: .touchUpInside)
    return button
  }()
  
  private lazy var acceptButton: UIButton = {
    let button = UIButton()
    button.setTitle("수락", for: .normal)
    button.setTitleColor(UIColor.g10, for: .normal)
    button.addAction(UIAction { _ in
      print("수락")
    }, for: .touchUpInside)
    return button
  }()
  
  private lazy var buttonLineView = UIView()
  
  // MARK: - init
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setViewShadow(backView: self)
    
    setupLayout()
    makeUI()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  // MARK: - setupLayout
  func setupLayout(){
    [
      refuseButton,
      buttonLineView,
      acceptButton
    ].forEach {
      buttonStackView.addArrangedSubview($0)
    }
    
    [
      profileImageView,
      majorLabel,
      nickNameLabel,
      dateLabel,
      describeTextView,
      lineView,
      buttonStackView
    ].forEach {
      addSubview($0)
    }
  }
  
  // MARK: - makeUI
  func makeUI(){
    profileImageView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
      $0.leading.equalToSuperview()
    }
    
    majorLabel.snp.makeConstraints {
      $0.top.equalTo(profileImageView)
      $0.leading.equalTo(profileImageView.snp.trailing)
    }
    
    nickNameLabel.snp.makeConstraints {
      $0.top.equalTo(majorLabel.snp.bottom)
      $0.leading.equalTo(majorLabel)
    }
    
    dateLabel.snp.makeConstraints {
      $0.top.equalTo(nickNameLabel.snp.bottom)
      $0.leading.equalTo(majorLabel)
    }
    
    describeTextView.snp.makeConstraints {
      $0.top.equalTo(profileImageView.snp.bottom).offset(10)
      $0.leading.equalTo(profileImageView)
    }
    
    lineView.snp.makeConstraints {
      $0.top.equalTo(describeTextView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
    }
    
    buttonLineView.snp.makeConstraints {
      $0.height.equalTo(5)
      $0.width.equalTo(1)
    }
    
    buttonStackView.distribution = .fillProportionally
    buttonStackView.snp.makeConstraints {
      $0.top.equalTo(lineView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalToSuperview()
    }
  
  }
}
