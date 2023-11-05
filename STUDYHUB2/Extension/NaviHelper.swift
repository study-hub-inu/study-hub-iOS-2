//
//  NaviHelper.swift
//  STUDYHUB2
//


import UIKit
class NaviHelper: UIViewController {
  // MARK: - navi 설정
  func navigationItemSetting() {
    let homeImg = UIImage(named: "LeftArrow")?.withRenderingMode(.alwaysOriginal)
    let leftButton = UIBarButtonItem(image: homeImg,
                                     style: .plain,
                                     target: self,
                                     action: #selector(homeButtonTapped(_:)))
    
    self.navigationController?.navigationBar.barTintColor =  .black
    self.navigationController?.navigationBar.backgroundColor = .black
    self.navigationItem.leftBarButtonItem = leftButton
  }

  @objc func homeButtonTapped(_ sender: UIBarButtonItem) {
    print("H")
  }
  
  

}
