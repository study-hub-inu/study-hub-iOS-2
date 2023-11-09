//
//  BottomSheet.swift
//  STUDYHUB2
//
//  Created by 최용헌 on 2023/11/01.
//

import UIKit

import SnapKit

final class BottomSheet: UIViewController {
  private lazy var deleteButton: UIButton = {
    let button = UIButton()
    button.setTitle("삭제하기", for: .normal)
    button.setTitleColor(.o50, for: .normal)
    button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    return button
  }()
  
  private lazy var modifyButton: UIButton = {
    let button = UIButton()
    button.setTitle("수정하기", for: .normal)
    button.setTitleColor(.black, for: .normal)
    return button
  }()
  
  private lazy var dismissButton: UIButton = {
    let button = UIButton()
    button.setTitle("닫기", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.backgroundColor = .bg30
    button.addTarget(self, action: #selector(dissMissButtonTapped), for: .touchUpInside)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    setUpLayout()
    makeUI()
    
  }
  
  func setUpLayout(){
    [
      deleteButton,
      modifyButton,
      dismissButton
    ].forEach {
      view.addSubview($0)
    }
  }
  
  func makeUI(){
    deleteButton.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(20)
      make.centerX.equalToSuperview()
      make.leading.equalToSuperview()
      make.height.equalTo(50)
    }
    
    modifyButton.snp.makeConstraints { make in
      make.top.equalTo(deleteButton.snp.bottom).offset(10)
      make.centerX.equalToSuperview()
      make.height.equalTo(50)

    }
    
    dismissButton.snp.makeConstraints { make in
      make.top.equalTo(modifyButton.snp.bottom).offset(10)
      make.centerX.equalToSuperview()
      make.height.equalTo(50)
      make.width.equalTo(335)
    }
  }
  
  @objc func deleteButtonTapped(){
    let popupVC = PopupViewController(title: "이 글을 삭제할까요?",
                                      desc: "삭제한 글과 참여자는 다시 볼 수 없어요")
    popupVC.modalPresentationStyle = .overFullScreen
    self.present(popupVC, animated: false)
  }
  
  @objc func dissMissButtonTapped(){
    dismiss(animated: true, completion: nil)
  }
}
