import UIKit

import SnapKit

final class NicknameViewController: UIViewController {
    
    var email: String?
    var password: String?
    var gender: String?
    var nickname: String?
    
    // MARK: - 화면구성
    lazy var femaleButton: UIButton = {
        let femaleBtn = UIButton()
        femaleBtn.setTitle("여자", for: .normal)
        femaleBtn.setTitleColor(UIColor(hexCode: "#8F8F8F"), for: .normal)
        femaleBtn.backgroundColor = UIColor(hexCode: "#363636")
        femaleBtn.layer.cornerRadius = 5
        femaleBtn.layer.borderWidth = 1
        femaleBtn.layer.borderColor = UIColor(hexCode: "#636363").cgColor
        femaleBtn.addTarget(self,
                            action: #selector(genderButtonTapped(_:)),
                            for: .touchUpInside)
        return femaleBtn
    }()
    
    lazy var maleButton: UIButton = {
        let maleBtn = UIButton()
        maleBtn.setTitle("남자", for: .normal)
        maleBtn.setTitleColor(UIColor(hexCode: "#8F8F8F"), for: .normal)
        maleBtn.backgroundColor = UIColor(hexCode: "#363636")
        maleBtn.layer.cornerRadius = 5
        maleBtn.layer.borderWidth = 1
        maleBtn.layer.borderColor = UIColor(hexCode: "#636363").cgColor
        maleBtn.addTarget(self,
                          action: #selector(genderButtonTapped(_:)),
                          for: .touchUpInside)
        return maleBtn
    }()
    
