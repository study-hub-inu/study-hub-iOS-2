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
    
  var eyeButton = UIButton(type: .custom)
  
  private let passwordTextFielddividerLine: UIView = {
    let passwordLine = UIView()
    passwordLine.backgroundColor = .gray
    passwordLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    return passwordLine
  }()
    
    private lazy var cannotuseLabel: UILabel = {
        let cannotuseLabel = UILabel()
        cannotuseLabel.text = "사용할 수 없는 비밀번호예요(10자리 이상, 특수문자 포함 필수)"
        cannotuseLabel.font = UIFont.systemFont(ofSize: 12)
        cannotuseLabel.textColor = .red
        cannotuseLabel.isHidden = true
        
        return cannotuseLabel
    }()
    
    private lazy var canuseLabel: UILabel = {
        let canuseLabel = UILabel()
        canuseLabel.text = "사용가능한 비밀번호예요"
        canuseLabel.font = UIFont.systemFont(ofSize: 12)
        canuseLabel.textColor = .green
        canuseLabel.isHidden = true
        
        return canuseLabel
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
    
    private lazy var pswdnotmatchLabel: UILabel = {
        let pswdnotmatchLabel = UILabel()
        pswdnotmatchLabel.text = "비밀번호가 일치하지 않아요"
        pswdnotmatchLabel.font = UIFont.systemFont(ofSize: 12)
        pswdnotmatchLabel.textColor = .red
        pswdnotmatchLabel.isHidden = true
        
        return pswdnotmatchLabel
    }()
    
    private lazy var pswdmatchLabel: UILabel = {
        let pswdmatchLabel = UILabel()
        pswdmatchLabel.text = "비밀번호가 확인되었어요"
        pswdmatchLabel.font = UIFont.systemFont(ofSize: 12)
        pswdmatchLabel.textColor = .green
        pswdmatchLabel.isHidden = true
        
        return pswdmatchLabel
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
  
  
  lazy var nextButton: UIButton = {
    let nextButton = UIButton(type: .system)
    nextButton.setTitle("다음", for: .normal)
    nextButton.setTitleColor(UIColor(hexCode: "#6F6F6F"), for: .normal)
    nextButton.backgroundColor = UIColor(hexCode: "#6F2B1C")
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
      
    if #available(iOS 15.0, *) {
      setPasswordShowButtonImage()
      setConfirmPasswordShowButtonImage()
    }
  }
  
    @available(iOS 15.0, *)
    func setPasswordShowButtonImage(){
      eyeButton = UIButton.init(primaryAction: UIAction(handler: { [self] _ in
        passwordTextField.isSecureTextEntry.toggle()
        self.eyeButton.isSelected.toggle()
      }))
      
      var buttonConfiguration = UIButton.Configuration.plain()
      buttonConfiguration.imagePadding = 10
      buttonConfiguration.baseBackgroundColor = .clear

      eyeButton.setImage(UIImage(named: "icon_eye_close_g80"), for: .normal)
      self.eyeButton.configuration = buttonConfiguration

      self.passwordTextField.rightView = eyeButton
      self.passwordTextField.rightViewMode = .always
    
    }
    
    @available(iOS 15.0, *)
    func setConfirmPasswordShowButtonImage(){
      eyeButton = UIButton.init(primaryAction: UIAction(handler: { [self] _ in
        confirmPasswordTextField.isSecureTextEntry.toggle()
        self.eyeButton.isSelected.toggle()
      }))
      
      var buttonConfiguration = UIButton.Configuration.plain()
      buttonConfiguration.imagePadding = 10
      buttonConfiguration.baseBackgroundColor = .clear

      eyeButton.setImage(UIImage(named: "icon_eye_close_g80"), for: .normal)
      self.eyeButton.configuration = buttonConfiguration

      self.confirmPasswordTextField.rightView = eyeButton
      self.confirmPasswordTextField.rightViewMode = .always
    
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
      eyeButton,
      cannotuseLabel,
      canuseLabel,
      confirmPasswordTextField,
      confirmPasswordTextFielddividerLine,
      pswdnotmatchLabel,
      pswdmatchLabel,
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
      make.trailing.equalTo(view.snp.trailing).offset(-20)
      make.height.equalTo(30)
    }
    
    eyeButton.snp.makeConstraints { make in
      make.trailing.equalTo(passwordTextFielddividerLine.snp.trailing)
    }
      
    // Divider line constraints
    passwordTextFielddividerLine.snp.makeConstraints { make in
      make.leading.trailing.equalTo(view)
      make.top.equalTo(passwordTextField.snp.bottom).offset(5)
      make.height.equalTo(1)
    }
      
      cannotuseLabel.snp.makeConstraints { make in
          make.top.equalTo(passwordTextFielddividerLine.snp.bottom).offset(5)
          make.leading.equalTo(view).offset(15)
      }
      
      canuseLabel.snp.makeConstraints { make in
          make.top.equalTo(passwordTextFielddividerLine.snp.bottom).offset(5)
          make.leading.equalTo(view).offset(15)
      }
    
    confirmPasswordTextField.snp.makeConstraints { make in
      make.top.equalTo(passwordTextFielddividerLine.snp.bottom).offset(50)
      make.leading.equalTo(view.snp.leading).offset(15)
      make.trailing.equalTo(view.snp.trailing).offset(-20)
      make.height.equalTo(30)
    }
      
      eyeButton.snp.makeConstraints { make in
        make.trailing.equalTo(confirmPasswordTextFielddividerLine.snp.trailing)
      }
    
    
    // Divider line constraints for confirmation password
    confirmPasswordTextFielddividerLine.snp.makeConstraints { make in
      make.leading.trailing.equalTo(view)
      make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(5)
      make.height.equalTo(1)
    }
      
      pswdnotmatchLabel.snp.makeConstraints { make in
          make.top.equalTo(confirmPasswordTextFielddividerLine.snp.bottom).offset(5)
          make.leading.equalTo(view).offset(15)
      }
      
      pswdmatchLabel.snp.makeConstraints { make in
          make.top.equalTo(confirmPasswordTextFielddividerLine.snp.bottom).offset(5)
          make.leading.equalTo(view).offset(15)
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
        
      passwordTextFielddividerLine.backgroundColor = .red
      return
    }
    
    guard let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
        
      confirmPasswordTextFielddividerLine.backgroundColor = .red
        return
    }
    
    if !validatePassword(password: password) {
      
      passwordTextFielddividerLine.backgroundColor = .red
      
      return
    }
    
    else {
      passwordTextFielddividerLine.backgroundColor = .green
      
    }
    
    // Check if passwords match
    if password != confirmPassword {
      
      confirmPasswordTextFielddividerLine.backgroundColor = .red
      return
    }
    
    // 다음 뷰 컨트롤러로 이메일과 비밀번호 전달
    let nicknameVC = NicknameViewController()
    
    nicknameVC.email = email
    nicknameVC.password = password
    navigationController?.pushViewController(nicknameVC, animated: true)
    
  }
  
  // Action for passwordTextField editingChanged event
  @objc func passwordTextFieldDidChange() {
    if let password = passwordTextField.text {
      // Check if the entered password meets the required criteria
      let isValidPassword = validatePassword(password: password)
      
      // Change the color of the passwordTextFielddividerLine based on the validation result
      passwordTextFielddividerLine.backgroundColor = isValidPassword ? .green : .red
        
        if isValidPassword {
            canuseLabel.isHidden = false
            cannotuseLabel.isHidden = true
        }else {
            canuseLabel.isHidden = true
            cannotuseLabel.isHidden = false
        }
    }
  }
  @objc func confirmPasswordTextFieldDidChange() {
      canuseLabel.isHidden = true
      passwordTextFielddividerLine.backgroundColor = .gray
    if let password = passwordTextField.text {
            guard let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
              // Change the color of confirmPasswordTextFielddividerLine to red
              confirmPasswordTextFielddividerLine.backgroundColor = .red
                pswdnotmatchLabel.isHidden = false
                pswdmatchLabel.isHidden = true
              return
            }
            // Check if passwords match
            if password != confirmPassword {
                pswdnotmatchLabel.isHidden = false
                pswdmatchLabel.isHidden = true
              // Change the color of confirmPasswordTextFielddividerLine to red
              confirmPasswordTextFielddividerLine.backgroundColor = .red
                nextButton.backgroundColor = UIColor(hexCode: "#6F2B1C")
                nextButton.setTitleColor(UIColor(hexCode: "#6F6F6F"), for: .normal)
              return
            }else{
                pswdnotmatchLabel.isHidden = true
                pswdmatchLabel.isHidden = false
                confirmPasswordTextFielddividerLine.backgroundColor = .green
                nextButton.backgroundColor = UIColor(hexCode: "#FF5530")
                nextButton.setTitleColor(UIColor(hexCode: "#FFFFFF"), for: .normal)
            }

    }
  }
  
  
}
