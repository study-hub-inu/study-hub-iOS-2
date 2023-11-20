//
//  SimilarPostCell.swift
//  STUDYHUB2
//
//  Created by 최용헌 on 2023/10/31.
//

import UIKit

import SnapKit
final class SimilarPostCell: UICollectionViewCell {
  
  static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
  
  var model: String? { didSet { bind() } }
  
  private lazy var majorLabel: UILabel = {
    let label = UILabel()
    label.text = " 세무회계학과 "
    label.textColor = .o50
    label.backgroundColor = .o10
    label.font = UIFont(name: "Pretendard", size: 12)
    return label
  }()
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "Pretendard", size: 16)
    return label
  }()
  
  private lazy var remainMemeber: UILabel = {
    let label = UILabel()
    label.textColor = .lightGray
    label.text = "4자리 남았어요"
    label.font = UIFont(name: "Pretendard", size: 14)
    return label
  }()
  
  private lazy var profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 15
    imageView.image = UIImage(named: "ProfileAvatar_small")
    imageView.contentMode = .left
    imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
    return imageView
  }()
  
  private lazy var writerMajorLabel: UILabel = {
    let label = UILabel()
    label.textColor = .lightGray
    label.backgroundColor = .bg30
    label.layer.cornerRadius = 10
    label.text = "정보통신공학과"
    label.font = UIFont(name: "Pretendard", size: 12)
    return label
  }()
   
  private lazy var nickNameLabel: UILabel = {
    let label = UILabel()
    label.textColor = .lightGray
    label.text = "비어있음"
    label.font = UIFont(name: "Pretendard", size: 12)
    return label
  }()
 
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubviews()
    
    configure()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  private func addSubviews() {
    [
      majorLabel,
      titleLabel,
      remainMemeber,
      profileImageView,
      writerMajorLabel,
      nickNameLabel
    ].forEach {
      addSubview($0)
    }
  }
  
  private func configure() {
    majorLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(10)
      make.leading.equalToSuperview().offset(10)
      make.height.equalTo(24)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(majorLabel.snp.bottom)
      make.leading.equalTo(majorLabel.snp.leading)
    }
    
    remainMemeber.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom)
      make.leading.equalTo(majorLabel.snp.leading)
    }
    
    profileImageView.snp.makeConstraints { make in
      make.top.equalTo(remainMemeber.snp.bottom).offset(20)
      make.leading.equalTo(majorLabel.snp.leading)
      make.bottom.equalToSuperview().offset(-10)
    }
    
    writerMajorLabel.snp.makeConstraints { make in
      make.top.equalTo(profileImageView.snp.top)
      make.leading.equalTo(profileImageView.snp.trailing).offset(10)
    }
    
    nickNameLabel.snp.makeConstraints { make in
      make.top.equalTo(writerMajorLabel.snp.bottom).offset(10)
      make.leading.equalTo(profileImageView.snp.trailing).offset(10)
    }
    
    backgroundColor = .white
    self.layer.borderWidth = 0.5
    self.layer.borderColor = UIColor.lightGray.cgColor
    self.layer.cornerRadius = 10
  }
  
  private func bind() {
    titleLabel.text = model
  }
  
}
