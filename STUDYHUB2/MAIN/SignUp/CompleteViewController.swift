import UIKit

import SnapKit

final class CompleteViewController: UIViewController {
  
  // MARK: - 화면구성

  
  private let imageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "Image 1"))
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private let congratsLabel: UILabel = {
    let congratsLabel = UILabel()
    congratsLabel.text = "가입을 축하드립니다!"
    congratsLabel.textColor = .white
    congratsLabel.font = UIFont.boldSystemFont(ofSize: 20)
    
    let attributedText = NSMutableAttributedString(string: "가입을 축하드립니다!")
    attributedText.addAttribute(.foregroundColor, value: UIColor(hexCode: "FF5935"), range: NSRange(location: 4, length: 2))
    congratsLabel.attributedText = attributedText
    return congratsLabel
  }()
  
  private let recruitLabel: UILabel = {
    // '지금 바로 스터디 팀원을 모집하여' Label
    let recruitLabel = UILabel()
    recruitLabel.text = "지금 바로 스터디 팀원을 모집하여 \n      함께 목표를 달성해 보세요!"
    recruitLabel.textColor = .gray
    recruitLabel.font = UIFont.boldSystemFont(ofSize: 14)
    recruitLabel.numberOfLines = 0
    return recruitLabel
  }()
  
  lazy var startButton: UIButton = {
    let startButton = UIButton(type: .system)
    startButton.setTitle("시작하기", for: .normal)
    startButton.setTitleColor(.white, for: .normal)
    startButton.backgroundColor = UIColor(hexCode: "FF5935")
    startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    startButton.addTarget(self,
                          action: #selector(startButtonTapped),
                          for: .touchUpInside)
    startButton.layer.cornerRadius = 10
    return startButton
  }()
  
  // MARK: - viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .black
    
    setUpLayout()
    makeUI()
  }
  
  // MARK: - setUpLayout
  func setUpLayout(){
    [

      imageView,
      congratsLabel,
      recruitLabel,
      startButton
    ].forEach {
      view.addSubview($0)
    }
  }
  
  // MARK: - makeUI
  func makeUI(){
    
    imageView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).offset(80)
      make.centerX.equalToSuperview()
      make.width.equalTo(280)
      make.height.equalTo(280)
    }
    
    congratsLabel.snp.makeConstraints { make in
      make.top.equalTo(imageView.snp.bottom).offset(10)
      make.centerX.equalToSuperview()
    }
    
      recruitLabel.snp.makeConstraints { make in
          make.top.equalTo(congratsLabel.snp.bottom).offset(20)
          make.centerX.equalToSuperview()
      }
    
    startButton.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
      make.height.equalTo(60)
      make.width.equalTo(400)
    }
  }
  
  // MARK: - 함수
  @objc func startButtonTapped() {
    let ViewController = LoginViewController()
    
    // Create a UINavigationController with HomeViewController as the root view controller
    let navigationController = UINavigationController(rootViewController: ViewController)
    navigationController.modalPresentationStyle = .fullScreen
    
    // Present the UINavigationController modally
    present(navigationController, animated: true, completion: nil)
  }
}
