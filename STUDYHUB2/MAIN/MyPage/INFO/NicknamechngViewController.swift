////
////  MyinformViewController.swift
////  STUDYHUB2
////
////  Created by HYERYEONG on 2023/11/07.
////
//
//import UIKit
//
//import SnapKit
//
//class NicknamechngViewController: UIViewController {
//
//
//
//
//  private let headerStackView: UIStackView = {
//    let headerStackView = UIStackView()
//    headerStackView.axis = .horizontal
//    headerStackView.alignment = .center
//    headerStackView.spacing = 8
//    return headerStackView
//  }()
//
//  private lazy var backButton: UIButton = {
//    let backButton = UIButton(type: .system)
//    backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
//    backButton.tintColor = .white
//    backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
//    return backButton
//  }()
//
// private lazy var myinformLabel = createLabel(title: "내 정보",
//                                                    textColor: .white,
//                                                    fontSize: 18)
//
//  private lazy var headerContentStackView = createStackView(axis: .vertical,
//                                                            spacing: 40)
//
//
//
//  let scrollView = UIScrollView()
//
//  // MARK: - viewDidLoad
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    view.backgroundColor = .black
//
//    setUpLayout()
//    makeUI()
//  }
//
//  // MARK: - setUpLayout
//  func setUpLayout(){
//      headerStackView.addArrangedSubview(backButton)
//      headerStackView.addArrangedSubview(myinformLabel)
//
//      headerContentStackView.addArrangedSubview(profileImageStackView)
//      profileImageStackView.addArrangedSubview(profileImageView)
//
//      headerContentStackView.addArrangedSubview(ImageeditStackView)
//      ImageeditStackView.addArrangedSubview(deleteButton)
//      ImageeditStackView.addArrangedSubview(editButton)
//
//      headerContentStackView.addArrangedSubview(nicknameStackView)
//      nicknameStackView.addArrangedSubview(nicknamekLabel)
//      nicknameStackView.addArrangedSubview(usernicknamekLabel)
//      nicknameStackView.addArrangedSubview(nicknamechevronButton)
//
//      headerContentStackView.addArrangedSubview(departmentStackView)
//      departmentStackView.addArrangedSubview(departmentLabel)
//      departmentStackView.addArrangedSubview(userdepartmentLabel)
//      departmentStackView.addArrangedSubview(departmentchevronButton)
//
//      headerContentStackView.addArrangedSubview(passwordStackView)
//      passwordStackView.addArrangedSubview(passwordLabel)
//      passwordStackView.addArrangedSubview(passwordchevronButton)
//
//      headerContentStackView.addArrangedSubview(genderStackView)
//      genderStackView.addArrangedSubview(genderLabel)
//      genderStackView.addArrangedSubview(usergenderLabel)
//
//      headerContentStackView.addArrangedSubview(emailStackView)
//      emailStackView.addArrangedSubview(emailLabel)
//      emailStackView.addArrangedSubview(useremailLabel)
//
//      headerContentStackView.addArrangedSubview(DividerLine)
//
//      headerContentStackView.addArrangedSubview(normalButtonStackView)
//      normalButtonStackView.addArrangedSubview(logoutButton)
//      normalButtonStackView.addArrangedSubview(quitButton)
//
//
//
//
//    view.addSubview(headerStackView)
//
//
//
//    // 키보드 내리기를 위한 탭 제스처 추가
//    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
//    view.addGestureRecognizer(tapGesture)
//
//
//    // Create a scroll view to make the content scrollable
//    scrollView.translatesAutoresizingMaskIntoConstraints = false
//    scrollView.addSubview(headerContentStackView)
//    view.addSubview(scrollView)
//
//    scrollView.backgroundColor = .white
//
//    headerContentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
//  }
//  // MARK: - makeUI
//  func makeUI(){
//    headerStackView.snp.makeConstraints { make in
//      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//      make.leading.equalTo(view.snp.leading).offset(-60)
//      make.trailing.equalTo(view.snp.trailing).offset(-16)
//    }
//
//      backButton.snp.makeConstraints { make in
//        make.leading.equalTo(headerStackView.snp.leading).offset(-50)
//      }
//
//      myinformLabel.snp.makeConstraints { make in
//      make.centerX.equalTo(headerStackView.snp.centerX).offset(115)
//    }
//
//      // Header content stack view constraints
//      headerContentStackView.snp.makeConstraints { make in
//        make.top.equalTo(scrollView.snp.top).offset(20)
//        make.leading.equalTo(scrollView.snp.leading)
//        make.trailing.equalTo(scrollView.snp.trailing)
//        make.bottom.equalTo(scrollView.snp.bottom)
//        make.width.equalTo(scrollView.snp.width)
//      }
//
//      profileImageStackView.snp.makeConstraints { make in
//          make.leading.equalTo(headerContentStackView.snp.leading)
//          make.trailing.equalTo(headerContentStackView.snp.trailing)
//      }
//
//      profileImageView.snp.makeConstraints { make in
//          make.centerX.equalTo(headerContentStackView.snp.centerX)
//          make.width.equalTo(80)
//          make.height.equalTo(80)
//          make.trailing.equalTo(profileImageStackView.snp.trailing).offset(-50)
//      }
//
////      ImageeditStackView.snp.makeConstraints { make in
////          make.centerX.equalTo(headerContentStackView.snp.centerX)
////      }
//
//      //이미지 수정 삭제
//      deleteButton.snp.makeConstraints { make in
//        make.leading.equalTo(ImageeditStackView.snp.leading).offset(150)
//      }
//
//      editButton.snp.makeConstraints { make in
//        make.leading.equalTo(deleteButton.snp.trailing).offset(-142)
//      }
//
//      //닉네임
//      nicknamekLabel.snp.makeConstraints { make in
//        make.leading.equalTo(nicknameStackView.snp.leading).offset(20)
//      }
//
//      usernicknamekLabel.snp.makeConstraints { make in
//          make.leading.equalTo(nicknamekLabel.snp.trailing).offset(-10)
//      }
//
//      nicknamechevronButton.snp.makeConstraints { make in
//        make.trailing.equalTo(headerContentStackView.snp.trailing).offset(-20)
//      }
//
//      //학과
//      departmentLabel.snp.makeConstraints { make in
//        make.leading.equalTo(departmentStackView.snp.leading).offset(20)
//      }
//
//      userdepartmentLabel.snp.makeConstraints { make in
//          make.leading.equalTo(departmentLabel.snp.trailing).offset(-10)
//      }
//
//      departmentchevronButton.snp.makeConstraints { make in
//        make.trailing.equalTo(headerContentStackView.snp.trailing).offset(-20)
//      }
//
//      //비밀번호
//      passwordLabel.snp.makeConstraints { make in
//        make.leading.equalTo(passwordStackView.snp.leading).offset(20)
//      }
//
//      passwordchevronButton.snp.makeConstraints { make in
//        make.trailing.equalTo(headerContentStackView.snp.trailing).offset(-20)
//      }
//
//      //성별
//      genderLabel.snp.makeConstraints { make in
//        make.leading.equalTo(genderStackView.snp.leading).offset(20)
//      }
//
//      usergenderLabel.snp.makeConstraints { make in
//          make.leading.equalTo(genderLabel.snp.leading).offset(290)
//      }
//
//      //이메일
//      emailLabel.snp.makeConstraints { make in
//        make.leading.equalTo(emailStackView.snp.leading).offset(20)
//      }
//
//      useremailLabel.snp.makeConstraints { make in
//          make.leading.equalTo(emailLabel.snp.leading).offset(210)
//      }
//
//
//      normalButtonStackView.alignment = .leading
//      normalButtonStackView.snp.makeConstraints { make in
//          make.leading.equalTo(headerContentStackView.snp.leading)
//          make.bottom.equalTo(scrollView.snp.bottom).offset(-16)
//      }
//
//      logoutButton.snp.makeConstraints { make in
//          make.leading.equalTo(normalButtonStackView.snp.leading).offset(20)
//      }
//
//
//    scrollView.snp.makeConstraints { make in
//      make.top.equalTo(headerStackView.snp.bottom).offset(16)
//      make.leading.equalTo(view)
//      make.trailing.equalTo(view)
//      make.bottom.equalTo(view)
//    }
//  }
//
//
//
//  // 키보드 내리기 위한 탭 제스처 핸들러
//  @objc func handleTap() {
//    // 키보드를 내립니다.
//    view.endEditing(true)
//  }
//
//
//  @objc func goBack() {
//
//    self.dismiss(animated: true, completion: nil)
//  }
//
//}