    private let nicknameTextField: UITextField = {
        let nicknameTF = UITextField()
        nicknameTF.placeholder = "닉네임을 입력하세요"
        nicknameTF.attributedPlaceholder = NSAttributedString(string: "닉네임을 입력해주세요",
                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        nicknameTF.textColor = .white
        nicknameTF.backgroundColor = .black
        nicknameTF.borderStyle = .roundedRect
        nicknameTF.becomeFirstResponder()
        // Observe changes in the text field to update character count
        nicknameTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
 
        
        return nicknameTF
    }()
    
    private let characterCountLabel: UILabel = {
        let countLabel = UILabel()
        countLabel.textColor = UIColor(hexCode: "#8F8F8F")
        countLabel.text = "0/10"
        countLabel.font = UIFont.systemFont(ofSize: 12)
        return countLabel
    }()
    
    private let titleLabel: UILabel = {
        // '회원가입' 텍스트
        let titleLabel = UILabel()
        titleLabel.text = "회원가입"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        return titleLabel
    }()
    
    private let progressLabel: UILabel = {
        let progressLabel = UILabel()
        progressLabel.text = "3/4"
        progressLabel.textColor = .gray
        progressLabel.font = UIFont.boldSystemFont(ofSize: 20)
        return progressLabel
    }()
    
    private let nicknamePromptLabel: UILabel = {
        let nicknamePromptLabel = UILabel()
        nicknamePromptLabel.text = "스터디 참여에 필요한 정보를 알려주세요"
        nicknamePromptLabel.textColor = .white
        nicknamePromptLabel.font = UIFont.boldSystemFont(ofSize: 22)
        return nicknamePromptLabel
    }()
    
    private let genderfixLabel: UILabel = {
        let genderfixLabel = UILabel()
        genderfixLabel.text = "성별은 추후에 수정이 불가해요"
        genderfixLabel.textColor = .gray
        genderfixLabel.font = UIFont.systemFont(ofSize: 13)
        return genderfixLabel
    }()
    
    private let nicknameLabel: UILabel = {
        let nicknameLabel = UILabel()
        nicknameLabel.text = "닉네임"
        nicknameLabel.textColor = .white
        return nicknameLabel
    }()
    
    private let nicknameTextFielddividerLine: UIView = {
        let nicknameTextFielddividerLine = UIView()
        nicknameTextFielddividerLine.backgroundColor = .gray
        return nicknameTextFielddividerLine
    }()
    
    private lazy var duplicationcheckButton: UIButton = {
        let validBtn = UIButton()
        validBtn.setTitle("중복확인", for: .normal)
        validBtn.setTitleColor(UIColor(hexCode: "#FFFFFF"), for: .normal)
        validBtn.backgroundColor = UIColor(hexCode: "#FF5530")
        validBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        validBtn.layer.cornerRadius = 5
        validBtn.addTarget(self,
                           action: #selector(duplicationcheckButtonTapped),
                           for: .touchUpInside)
        return validBtn
    }()
    
    private lazy var nicknamenotuseLabel: UILabel = {
        let nicknamenotuseLabel = UILabel()
        nicknamenotuseLabel.text = "이미 존재하는 닉네임이에요"
        nicknamenotuseLabel.font = UIFont.systemFont(ofSize: 12)
        nicknamenotuseLabel.textColor = .red
        nicknamenotuseLabel.isHidden = true
        
        return nicknamenotuseLabel
    }()
    
    private lazy var nicknameuseLabel: UILabel = {
        let nicknameuseLabel = UILabel()
        nicknameuseLabel.text = "사용가능한 닉네임이에요"
        nicknameuseLabel.font = UIFont.systemFont(ofSize: 12)
        nicknameuseLabel.textColor = .green
        nicknameuseLabel.isHidden = true
        
        return nicknameuseLabel
    }()
    
    private let genderLabel: UILabel = {
        let genderLabel = UILabel()
        genderLabel.text = "성별"
        genderLabel.textColor = .white
        return genderLabel
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
            titleLabel,
            progressLabel,
            nicknamePromptLabel,
            genderfixLabel,
            nicknameLabel,
            nicknameTextFielddividerLine,
            nicknameTextField,
            characterCountLabel,
            duplicationcheckButton,
            nicknamenotuseLabel,
            nicknameuseLabel,
            genderLabel,
            femaleButton,
            maleButton,
            nextButton
        ].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - makeUI
    func makeUI(){
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-35)
            make.centerX.equalToSuperview()
        }
        
        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.trailing.equalTo(view.snp.trailing).offset(-350)
        }
        
        nicknamePromptLabel.snp.makeConstraints { make in
            make.top.equalTo(progressLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.leading).offset(20)
        }
        
        genderfixLabel.snp.makeConstraints { make in
            make.top.equalTo(progressLabel.snp.bottom).offset(40)
            make.leading.equalTo(view.snp.leading).offset(20)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknamePromptLabel.snp.bottom).offset(80)
            make.leading.equalTo(view.snp.leading).offset(15)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(20)
            make.leading.equalTo(nicknameLabel.snp.leading)
            make.trailing.equalTo(view.snp.trailing).offset(-70)
            make.height.equalTo(30)
        }
        
        characterCountLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(10)
            make.trailing.equalTo(view.snp.trailing).offset(-30)
        }
        
        duplicationcheckButton.snp.makeConstraints { make in
            make.leading.equalTo(nicknameTextField.snp.trailing).offset(-10)
            make.centerY.equalTo(nicknameTextField)
            make.width.equalTo(68)
            make.height.equalTo(30)
        }
        
        // Divider line constraints
        nicknameTextFielddividerLine.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(5)
            make.height.equalTo(1)
        }
        
        nicknamenotuseLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextFielddividerLine.snp.bottom).offset(5)
            make.leading.equalTo(view).offset(15)
        }
        
        nicknameuseLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextFielddividerLine.snp.bottom).offset(5)
            make.leading.equalTo(view).offset(15)
        }
        
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextFielddividerLine.snp.bottom).offset(60)
            make.leading.equalTo(view.snp.leading).offset(20)
        }
        
        femaleButton.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(15)
            make.width.equalTo(180)
            make.height.equalTo(45)
        }
        
        maleButton.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).offset(20)
            make.leading.equalTo(femaleButton.snp.trailing).offset(5)
            make.width.equalTo(180)
            make.height.equalTo(45)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nicknameTextFielddividerLine.snp.bottom).offset(350)
            make.height.equalTo(55)
            make.width.equalTo(400)
        }
    }
    
    // MARK: - TextField Editing Change
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let nickname = nickname, !nickname.isEmpty {
            nextButton.backgroundColor = UIColor(hexCode: "#FF5530")
            nextButton.setTitleColor(UIColor(hexCode: "#FFFFFF"), for: .normal)
        } else {
            //닉네임 비어있음
            nicknameTextFielddividerLine.backgroundColor = .gray
            nicknameuseLabel.isHidden = true
            nicknamenotuseLabel.isHidden = true
            nextButton.backgroundColor = UIColor(hexCode: "#6F2B1C")
            nextButton.setTitleColor(UIColor(hexCode: "#6F6F6F"), for: .normal)
        }
        
        if nicknameTextFielddividerLine.backgroundColor != .green{
            nextButton.backgroundColor = UIColor(hexCode: "#6F2B1C")
            nextButton.setTitleColor(UIColor(hexCode: "#6F6F6F"), for: .normal)
        }

        
        guard let text = textField.text else { return }
        let characterCount = text.count
        
        let attributedString = NSMutableAttributedString(string: "\(characterCount)/10")
        attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: 1))
        characterCountLabel.attributedText = attributedString

        if characterCount > 10 {
            textField.text = String(text.prefix(10)) // Restrict input to 10 characters
            characterCountLabel.text = "10/10"
        } else {
            characterCountLabel.text = "\(characterCount)/10"
        }
    }
    
    // MARK: - 닉네임 중복 확인
    @objc func duplicationcheckButtonTapped() {
        let nickname = nicknameTextField.text
        
        // 서버에 POST 요청을 보냅니다.
        sendNicknameToServer(nickname: nickname)
    }
    
    // 서버에 GET 요청을 보내는 메서드
    func sendNicknameToServer(nickname: String?) {
        guard let nickname = nickname, !nickname.isEmpty else {
            return
        }
        
        // API 엔드포인트 URL과 쿼리 파라미터 준비
        var urlComponents = URLComponents(string: "https://study-hub.site:443/api/users/duplication-nickname")!
        urlComponents.queryItems = [URLQueryItem(name: "nickname", value: nickname)]
        
        guard let url = urlComponents.url else {
            // 잘못된 URL 처리
            return
        }
        
        // URLRequest 생성 (GET 요청으로 수정)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // URLSession을 사용하여 서버 요청을 보냅니다.
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            // 서버 응답 처리
            if let data = data,
               let response = response as? HTTPURLResponse,
               response.statusCode == 200 {
                // 서버로부터 ACCEPTED 응답을 받았을 때의 처리
                if let responseString = String(data: data, encoding: .utf8) {
                }
                DispatchQueue.main.async {
                    // "사용 가능한 닉네임입니다"
                    self?.nicknameTextFielddividerLine.backgroundColor = .green
                    self?.nicknamenotuseLabel.isHidden = true
                    self?.nicknameuseLabel.isHidden = false
                    
                    // Check if either of the gender buttons is selected
                    if self?.femaleButton.backgroundColor == UIColor(hexCode: "#6F2B1C") ||
                       self?.maleButton.backgroundColor == UIColor(hexCode: "#6F2B1C") {
                        self?.nextButton.backgroundColor = UIColor(hexCode: "#FF5530")
                        self?.nextButton.setTitleColor(UIColor(hexCode: "#FFFFFF"), for: .normal)
                    }
                    
                }
            } else {
                // 기타 오류 응답일 때의 처리
                if let responseString = String(data: data ?? Data(), encoding: .utf8) {
                }
                DispatchQueue.main.async {
                    // "중복된 닉네임입니다"
                    self?.nextButton.backgroundColor = UIColor(hexCode: "#6F2B1C")
                    self?.nextButton.setTitleColor(UIColor(hexCode: "#6F6F6F"), for: .normal)
                    self?.nicknameTextFielddividerLine.backgroundColor = .red
                    self?.nicknamenotuseLabel.isHidden = false
                    self?.nicknameuseLabel.isHidden = true
                    
                }
            }
        }
        task.resume()
    }
    
    // MARK: - 함수
    @objc func genderButtonTapped(_ sender: UIButton) {
        if nicknameTextFielddividerLine.backgroundColor != .green{
            nextButton.backgroundColor = UIColor(hexCode: "#6F2B1C")
            nextButton.setTitleColor(UIColor(hexCode: "#6F6F6F"), for: .normal)
        }else{
            nextButton.backgroundColor = UIColor(hexCode: "#FF5530")
            nextButton.setTitleColor(UIColor(hexCode: "#FFFFFF"), for: .normal)
        }
        // Reset button colors
        femaleButton.backgroundColor = UIColor(hexCode: "#363636")
        femaleButton.setTitleColor(UIColor(hexCode: "#8F8F8F"), for: .normal)
        femaleButton.layer.borderColor = UIColor(hexCode: "#636363").cgColor
        maleButton.backgroundColor = UIColor(hexCode: "#363636")
        maleButton.setTitleColor(UIColor(hexCode: "#8F8F8F"), for: .normal)
        maleButton.layer.borderColor = UIColor(hexCode: "#636363").cgColor
        
        
        // Change the color of the tapped button
        sender.backgroundColor = UIColor(hexCode: "#6F2B1C")
        sender.setTitleColor(UIColor(hexCode: "#FFD7CC"), for: .normal)
        sender.layer.borderColor = UIColor(hexCode: "#FF5530").cgColor
        
        if sender == femaleButton {
            gender = "FEMALE"
        } else if sender == maleButton {
            gender = "MALE"
        }
        
    }
    
    
    @objc func nextButtonTapped() {
        if nicknameTextFielddividerLine.backgroundColor == .green, let selectedGender = gender {
            let departmentVC = DepartmentViewController()
            departmentVC.email = email
            departmentVC.password = password
            departmentVC.gender = gender
            departmentVC.nickname = nicknameTextField.text

            let backButton = UIBarButtonItem()
            backButton.tintColor = .white
            navigationItem.backBarButtonItem = backButton
            
            navigationController?.pushViewController(departmentVC, animated: true)
        }
    }
}
