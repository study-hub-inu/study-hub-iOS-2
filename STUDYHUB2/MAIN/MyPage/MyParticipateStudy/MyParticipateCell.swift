//
//  MyParticipateCell.swift
//  STUDYHUB2
//
//  Created by 최용헌 on 2023/11/30.
//

import UIKit

import SnapKit

protocol MyParticipateCellDelegate: AnyObject {
  func deleteButtonTapped(in cell: MyParticipateCell, postID: Int)
}

final class MyParticipateCell: UICollectionViewCell {
  
  weak var delegate: MyParticipateCellDelegate?
  
  static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
  
  lazy var majorLabel: UILabel = {
    let label = UILabel()
    label.text = " 세무회계학과 "
    label.textColor = .o50
    label.layer.cornerRadius = 5
    return label
  }()
  
  private lazy var deleteButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "DeleteButtonImage"), for: .normal)
    button.addAction(UIAction { _ in
      self.deleteButtonTapped()
    }, for: .touchUpInside)
    return button
  }()
  
  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.text = "단기 스터디원 구해요!"
    label.textColor = .black
    label.font = UIFont.boldSystemFont(ofSize: 16)
    return label
  }()
  
  lazy var infoLabel: UILabel = {
    let label = UILabel()
    label.text = "내용내용내용"
    label.textColor = .bg80
    label.font = UIFont.systemFont(ofSize: 14)
    return label
  }()

  private lazy var seperateLine = UIView()

  private lazy var moveToChat: UIButton = {
    let button = UIButton()
    button.setTitle("채팅방으로 이동하기", for: .normal)
    button.setTitleColor(UIColor.bg80, for: .normal)
    button.titleLabel?.textAlignment = .center
    button.addAction(UIAction { _ in
    
    }, for: .touchUpInside)
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setViewShadow(backView: self)
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
      deleteButton,
      titleLabel,
      infoLabel,
      seperateLine,
      moveToChat
    ].forEach {
      addSubview($0)
    }
  }
  
  private func configure() {
    majorLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(20)
      $0.leading.equalToSuperview().offset(10)
    }
    
    deleteButton.snp.makeConstraints {
      $0.centerY.equalTo(majorLabel)
      $0.trailing.equalToSuperview().offset(-10)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(majorLabel.snp.bottom).offset(20)
      $0.leading.equalTo(majorLabel.snp.leading)
    }
    
    infoLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(10)
      $0.leading.equalTo(majorLabel.snp.leading)
      $0.trailing.equalToSuperview().offset(-10)
    }
  
    seperateLine.backgroundColor = .bg30
    seperateLine.snp.makeConstraints {
      $0.top.equalTo(infoLabel.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(1)
    }
    
    moveToChat.snp.makeConstraints {
      $0.top.equalTo(seperateLine.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(48)
    }
  
    backgroundColor = .white
    
    self.layer.borderWidth = 0.1
    self.layer.borderColor = UIColor.white.cgColor
    self.layer.cornerRadius = 10
  }
  
  func deleteButtonTapped(){
    self.delegate?.deleteButtonTapped(in: self, postID: 0)
  }
}

