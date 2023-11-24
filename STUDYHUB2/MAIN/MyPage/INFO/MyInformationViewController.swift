//
//  MyinformViewController.swift
//  STUDYHUB2
//
//  Created by HYERYEONG on 2023/11/07.
//

import UIKit

import SnapKit

class MyInformViewController: UIViewController {
  var major: String?
  var nickname: String?
  var email: String?
  var gender: String?
  
  
  
  private let headerStackView: UIStackView = {
    let headerStackView = UIStackView()
    headerStackView.axis = .horizontal
    headerStackView.alignment = .center
    headerStackView.spacing = 8
    return headerStackView
  }()
  
  private lazy var backButton: UIButton = {
    let backButton = UIButton(type: .system)
    backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
    backButton.tintColor = .white
    backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    return backButton
  }()
  
  private lazy var myinformLabel = createLabel(title: "내 정보",
                                               textColor: .white,
                                               fontSize: 18)
  
  private lazy var headerContentStackView = createStackView(axis: .vertical,
                                                            spacing: 40)
  
  private lazy var profileImageStackView = createStackView(axis: .vertical,spacing: 5)
  
  
  private lazy var profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 15
    imageView.image = UIImage(named: "ProfileAvatar")
    imageView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    
    return imageView
  }()
  
  //이미지 삭제, 변경
  private lazy var ImageeditStackView = createStackView(axis: .horizontal,
                                                        spacing: 5)
  lazy var deleteButton: UIButton = {
    let deleteButton = UIButton()
    deleteButton.setTitle("삭제", for: .normal)
    deleteButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    deleteButton.setTitleColor(UIColor(hexCode: "#A1AAB0"), for: .normal)
    deleteButton.translatesAutoresizingMaskIntoConstraints = false
    //      deleteButton.addTarget(self, action: #selector(deleteButtonButtonTapped(_:)), for: .touchUpInside)
    return deleteButton
  }()
  
  lazy var editButton: UIButton = {
    let editButton = UIButton()
    editButton.setTitle("변경", for: .normal)
    editButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    editButton.setTitleColor(UIColor(hexCode: "#FF5530"), for: .normal)
    editButton.translatesAutoresizingMaskIntoConstraints = false
    //        editButton.addTarget(self, action: #selector(editButtonButtonTapped(_:)), for: .touchUpInside)
    return editButton
  }()
  
  //닉네임
  private lazy var nicknameStackView = createStackView(axis: .horizontal,
                                                       spacing: 5)
  
  private lazy var nicknamekLabel = createLabel(title: "닉네임",
                                                textColor: .black,
                                                fontSize: 16)
  
  
  private lazy var usernicknamekLabel: UILabel = {
    let label = UILabel()
    
    label.text = nickname
    
    label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    label.textColor = UIColor(hexCode: "#68737D")
    
    return label
  }()
  
  private lazy var nicknamechevronButton: UIButton = {
    let nicknamechevronButton = UIButton(type: .system)
    nicknamechevronButton.setImage(UIImage(systemName: "chevron.right"),
                                   for: .normal)
    nicknamechevronButton.tintColor = UIColor(hexCode: "#8F8F8F")
    //        nicknamechevronButton.addTarget(self,
    //                              action: #selector(nicknamechevronButtonTapped),
    //                              for: .touchUpInside)
    nicknamechevronButton.contentHorizontalAlignment = .trailing
    
    return nicknamechevronButton
  }()
  
  //학과
  private lazy var departmentStackView = createStackView(axis: .horizontal,
                                                         spacing: 5)
  
  private lazy var departmentLabel = createLabel(title: "학과",
                                                 textColor: .black,
                                                 fontSize: 16)
  
  private lazy var userdepartmentLabel: UILabel = {
    let label = UILabel()
    
    label.text = major
    
    label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    label.textColor = UIColor(hexCode: "#68737D")
    
    return label
  }()
  
  
  private lazy var departmentchevronButton: UIButton = {
    let departmentchevronButton = UIButton(type: .system)
    departmentchevronButton.setImage(UIImage(systemName: "chevron.right"),
                                     for: .normal)
    departmentchevronButton.tintColor = UIColor(hexCode: "#8F8F8F")
    departmentchevronButton.contentHorizontalAlignment = .trailing
    
    return departmentchevronButton
  }()
  
  //비밀번호
  private lazy var passwordStackView = createStackView(axis: .horizontal,
                                                       spacing: 5)
  
  private lazy var passwordLabel = createLabel(title: "비밀번호",
                                               textColor: .black,
                                               fontSize: 16)
  
  
  private lazy var passwordchevronButton: UIButton = {
    let passwordchevronButton = UIButton(type: .system)
    passwordchevronButton.setImage(UIImage(systemName: "chevron.right"),
                                   for: .normal)
    passwordchevronButton.tintColor = UIColor(hexCode: "#8F8F8F")
    passwordchevronButton.contentHorizontalAlignment = .trailing
    
    return passwordchevronButton
  }()
  
  //성별
  private lazy var genderStackView = createStackView(axis: .horizontal,
                                                     spacing: 5)
  
  private lazy var genderLabel = createLabel(title: "성별",
                                             textColor: .black,
                                             fontSize: 16)
  
  private lazy var usergenderLabel: UILabel = {
    let label = UILabel()
    
    label.text = gender
    
    label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    label.textColor = UIColor(hexCode: "#68737D")
    
    return label
  }()
  
  //이메일
  private lazy var emailStackView = createStackView(axis: .horizontal,
                                                    spacing: 5)
  
  private lazy var emailLabel = createLabel(title: "이메일",
                                            textColor: .black,
                                            fontSize: 16)
  
  private lazy var useremailLabel: UILabel = {
    let label = UILabel()
    
    label.text = email
    
    label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    label.textColor = UIColor(hexCode: "#68737D")
    
    return label
  }()
  
  
  private let DividerLine: UIView = {
    let DividerLine = UIView()
    DividerLine.backgroundColor = UIColor(hexCode: "#F3F5F6")
    DividerLine.heightAnchor.constraint(equalToConstant: 10).isActive = true
    return DividerLine
  }()
  
  private lazy var normalButtonStackView = createStackView(axis: .vertical,
                                                           spacing: 16)
  private lazy var logoutButton = createMypageButton(title: "로그아웃")
  private lazy var quitButton = createMypageButton(title: "탈퇴하기")
  
  
  let scrollView = UIScrollView()
  
  // MARK: - viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    
    setUpLayout()
    makeUI()
  }
  
  // MARK: - setUpLayout
  func setUpLayout(){
    headerStackView.addArrangedSubview(backButton)
    headerStackView.addArrangedSubview(myinformLabel)
    
    headerContentStackView.addArrangedSubview(profileImageStackView)
    profileImageStackView.addArrangedSubview(profileImageView)
    
    headerContentStackView.addArrangedSubview(ImageeditStackView)
    ImageeditStackView.addArrangedSubview(deleteButton)
    ImageeditStackView.addArrangedSubview(editButton)
    
    headerContentStackView.addArrangedSubview(nicknameStackView)
    nicknameStackView.addArrangedSubview(nicknamekLabel)
    nicknameStackView.addArrangedSubview(usernicknamekLabel)
    nicknameStackView.addArrangedSubview(nicknamechevronButton)
    
    headerContentStackView.addArrangedSubview(departmentStackView)
    departmentStackView.addArrangedSubview(departmentLabel)
    departmentStackView.addArrangedSubview(userdepartmentLabel)
    departmentStackView.addArrangedSubview(departmentchevronButton)
    
    headerContentStackView.addArrangedSubview(passwordStackView)
    passwordStackView.addArrangedSubview(passwordLabel)
    passwordStackView.addArrangedSubview(passwordchevronButton)
    
    headerContentStackView.addArrangedSubview(genderStackView)
    genderStackView.addArrangedSubview(genderLabel)
    genderStackView.addArrangedSubview(usergenderLabel)
    
    headerContentStackView.addArrangedSubview(emailStackView)
    emailStackView.addArrangedSubview(emailLabel)
    emailStackView.addArrangedSubview(useremailLabel)
    
    headerContentStackView.addArrangedSubview(DividerLine)
    
    headerContentStackView.addArrangedSubview(normalButtonStackView)
    normalButtonStackView.addArrangedSubview(logoutButton)
    normalButtonStackView.addArrangedSubview(quitButton)
    
    
    
    
    view.addSubview(headerStackView)
    
    
    
    // 키보드 내리기를 위한 탭 제스처 추가
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
    view.addGestureRecognizer(tapGesture)
    
    
    // Create a scroll view to make the content scrollable
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(headerContentStackView)
    view.addSubview(scrollView)
    
    scrollView.backgroundColor = .white
    
    headerContentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
  }
  // MARK: - makeUI
  func makeUI(){
    headerStackView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.leading.equalTo(view.snp.leading).offset(-60)
      make.trailing.equalTo(view.snp.trailing).offset(-16)
    }
    
    backButton.snp.makeConstraints { make in
      make.leading.equalTo(headerStackView.snp.leading).offset(-50)
    }
    
    myinformLabel.snp.makeConstraints { make in
      make.centerX.equalTo(headerStackView.snp.centerX).offset(115)
    }
    
    // Header content stack view constraints
    headerContentStackView.snp.makeConstraints { make in
      make.top.equalTo(scrollView.snp.top).offset(20)
      make.leading.equalTo(scrollView.snp.leading)
      make.trailing.equalTo(scrollView.snp.trailing)
      make.bottom.equalTo(scrollView.snp.bottom)
      make.width.equalTo(scrollView.snp.width)
    }
    
    profileImageStackView.snp.makeConstraints { make in
      make.leading.equalTo(headerContentStackView.snp.leading)
      make.trailing.equalTo(headerContentStackView.snp.trailing)
    }
    
    profileImageView.snp.makeConstraints { make in
      make.centerX.equalTo(headerContentStackView.snp.centerX)
      make.width.equalTo(80)
      make.height.equalTo(80)
      make.trailing.equalTo(profileImageStackView.snp.trailing).offset(-50)
    }
    
    //      ImageeditStackView.snp.makeConstraints { make in
    //          make.centerX.equalTo(headerContentStackView.snp.centerX)
    //      }
    
    //이미지 수정 삭제
    deleteButton.snp.makeConstraints { make in
      make.leading.equalTo(ImageeditStackView.snp.leading).offset(150)
    }
    
    editButton.snp.makeConstraints { make in
      make.leading.equalTo(deleteButton.snp.trailing).offset(-142)
    }
    
    //닉네임
    nicknamekLabel.snp.makeConstraints { make in
      make.leading.equalTo(nicknameStackView.snp.leading).offset(20)
    }
    
    usernicknamekLabel.snp.makeConstraints { make in
      make.leading.equalTo(nicknamekLabel.snp.trailing).offset(-10)
    }
    
    nicknamechevronButton.snp.makeConstraints { make in
      make.trailing.equalTo(headerContentStackView.snp.trailing).offset(-20)
    }
    
    //학과
    departmentLabel.snp.makeConstraints { make in
      make.leading.equalTo(departmentStackView.snp.leading).offset(20)
    }
    
    userdepartmentLabel.snp.makeConstraints { make in
      make.leading.equalTo(departmentLabel.snp.trailing).offset(-10)
    }
    
    departmentchevronButton.snp.makeConstraints { make in
      make.trailing.equalTo(headerContentStackView.snp.trailing).offset(-20)
    }
    
    //비밀번호
    passwordLabel.snp.makeConstraints { make in
      make.leading.equalTo(passwordStackView.snp.leading).offset(20)
    }
    
    passwordchevronButton.snp.makeConstraints { make in
      make.trailing.equalTo(headerContentStackView.snp.trailing).offset(-20)
    }
    
    //성별
    genderLabel.snp.makeConstraints { make in
      make.leading.equalTo(genderStackView.snp.leading).offset(20)
    }
    
    usergenderLabel.snp.makeConstraints { make in
      make.leading.equalTo(genderLabel.snp.leading).offset(290)
    }
    
    //이메일
    emailLabel.snp.makeConstraints { make in
      make.leading.equalTo(emailStackView.snp.leading).offset(20)
    }
    
    useremailLabel.snp.makeConstraints { make in
      make.leading.equalTo(emailLabel.snp.leading).offset(210)
    }
    
    
    normalButtonStackView.alignment = .leading
    normalButtonStackView.snp.makeConstraints { make in
      make.leading.equalTo(headerContentStackView.snp.leading)
      make.bottom.equalTo(scrollView.snp.bottom).offset(-16)
    }
    
    logoutButton.snp.makeConstraints { make in
      make.leading.equalTo(normalButtonStackView.snp.leading).offset(20)
    }
    
    
    scrollView.snp.makeConstraints { make in
      make.top.equalTo(headerStackView.snp.bottom).offset(16)
      make.leading.equalTo(view)
      make.trailing.equalTo(view)
      make.bottom.equalTo(view)
    }
  }
  
  
  
  // 키보드 내리기 위한 탭 제스처 핸들러
  @objc func handleTap() {
    // 키보드를 내립니다.
    view.endEditing(true)
  }
  
  
  @objc func goBack() {
    
    self.dismiss(animated: true, completion: nil)
  }
  
}
