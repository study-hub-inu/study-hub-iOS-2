import UIKit

import SnapKit

class DetailsViewController: UIViewController{
  
  // MARK: - 화면구성
  private let headerStackView: UIStackView = {
    let headerStackView = UIStackView()
    headerStackView.axis = .horizontal
    headerStackView.alignment = .center
    headerStackView.spacing = 8
    return headerStackView
  }()
  
  lazy var backButton: UIButton = {
    let backButton = UIButton(type: .system)
    backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
    backButton.tintColor = .white
    backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    return backButton
  }()
  
  private let spacerView: UIView = {
    let spacerView = UIView()
    spacerView.setContentHuggingPriority(.defaultLow, for: .horizontal)
    return spacerView
  }()
  
  private let howtouseLabel: UILabel = {
    // "이용방법" label
    let howtouseLabel = UILabel()
    howtouseLabel.text = "이용 방법"
    howtouseLabel.textColor = .white
    howtouseLabel.font = UIFont.boldSystemFont(ofSize: 18)
    return howtouseLabel
  }()
  
  private let headerContentStackView: UIStackView = {
    let headerContentStackView = UIStackView()
    headerContentStackView.axis = .vertical
    headerContentStackView.spacing = 0
    return headerContentStackView
  }()
  
  private let largeImageView: UIImageView = {
    let largeImageView = UIImageView(image: UIImage(named: "Image 6"))
    largeImageView.contentMode = .scaleAspectFill
    largeImageView.clipsToBounds = true
    return largeImageView
  }()
  
  private let largeImage2View: UIImageView = {
    let largeImageView = UIImageView(image: UIImage(named: "Image 8"))
    largeImageView.contentMode = .scaleAspectFill
    largeImageView.clipsToBounds = true
    return largeImageView
  }()
  
  private let largeImage3View: UIImageView = {
    let largeImageView = UIImageView(image: UIImage(named: "Image 9"))
    largeImageView.contentMode = .scaleAspectFill
    largeImageView.clipsToBounds = true
    return largeImageView
  }()
  
  private let largeImage4View: UIImageView = {
    let largeImageView = UIImageView(image: UIImage(named: "Image 10"))
    largeImageView.contentMode = .scaleAspectFill
    largeImageView.clipsToBounds = true
    return largeImageView
  }()
  
  private let largeImage5View: UIImageView = {
    let largeImageView = UIImageView(image: UIImage(named: "Image 11"))
    largeImageView.contentMode = .scaleAspectFill
    largeImageView.clipsToBounds = true
    return largeImageView
  }()
  
  private let largeImage6View: UIImageView = {
    let largeImageView = UIImageView(image: UIImage(named: "Image 12"))
    largeImageView.contentMode = .scaleAspectFill
    largeImageView.clipsToBounds = true
    return largeImageView
  }()
  
  private let largeImage7View: UIImageView = {
    let largeImageView = UIImageView(image: UIImage(named: "Image 13"))
    largeImageView.contentMode = .scaleAspectFill
    largeImageView.clipsToBounds = true
    return largeImageView
  }()
  private let largeImage8View: UIImageView = {
    let largeImageView = UIImageView(image: UIImage(named: "Image 14"))
    largeImageView.contentMode = .scaleAspectFill
    largeImageView.clipsToBounds = true
    return largeImageView
  }()
  
  lazy var writeButton: UIButton = {
    let writeButton = UIButton(type: .system)
    writeButton.setTitle("작성하기", for: .normal)
    writeButton.setTitleColor(.white, for: .normal)
    writeButton.backgroundColor = UIColor(hexCode: "FF5935")
    writeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    writeButton.layer.cornerRadius = 10
    writeButton.addTarget(self, action: #selector(writeButtonTapped), for: .touchUpInside)
    return writeButton
  }()
  
  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    return scrollView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpLayout()
    makeUI()
  }
  
  // MARK: - 함수
  func setUpLayout(){
    view.backgroundColor = .black
    view.addSubview(headerStackView)
    view.addSubview(scrollView)

    headerStackView.addArrangedSubview(backButton)
    headerStackView.addArrangedSubview(spacerView)
    headerStackView.addArrangedSubview(howtouseLabel)
    
    let imageViews = [largeImageView, largeImage2View, largeImage3View, largeImage4View,
                      largeImage5View, largeImage6View, largeImage7View, largeImage8View]
    for imageView in imageViews {
      headerContentStackView.addArrangedSubview(imageView)
    }
    headerContentStackView.addArrangedSubview(writeButton)
    
    scrollView.addSubview(headerContentStackView)
    scrollView.backgroundColor = .white
  }

  func makeUI(){
    headerStackView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.leading.equalTo(view).offset(16)
      make.trailing.equalTo(view).offset(-160)
    }
    
    headerContentStackView.snp.makeConstraints { make in
      make.top.equalTo(scrollView)
      make.leading.trailing.bottom.equalTo(scrollView)
      make.width.equalTo(scrollView)
    }
    
    largeImageView.snp.makeConstraints { make in
      make.height.equalTo(305)
      make.leading.trailing.equalTo(headerContentStackView)
    }
    
    largeImage2View.snp.makeConstraints { make in
      make.height.equalTo(650)
      make.leading.trailing.equalTo(headerContentStackView)
    }
    
    largeImage3View.snp.makeConstraints { make in
      make.height.equalTo(600)
      make.leading.trailing.equalTo(headerContentStackView)
    }
    
    largeImage4View.snp.makeConstraints { make in
      make.height.equalTo(900)
      make.leading.trailing.equalTo(headerContentStackView)
    }
    
    largeImage5View.snp.makeConstraints { make in
      make.height.equalTo(300)
      make.leading.trailing.equalTo(headerContentStackView)
    }
    
    largeImage6View.snp.makeConstraints { make in
      make.height.equalTo(400)
      make.leading.trailing.equalTo(headerContentStackView)
    }
    
    largeImage7View.snp.makeConstraints { make in
      make.height.equalTo(700)
      make.leading.trailing.equalTo(headerContentStackView)
    }
    
    largeImage8View.snp.makeConstraints { make in
      make.height.equalTo(250)
      make.leading.trailing.equalTo(headerContentStackView)
    }
    
    writeButton.snp.makeConstraints { make in
      make.centerX.equalTo(view)
      make.top.equalTo(largeImage8View.snp.bottom).offset(40)
      make.leading.equalTo(headerContentStackView).offset(20)
      make.trailing.equalTo(headerContentStackView)
      make.height.equalTo(55)
      make.width.equalTo(400)
    }
    
    scrollView.snp.makeConstraints { make in
      make.top.equalTo(headerStackView.snp.bottom).offset(16)
      make.leading.trailing.bottom.equalTo(view)
    }
    
  }
  @objc func goBack() {
    self.dismiss(animated: true, completion: nil)
  }
  
  @objc func writeButtonTapped() {
    let createStudyViewController = CreateStudyViewController()
    let navigationController = UINavigationController(rootViewController: createStudyViewController)
    navigationController.modalPresentationStyle = .fullScreen
    
    present(navigationController, animated: true, completion: nil)
  }
}
