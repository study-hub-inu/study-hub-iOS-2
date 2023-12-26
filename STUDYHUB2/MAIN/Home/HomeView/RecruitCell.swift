
import UIKit

import SnapKit

final class RecruitPostCell: UICollectionViewCell {
  
  static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
  
  var model: PostDataContent? { didSet { bind() } }
  
  private lazy var majorLabel: UILabel = {
    let label = UILabel()
    label.text = " 세무회계학과 "
    label.textColor = .o50
    label.backgroundColor = .o10
    label.layer.cornerRadius = 5
    return label
  }()
  
  private lazy var bookMarkButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "BookMarkLightImg"), for: .normal)
    return button
  }()
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "Pretendard", size: 14)
    label.textColor = .black
    return label
  }()
  
  private lazy var profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 15
    imageView.image = UIImage(named: "PersonImg")
    imageView.contentMode = .left
    imageView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
    return imageView
  }()
  
  private lazy var countMemeberLabel: UILabel = {
    let label = UILabel()
    label.textColor = .bg90
    label.text = "/14"
    return label
  }()
  
  private lazy var fineImageView = UIImageView(image:  UIImage(named: "MoneyImage"))
  
  private lazy var fineCountLabel: UILabel = {
    let label = UILabel()
    label.textColor = .bg90
    label.text = "900원"
    return label
  }()
  
  private lazy var remainMemeber: UILabel = {
    let label = UILabel()
    label.textColor = .bg80
    label.text = " 잔여 14자리 "
    label.layer.borderColor = UIColor.bg60.cgColor // 테두리 색상을 초기화 (투명)
    label.layer.borderWidth = 0.5 // 테두리 두께 초기화
    label.layer.cornerRadius = 5
    return label
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
      bookMarkButton,
      titleLabel,
      profileImageView,
      countMemeberLabel,
      fineImageView,
      fineCountLabel,
      remainMemeber,
    ].forEach {
      addSubview($0)
    }
  }
  
  private func configure() {
    majorLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(10)
      make.leading.equalToSuperview().offset(10)
    }
    
    bookMarkButton.snp.makeConstraints { make in
      make.centerY.equalTo(majorLabel)
      make.trailing.equalToSuperview().offset(-10)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(majorLabel.snp.bottom).offset(10)
      make.leading.equalTo(majorLabel.snp.leading)
    }
    
    profileImageView.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(20)
      make.leading.equalTo(majorLabel.snp.leading)
    }
    
    countMemeberLabel.snp.makeConstraints { make in
      make.leading.equalTo(profileImageView.snp.trailing)
      make.centerY.equalTo(profileImageView)
    }
    
    fineImageView.snp.makeConstraints { make in
      make.leading.equalTo(countMemeberLabel.snp.trailing).offset(50)
      make.centerY.equalTo(countMemeberLabel)
    }
    
    fineCountLabel.snp.makeConstraints { make in
      make.leading.equalTo(fineImageView.snp.trailing)
      make.centerY.equalTo(fineImageView)
    }
    
    remainMemeber.snp.makeConstraints { make in
      make.top.equalTo(profileImageView.snp.bottom).offset(20)
      make.leading.equalTo(majorLabel.snp.leading)
    }
    
    
    backgroundColor = .white
    
    self.layer.borderWidth = 0.1
    self.layer.borderColor = UIColor.cellShadow.cgColor
    self.layer.cornerRadius = 10
    
    fineCountLabel.changeColor(label: fineCountLabel, wantToChange: "900", color: .changeInfo)
    countMemeberLabel.changeColor(label: countMemeberLabel, wantToChange: "0", color: .changeInfo)
  }
  
  private func bind() {
    guard let data = model else { return }
    
    var studyPersonCount = data.studyPerson - data.remainingSeat
    
    majorLabel.text = data.major.convertMajor(data.major, isEnglish: false)
    titleLabel.text = data.title
    remainMemeber.text = "  잔여 \(data.remainingSeat)자리  "
    countMemeberLabel.text = "\(studyPersonCount) / \(data.studyPerson)"
    fineCountLabel.text = "\(data.penalty) 원"
  

    
    countMemeberLabel.changeColor(label: countMemeberLabel,
                                  wantToChange: "\(studyPersonCount)",
                                  color: .o50)
    fineCountLabel.changeColor(label: fineCountLabel,
                               wantToChange: "\(data.penalty)",
                               color: .o50)
    
  }
  
}


