import UIKit

import SnapKit

final class PasswordViewController: UIViewController {
  
  var email: String?
  var password: String?
  
  // MARK: - 화면구성
  lazy var passwordTextField: UITextField = {
    let passwordTF = UITextField()
    passwordTF.placeholder = "비밀번호를 입력하세요"
    passwordTF.attributedPlaceholder = NSAttributedString(string: "비밀번호를 입력해주세요",
                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    passwordTF.textColor = .white
    passwordTF.backgroundColor = .black
    passwordTF.borderStyle = .roundedRect
    passwordTF.addTarget(self,
                         action: #selector(passwordTextFieldDidChange),
                         for: .editingChanged)
    passwordTF.isSecureTextEntry = true
    passwordTF.becomeFirstResponder()
    return passwordTF
  }()
  
  private let passwordTextFielddividerLine: UIView = {
    let passwordLine = UIView()
    passwordLine.backgroundColor = .gray
    return passwordLine
  }()
  
  lazy var confirmPasswordTextField: UITextField = {
    let confirmTF = UITextField()
    confirmTF.placeholder = "비밀번호를 한 번 더 입력해주세요"
    confirmTF.attributedPlaceholder = NSAttributedString(string: "비밀번호를 한 번 더 입력해주세요",
                                                         attributes:[NSAttributedString.Key.foregroundColor: UIColor.gray])
    confirmTF.textColor = .white
    confirmTF.backgroundColor = .black
    confirmTF.borderStyle = .roundedRect
    confirmTF.addTarget(self,
                        action:#selector(confirmPasswordTextFieldDidChange),
                        for: .editingChanged)
    confirmTF.becomeFirstResponder()
    confirmTF.isSecureTextEntry = true
    return confirmTF
  }()
  
  private let confirmPasswordTextFielddividerLine: UIView = {
    let line = UIView()
    line.backgroundColor = .gray
    return line
  }()
  
  private let titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.text = "회원가입"
    titleLabel.textColor = .white
    titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
    return titleLabel
  }()
  
  private let progressLabel: UILabel = {
    let progressLabel = UILabel()
    progressLabel.text = "2/4"
    progressLabel.textColor = .gray
    progressLabel.font = UIFont.boldSystemFont(ofSize: 20)
    return progressLabel
  }()
  
  private let passwordPromptLabel: UILabel = {
    let passwordPromptLabel = UILabel()
    passwordPromptLabel.text = "비밀번호를 설정해주세요"
    passwordPromptLabel.textColor = .white
    passwordPromptLabel.font = UIFont.boldSystemFont(ofSize: 22)
    return passwordPromptLabel
  }()
  
  private let passwordRequirementLabel: UILabel = {
    let passwordRequirementLabel = UILabel()
    passwordRequirementLabel.text = "10자리 이상, 특수문자 포함(!,@,#,$,%,^,&,*,?,~,_)이 필수에요"
    passwordRequirementLabel.textColor = .gray
    passwordRequirementLabel.font = UIFont.systemFont(ofSize: 13)
    return passwordRequirementLabel
  }()
  
  private let passwordLabel: UILabel = {
    let passwordLabel = UILabel()
    passwordLabel.text = "비밀번호"
    passwordLabel.textColor = .white
    return passwordLabel
  }()
  
  lazy var confirmButton: UIButton = {
    let confirmButton = UIButton(type: .system)
    confirmButton.setTitle("확인", for: .normal)
    confirmButton.setTitleColor(UIColor(hexCode: "FF5935"),
                                for: .normal)
    confirmButton.backgroundColor = .black
    confirmButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    confirmButton.layer.cornerRadius = 10
    confirmButton.layer.borderColor = UIColor(hexCode: "FF5935").cgColor
    confirmButton.layer.borderWidth = 1.0 // Set the border width
    confirmButton.addTarget(self,
                            action: #selector(confirmButtonTapped),
                            for: .touchUpInside)
    return confirmButton
  }()
  
