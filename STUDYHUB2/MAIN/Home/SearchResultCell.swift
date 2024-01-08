
import UIKit

import SnapKit

final class SearchResultCell: UICollectionViewCell {
  
  static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
  
  var model: Content? { didSet { bind() } }
  
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
    label.text = "단기 스터디원 구해요!"
    label.textColor = .black
    label.font = UIFont.boldSystemFont(ofSize: 16)
    return label
  }()
  
  private lazy var periodLabel: UILabel = {
    let label = UILabel()
    label.text = "9월 10일 ~ 10월 10일"
    label.textColor = .bg80
    return label
  }()
  
  private lazy var remainLabel: UILabel = {
    let label = UILabel()
    label.text = "1자리 남았어요"
    label.textColor = .o50
    label.font = UIFont.boldSystemFont(ofSize: 14)
    return label
  }()
  
  private lazy var memberCountImage: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "MemberNumberImage")
    return imageView
  }()
  
  private lazy var memberCountLabel: UILabel = {
    let label = UILabel()
    label.text = "10/20명"
    label.changeColor(label: label, wantToChange: "10", color: .changeInfo)
    return label
  }()
  
  private lazy var memberStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 5
    return stackView
  }()
  
  private lazy var fineImage: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "MoneyImage")
    return imageView
  }()
  
  private lazy var fineLabel: UILabel = {
    let label = UILabel()
    label.text = "400원"
    return label
  }()
  
  private lazy var fineStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 5
    return stackView
  }()
  
  private lazy var genderImage: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "GenderMixImg")
    return imageView
  }()
  
  private lazy var genderLabel: UILabel = {
    let label = UILabel()
    label.text = "무관"
    return label
  }()
  
  private lazy var genderStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 5
    return stackView
  }()
  
  private lazy var infoStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.spacing = 10
    return stackView
  }()
  
  private lazy var profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 48
    imageView.clipsToBounds = true
    imageView.image = UIImage(named: "ProfileAvatar_change")
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private lazy var nickNameLabel: UILabel = {
    let label = UILabel()
    label.text = "학생"
    label.textColor = .bg90
    label.font = UIFont.systemFont(ofSize: 14)
    return label
  }()
  
  private lazy var postedDate: UILabel = {
    let label = UILabel()
    label.text = "2023.9.1"
    label.textColor = .bg70
    label.font = UIFont.systemFont(ofSize: 14)
    return label
  }()
  
  private lazy var countMemeberLabel: UILabel = {
    let label = UILabel()
    label.textColor = .bg90
    label.text = "0/14"
    label.changeColor(label: label, wantToChange: "0", color: .changeInfo)
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
    memberStackView.alignment = .center
    memberStackView.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    memberStackView.isLayoutMarginsRelativeArrangement = true
    
    let memeberData = [memberCountImage, countMemeberLabel]
    for data in memeberData {
      memberStackView.addArrangedSubview(data)
    }
    
    fineStackView.alignment = .center
    fineStackView.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    fineStackView.isLayoutMarginsRelativeArrangement = true
    
    let fineData = [fineImage, fineLabel]
    for data in fineData {
      fineStackView.addArrangedSubview(data)
    }
    
    genderStackView.alignment = .center
    genderStackView.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    genderStackView.isLayoutMarginsRelativeArrangement = true
    
    let genderData = [genderImage, genderLabel]
    for data in genderData {
      genderStackView.addArrangedSubview(data)
    }
    
    infoStackView.backgroundColor = .bg20
    infoStackView.distribution = .fillEqually
    infoStackView.layer.cornerRadius = 10
    
    let infoData = [memberStackView, fineStackView, genderStackView]
    for data in infoData {
      infoStackView.addArrangedSubview(data)
    }
    
    [
      majorLabel,
      bookMarkButton,
      titleLabel,
      periodLabel,
      remainLabel,
      infoStackView,
      profileImageView,
      nickNameLabel,
      postedDate,
    ].forEach {
      addSubview($0)
    }
  }
  
  private func configure() {
    majorLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(20)
      make.top.equalToSuperview().offset(10)
    }
    
    bookMarkButton.snp.makeConstraints { make in
      make.top.equalTo(majorLabel)
      make.trailing.equalToSuperview().offset(-10)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(majorLabel.snp.bottom).offset(10)
      make.leading.equalTo(majorLabel)
    }
    
    periodLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(10)
      make.leading.equalTo(majorLabel)
    }
    
    remainLabel.snp.makeConstraints { make in
      make.top.equalTo(periodLabel)
      make.trailing.equalToSuperview().offset(-20)
    }
    
    infoStackView.snp.makeConstraints { make in
      make.top.equalTo(periodLabel.snp.bottom).offset(10)
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
    }
    
    profileImageView.snp.makeConstraints { make in
      make.top.equalTo(infoStackView.snp.bottom).offset(20)
      make.leading.equalTo(majorLabel)
      make.height.width.equalTo(34)
      
    }
    
    nickNameLabel.snp.makeConstraints { make in
      make.leading.equalTo(profileImageView.snp.trailing).offset(20)
      make.top.equalTo(profileImageView.snp.top)
    }
    
    postedDate.snp.makeConstraints { make in
      make.leading.equalTo(profileImageView.snp.trailing).offset(20)
      make.top.equalTo(nickNameLabel.snp.bottom)
    }
    
    backgroundColor = .white
    
    self.layer.borderWidth = 0.1
    self.layer.borderColor = UIColor.cellShadow.cgColor
    self.layer.cornerRadius = 10
  }
  
  private func bind() {
    //    titleLabel.text = model
    guard let data = model else { return }
    
    var countMember = data.studyPerson - data.remainingSeat
    majorLabel.text = " \(data.major.convertMajor(data.major, isEnglish: false)) "
    titleLabel.text = data.title
    periodLabel.text = "\(data.studyStartDate[1])월 \(data.studyStartDate[2])일 ~\(data.studyEndDate[1])월 \(data.studyEndDate[2])일 "
    
    remainLabel.text = "\(data.remainingSeat)자리 남았어요"
    countMemeberLabel.text = "\(countMember) / \(data.studyPerson)"
    countMemeberLabel.changeColor(label: countMemeberLabel,
                                  wantToChange: "\(countMember)",
                                  color: .o50)
    
    fineLabel.text = "\(data.penalty)원"
    
    genderLabel.text = "  \(data.filteredGender)  "
    
    nickNameLabel.text = data.userData.nickname
    postedDate.text = "\(data.createdDate[0]).\(data.createdDate[1]).\(data.createdDate[2])"
    
    if let url = URL(string: data.userData.imageURL) {
      let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
          print("Error: \(error)")
        } else if let data = data {
          let image = UIImage(data: data)
          DispatchQueue.main.async {
            // 다운로드한 이미지를 이미지 뷰에 설정합니다.
            self.profileImageView.layer.cornerRadius = 15
            self.profileImageView.image = image
          }
        }
      }
      task.resume()
    }
    
  }
}
