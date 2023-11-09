import UIKit

import SnapKit

final class SignUpViewController: UIViewController {

  // MARK: - 화면구성
  private lazy var emailTextField: UITextField = {
    let emailTF = UITextField()
    emailTF.placeholder = "이메일을 입력하세요"
    emailTF.attributedPlaceholder = NSAttributedString(string: "@inu.ac.kr",
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    emailTF.textColor = .white
    emailTF.backgroundColor = .black
    emailTF.borderStyle = .roundedRect
    emailTF.translatesAutoresizingMaskIntoConstraints = false
    emailTF.addTarget(self,
                      action: #selector(emailTextFieldDidChange),
                      for: .editingChanged)
    emailTF.becomeFirstResponder()
    
    return emailTF
  }()
  
  private lazy var emailTextFielddividerLine: UIView = {
    let emailTFLine = UIView()
    emailTFLine.backgroundColor = .gray
    return emailTFLine
  }()
  
  private lazy var codesendLabel: UILabel = {
    let sendLabel = UILabel()
    sendLabel.text = "인증 코드를 메일로 보내드렸어요"
    sendLabel.font = UIFont.systemFont(ofSize: 14)
    sendLabel.textColor = .gray
    sendLabel.isHidden = true
    
    return sendLabel
  }()
  
  private lazy var verificationLabel : UILabel = {
    let label = UILabel()
    label.text = "인증코드"
    label.textColor = .white
    label.isHidden = true
    return label
  }()
  
  private lazy var verificationCodeTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "인증코드를 입력하세요"
    textField.attributedPlaceholder = NSAttributedString(string: "인증코드를 입력해주세요",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    textField.textColor = .white
    textField.backgroundColor = .black
    textField.borderStyle = .roundedRect
    textField.isHidden = true
    return textField
  }()
  
  private lazy var verificationCodedividerLine: UIView = {
    let line = UIView()
    line.backgroundColor = .gray
    line.isHidden = true
    return line
  }()
  
  private lazy var validButton: UIButton = {
    let validBtn = UIButton()
    validBtn.setTitle("인증", for: .normal)
    validBtn.setTitleColor(.white, for: .normal)
    validBtn.backgroundColor = UIColor(hexCode: "FF5935")
    validBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
    validBtn.layer.cornerRadius = 5
    validBtn.addTarget(self,
                       action: #selector(validButtonTapped),
                       for: .touchUpInside)
    return validBtn
  }()
  
  private lazy var titleLabel = createLabel(title: "회원가입",
                                               textColor: .white,
                                               fontSize: 22)
  
  private lazy var progressLabel = createLabel(title: "1/4",
                                               textColor: .gray,
                                               fontSize: 20)
  
  private lazy var emailPromptLabel = createLabel(title: "이메일을 입력해주세요",
                                               textColor: .white,
                                               fontSize: 22)

  private lazy var emailLabel = createLabel(title: "이메일",
                                               textColor: .white,
                                               fontSize: 18)

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
      emailPromptLabel,
      emailLabel,
      emailTextFielddividerLine,
      emailTextField,
      validButton,
      nextButton,
      codesendLabel,
      verificationLabel,
      verificationCodedividerLine,
      verificationCodeTextField
    ].forEach {
      view.addSubview($0)
    }
  }
  
  // MARK: - makeUI
  func makeUI(){
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).offset(-40)
      make.centerX.equalTo(view)
    }
    
    progressLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(50)
      make.trailing.equalTo(view).offset(-350)
    }
    
    emailPromptLabel.snp.makeConstraints { make in
      make.top.equalTo(progressLabel.snp.bottom).offset(10)
      make.leading.equalTo(view).offset(20)
    }
    
    emailLabel.snp.makeConstraints { make in
      make.top.equalTo(emailPromptLabel.snp.bottom).offset(80)
      make.leading.equalTo(view).offset(15)
    }
    
    emailTextField.snp.makeConstraints { make in
      make.top.equalTo(emailLabel.snp.bottom).offset(20)
      make.leading.equalTo(emailLabel)
      make.trailing.equalTo(view).offset(-70)
      make.height.equalTo(30)
    }
    
    validButton.snp.makeConstraints { make in
      make.leading.equalTo(emailTextField.snp.trailing).offset(10)
      make.centerY.equalTo(emailTextField)
      make.width.equalTo(50)
      make.height.equalTo(25)
    }
    
    emailTextFielddividerLine.snp.makeConstraints { make in
      make.leading.trailing.equalTo(view)
      make.top.equalTo(emailTextField.snp.bottom).offset(5)
      make.height.equalTo(1)
    }
    
    nextButton.snp.makeConstraints { make in
      make.centerX.equalTo(view)
      make.top.equalTo(emailTextFielddividerLine.snp.bottom).offset(350)
      make.height.equalTo(55)
      make.width.equalTo(400)
    }
    
    codesendLabel.snp.makeConstraints { make in
      make.top.equalTo(emailTextFielddividerLine.snp.bottom).offset(5)
      make.leading.equalTo(view).offset(15)
    }
    
    verificationLabel.snp.makeConstraints { make in
      make.top.equalTo(emailTextFielddividerLine.snp.bottom).offset(50)
      make.leading.equalTo(view).offset(15)
    }
    
    verificationCodeTextField.snp.makeConstraints { make in
      make.top.equalTo(verificationLabel.snp.bottom).offset(20)
      make.leading.equalTo(view).offset(15)
      make.trailing.equalTo(view).offset(-70)
      make.height.equalTo(30)
    }
    
    verificationCodedividerLine.snp.makeConstraints { make in
      make.leading.trailing.equalTo(view)
      make.top.equalTo(verificationCodeTextField.snp.bottom).offset(5)
      make.height.equalTo(1)
    }
  }
  
  // MARK: - 유효성 검사 함수
  @objc func validButtonTapped() {
    if let email = emailTextField.text {
      guard let duplicationURL = URL(string: "https://study-hub.site:443/api/email/duplication") else { return }
      
      let duplicationJSONData: [String: Any] = ["email": email]
      guard let duplicationData = try? JSONSerialization.data(withJSONObject: duplicationJSONData) else {
        return
      }
      
      var duplicationRequest = URLRequest(url: duplicationURL)
      duplicationRequest.httpMethod = "POST"
      duplicationRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
      duplicationRequest.httpBody = duplicationData
      
      let duplicationTask = URLSession.shared.dataTask(with: duplicationRequest) { [weak self] data, response, error in
        if let error = error {
          print("Error: \(error)")
          return
        }
        
        // Handle the duplication check response
        if let httpResponse = response as? HTTPURLResponse {
          if httpResponse.statusCode == 200 {
            // Duplication check passed, now send email to the main endpoint
            
            // Create a URL for sending the email
            guard let emailURL = URL(string: "https://study-hub.site:443/api/email") else {
              return
            }
            
            // Prepare JSON data for sending email
            let emailJSONData: [String: Any] = ["email": email]
            guard let emailData = try? JSONSerialization.data(withJSONObject: emailJSONData) else {
              return
            }
            
            // Configure the email sending request
            var emailRequest = URLRequest(url: emailURL)
            emailRequest.httpMethod = "POST"
            emailRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            emailRequest.httpBody = emailData
            
            // Create a URLSessionDataTask for sending email
            let emailTask = URLSession.shared.dataTask(with: emailRequest) { emailData, emailResponse, emailError in
              if let emailError = emailError {
                print("Email Sending Error: \(emailError)")
                return
              }
              
              // Handle the email sending response if needed
              if let emailData = emailData {
                if let emailResponseJSON = try? JSONSerialization.jsonObject(with: emailData, options: []) as? [String: Any] {
                  print("Email Sending Response JSON: \(emailResponseJSON)")
                }
              }
            }
            
            // Start the email sending data task
            emailTask.resume()
            
            // Show verification UI when validButton is tapped
            DispatchQueue.main.async {
              self?.codesendLabel.isHidden = false
              self?.verificationLabel.isHidden = false
              self?.verificationCodeTextField.isHidden = false
              self?.verificationCodedividerLine.isHidden = false
            }
          } else {
            // Duplication check failed, show an alert
            // 중복되지 않아도 중복이라고 표시
            DispatchQueue.main.async {
              self?.alertShow(title: "경고", message: "중복된 이메일입니다. 다시 입력해주세요.")
            }
          }
        }
      }
      
      // Start the duplication check data task
      duplicationTask.resume()
    }
  }
  
  // MARK: - 이메일 유효성 검사 함수
  @objc func emailTextFieldDidChange() {
    if let email = emailTextField.text {
      // Check if the entered email follows the '@inu.ac.kr' format
      let isValidEmail = email.hasSuffix("@inu.ac.kr")
      
      // Change the color of the emailTextFielddividerLine based on the validation result
      emailTextFielddividerLine.backgroundColor = isValidEmail ? .green : .red
      
    }
  }
  // MARK: - 다음 화면으로 이동하는 함수
  @objc func nextButtonTapped() {
    guard let email = emailTextField.text, !email.isEmpty else {
      // Change the color of emailTextFielddividerLine to red
      emailTextFielddividerLine.backgroundColor = .red
  
      alertShow(title: "경고", message: "이메일을 입력해주세요.")
      return
    }
    
    guard let authCode = verificationCodeTextField.text, !authCode.isEmpty else {
      // Change the color of verificationCodedividerLine to red
      verificationCodedividerLine.backgroundColor = .red

      alertShow(title: "경고", message: "인증번호를 입력해주세요.")
      return
    }
    
    // Create a URL for verification
    guard let verificationURL = URL(string: "https://study-hub.site:443/api/email/valid") else {
      return
    }
    
    // Prepare JSON data for verification
    let verificationJSONData: [String: Any] = ["authCode": authCode, "email": email]
    guard let verificationData = try? JSONSerialization.data(withJSONObject: verificationJSONData) else {
      return
    }
    
    // Configure the verification request
    var verificationRequest = URLRequest(url: verificationURL)
    verificationRequest.httpMethod = "POST"
    verificationRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    verificationRequest.httpBody = verificationData
    
    // Create a URLSessionDataTask for verification
    let verificationTask = URLSession.shared.dataTask(with: verificationRequest) { data, response, error in
      if let error = error {
        print("Error: \(error)")
        return
      }
      
      // Handle the verification response
      if let data = data {
        if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
           let validResult = responseJSON["validResult"] as? Bool {
          DispatchQueue.main.async {
            if validResult {
              // Change the color of verificationCodedividerLine to green
              self.verificationCodedividerLine.backgroundColor = .green
              
              // 다음 뷰 컨트롤러로 이메일 전달
              let passwordVC = PasswordViewController()
              passwordVC.email = email

              self.navigationController?.pushViewController(passwordVC, animated: true)
            } else {
              // Change the color of verificationCodedividerLine to red
              self.verificationCodedividerLine.backgroundColor = .red
              
              self.alertShow(title: "경고", message: "인증번호가 맞지 않습니다.")
            }
          }
        }
      }
    }
    
    verificationTask.resume()
  }
}
