import UIKit
import SnapKit

protocol WriteRefuseReasonVCDelegate: AnyObject {
  func completeButtonTapped(reason: String)
}

final class WriteRefuseReasonVC: NaviHelper {
  weak var delegate: WriteRefuseReasonVCDelegate?
  
  private lazy var titleLabel: UILabel = {
    let label = createLabel(title: "해당 참여자를 거절하게 된 이유를 적어주세요 😢",
                            textColor: .black,
                            fontSize: 16)
    label.numberOfLines = 0
    return label
  }()
  
  private lazy var reasonTextView: UITextView = {
    let textView = UITextView()
    textView.text = "ex) 욕설 등의 부적절한 말을 사용했습니다, 저희 스터디와 맞지 않습니다"
    textView.textColor = .bg70
    textView.layer.cornerRadius = 10
    textView.layer.borderWidth = 1
    textView.layer.borderColor = UIColor.bg50.cgColor
    textView.font = UIFont.systemFont(ofSize: 16)
    textView.delegate = self
    return textView
  }()
  
  private lazy var countContentLabel: UILabel = {
    let label = UILabel()
    label.textColor = .bg70
    label.text = "0/200"
    return label
  }()
  
  private lazy var bottomLabel: UILabel = {
    let label = createLabel(title: "- 해당 내용은 사용자에게 전송돼요",
                            textColor: .bg60,
                            fontSize: 12)
    label.textAlignment = .center
    return label
  }()
  
  private lazy var completeButton: UIButton = {
    let button = UIButton()
    button.setTitle("완료", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = .o30
    button.titleLabel?.font = UIFont(name: "Pretendard", size: 16)
    button.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
    button.isEnabled = false // 초기에 비활성화 상태로 설정
    return button
  }()
  
  // MARK: - Lifecycle Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    
    navigationItemSetting()
    redesignNavigationbar()
  }
  
  // MARK: - UI Setup
  
  private func setupUI() {
    view.backgroundColor = .white
    
    [
      titleLabel,
      reasonTextView,
      countContentLabel,
      bottomLabel,
      completeButton
    ].forEach {
      view.addSubview($0)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
      $0.leading.equalToSuperview().offset(10)
      $0.trailing.equalToSuperview().offset(-10)
    }
    
    reasonTextView.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(10)
      $0.leading.equalToSuperview().offset(10)
      $0.trailing.equalToSuperview().offset(-10)
      $0.height.equalTo(186)
    }
    
    countContentLabel.snp.makeConstraints {
      $0.trailing.equalTo(reasonTextView)
      $0.top.equalTo(reasonTextView.snp.bottom)
    }
    
    completeButton.snp.makeConstraints {
      $0.bottom.equalToSuperview().offset(-30)
      $0.leading.equalToSuperview().offset(10)
      $0.trailing.equalToSuperview().offset(-10)
      $0.height.equalTo(55)
    }
    
    bottomLabel.snp.makeConstraints {
      $0.bottom.equalTo(completeButton.snp.top).offset(10)
      $0.leading.trailing.equalTo(completeButton)
    }
  }
  
  func redesignNavigationbar() {
    navigationItem.rightBarButtonItems = nil
    navigationItem.title = "거절사유"
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
  }
  
  // MARK: - Button Action
  @objc private func completeButtonTapped() {
    delegate?.completeButtonTapped(reason: reasonTextView.text)
    navigationController?.popViewController(animated: true)
  }
}

extension WriteRefuseReasonVC {
  override func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == UIColor.bg70 {
      textView.text = nil
      textView.textColor = UIColor.black
      textView.layer.borderColor = UIColor.black.cgColor
      
      completeButton.isEnabled = true
      completeButton.backgroundColor = .o50
    }
  }
  
  override func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = "ex) 욕설 등의 부적절한 말을 사용했습니다, 저희 스터디와 맞지 않습니다"
      textView.textColor = UIColor.bg70
      textView.layer.borderColor = UIColor.bg50.cgColor
      
      completeButton.isEnabled = false
      completeButton.backgroundColor = .o30
    }
  }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    let currentText = textView.text ?? ""
    guard let stringRange = Range(range, in: currentText) else { return false }
    
    let changedText = currentText.replacingCharacters(in: stringRange, with: text)
    
    countContentLabel.text = "\(changedText.count)/200"
    countContentLabel.changeColor(label: countContentLabel,
                                  wantToChange: changedText.count,
                                  color: .black)
    return changedText.count <= 199
  }
}