  lazy var nextButton: UIButton = {
    let nextButton = UIButton(type: .system)
    nextButton.setTitle("다음", for: .normal)
    nextButton.setTitleColor(.white, for: .normal)
    nextButton.backgroundColor = UIColor(hexCode: "FF5935")
    nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    nextButton.layer.cornerRadius = 10
    nextButton.addTarget(self,
                         action: #selector(nextButtonTapped),
                         for: .touchUpInside)
    return nextButton
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .black
    
    setUpLayout()
    makeUI()
  }
  
  // MARK: - setUpLayout
  func setUpLayout(){
    [
      titleLabel,
      progressLabel,
      passwordPromptLabel,
      passwordRequirementLabel,
      passwordLabel,
      passwordTextFielddividerLine,
      passwordTextField,
      confirmPasswordTextField,
      confirmPasswordTextFielddividerLine,
      confirmButton,
      nextButton
    ].forEach {
      view.addSubview($0)
    }
  }
  
  // MARK: - makeUI
  func makeUI(){
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-40)
      make.centerX.equalToSuperview()
    }
    
    progressLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(50)
      make.trailing.equalTo(view.snp.trailing).offset(-350)
    }
    
    passwordPromptLabel.snp.makeConstraints { make in
      make.top.equalTo(progressLabel.snp.bottom).offset(10)
      make.leading.equalTo(view.snp.leading).offset(20)
    }
    
    passwordRequirementLabel.snp.makeConstraints { make in
      make.top.equalTo(progressLabel.snp.bottom).offset(40)
      make.leading.equalTo(view.snp.leading).offset(20)
    }
    
    passwordLabel.snp.makeConstraints { make in
      make.top.equalTo(passwordPromptLabel.snp.bottom).offset(80)
      make.leading.equalTo(view.snp.leading).offset(15)
    }
    
    passwordTextField.snp.makeConstraints { make in
      make.top.equalTo(passwordLabel.snp.bottom).offset(20)
      make.leading.equalTo(passwordLabel.snp.leading)
      make.trailing.equalTo(view.snp.trailing).offset(-70)
      make.height.equalTo(30)
    }
    
    // Divider line constraints
    passwordTextFielddividerLine.snp.makeConstraints { make in
      make.leading.trailing.equalTo(view)
      make.top.equalTo(passwordTextField.snp.bottom).offset(5)
      make.height.equalTo(1)
    }
    
    confirmPasswordTextField.snp.makeConstraints { make in
      make.top.equalTo(passwordTextFielddividerLine.snp.bottom).offset(50)
      make.leading.equalTo(view.snp.leading).offset(15)
      make.trailing.equalTo(view.snp.trailing).offset(-70)
      make.height.equalTo(30)
    }
    
    // Divider line constraints for confirmation password
    confirmPasswordTextFielddividerLine.snp.makeConstraints { make in
      make.leading.trailing.equalTo(view)
      make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(5)
      make.height.equalTo(1)
    }
    
    confirmButton.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(confirmPasswordTextFielddividerLine.snp.bottom).offset(50)
      make.height.equalTo(55)
      make.width.equalTo(380)
    }
    
    nextButton.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(passwordTextFielddividerLine.snp.bottom).offset(350)
      make.height.equalTo(55)
      make.width.equalTo(400)
    }
    
  }
  
  // MARK: - 함수
  func validatePassword(password: String) -> Bool {
    let passwordRegex = "(?=.*[a-zA-Z0-9])(?=.*[^a-zA-Z0-9]).{10,}"
    return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    // Change the color of the emailTextFielddividerLine based on the validation result
  }
  
  
  @objc func nextButtonTapped() {
    guard let password = passwordTextField.text, !password.isEmpty else {
      // Change the color of passwordTextFielddividerLine to red
      passwordTextFielddividerLine.backgroundColor = .red
      
      let alert = UIAlertController(title: "경고",
                                    message: "비밀번호를 입력해주세요.",
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
      present(alert, animated: true, completion: nil)
      
      
      return
    }
    
    guard let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
      // Change the color of confirmPasswordTextFielddividerLine to red
      confirmPasswordTextFielddividerLine.backgroundColor = .red
      
      let alert = UIAlertController(title: "경고",
                                    message: "비밀번호를 한번 더 입력해주세요.",
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
      present(alert, animated: true, completion: nil)
      return
    }
    
    if !validatePassword(password: password) {
      
      let alert = UIAlertController(title: "경고",
                                    message: "비밀번호는 10자리 이상이거나 특수문자를 포함해야 합니다.",
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
      present(alert, animated: true, completion: nil)
      
      // Change the color of passwordTextFielddividerLine to red
      passwordTextFielddividerLine.backgroundColor = .red
      
      return
    }
    
    else {
      passwordTextFielddividerLine.backgroundColor = .green
      
    }
    
    // Check if passwords match
    if password != confirmPassword {
      let alert = UIAlertController(title: "경고",
                                    message: "비밀번호가 일치하지 않습니다.",
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
      present(alert, animated: true, completion: nil)
      
      confirmPasswordTextFielddividerLine.backgroundColor = .red
      return
    }
    
    // 다음 뷰 컨트롤러로 이메일과 비밀번호 전달
    let nicknameVC = NicknameViewController()
    
    nicknameVC.email = email
    nicknameVC.password = password
    navigationController?.pushViewController(nicknameVC, animated: true)
    
  }
  @objc func confirmButtonTapped() {
    guard let password = passwordTextField.text, !password.isEmpty else {
      // Change the color of passwordTextFielddividerLine to red
      passwordTextFielddividerLine.backgroundColor = .red
      
      let alert = UIAlertController(title: "경고",
                                    message: "비밀번호를 입력해주세요.",
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
      present(alert, animated: true, completion: nil)
      return
    }
    
    if !validatePassword(password: password) {
      let alert = UIAlertController(title: "경고",
                                    message: "비밀번호는 10자리 이상이거나 특수문자를 포함해야 합니다.",
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
      present(alert, animated: true, completion: nil)
      
      // Change the color of passwordTextFielddividerLine to red
      passwordTextFielddividerLine.backgroundColor = .red
      return
    }
    
    passwordTextFielddividerLine.backgroundColor = .green
    
    guard let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
      // Change the color of confirmPasswordTextFielddividerLine to red
      confirmPasswordTextFielddividerLine.backgroundColor = .red
      
      let alert = UIAlertController(title: "경고",
                                    message: "비밀번호를 한번 더 입력해주세요.",
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
      present(alert, animated: true, completion: nil)
      return
    }
    
    
    confirmPasswordTextFielddividerLine.backgroundColor = .green
    
    // Check if passwords match
    if password != confirmPassword {
      let alert = UIAlertController(title: "경고",
                                    message: "비밀번호가 일치하지 않습니다.",
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
      present(alert, animated: true, completion: nil)
      
      // Change the color of confirmPasswordTextFielddividerLine to red
      confirmPasswordTextFielddividerLine.backgroundColor = .red
      return
    }
  }
  
  // Action for passwordTextField editingChanged event
  @objc func passwordTextFieldDidChange() {
    if let password = passwordTextField.text {
      // Check if the entered password meets the required criteria
      let isValidPassword = validatePassword(password: password)
      
      // Change the color of the passwordTextFielddividerLine based on the validation result
      passwordTextFielddividerLine.backgroundColor = isValidPassword ? .green : .red
    }
  }
  @objc func confirmPasswordTextFieldDidChange() {
    if let password = confirmPasswordTextField.text {
      // Check if the entered password meets the required criteria
      let isValidPassword = validatePassword(password: password)
      
      // Change the color of the passwordTextFielddividerLine based on the validation result
      confirmPasswordTextFielddividerLine.backgroundColor = isValidPassword ? .green : .red
    }
  }
  
  
}
