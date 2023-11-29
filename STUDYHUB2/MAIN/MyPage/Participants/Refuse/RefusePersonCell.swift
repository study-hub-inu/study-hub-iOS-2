
import UIKit

import SnapKit

final class RefusePersonCell: UICollectionViewCell {
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
  
  private lazy var refuseReasonTextView: UITextView = {
    let textView = UITextView()
    textView.text = "거절 사유\n이 스터디의 목표와 맞지 않아요"
    textView.textColor = .black
    textView.font = UIFont(name: "Pretendard", size: 14)
    return textView
  }()
  
 
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
      profileImageView,
      majorLabel,
      nickNameLabel,
      dateLabel,
      refuseReasonTextView
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
    
    refuseReasonTextView.snp.makeConstraints {
      $0.top.equalTo(profileImageView.snp.bottom).offset(10)
      $0.leading.equalTo(profileImageView)
    }
  }
}
