//
//  SearchBarHelper.swift
//  STUDYHUB2
//
//  Created by HYERYEONG on 2023/11/06.
//

import UIKit

extension UISearchBar {
  static func createSearchBar() -> UISearchBar {
    let bar = UISearchBar()
  
    bar.placeholder = "스터디와 관련된 학과를 입력해주세요"
    bar.searchTextField.font = UIFont(name: "Pretendard", size: 20)
    
    if let searchBarTextField = bar.value(forKey: "searchField") as? UITextField {
      searchBarTextField.font = UIFont.systemFont(ofSize: 14)
      searchBarTextField.layer.cornerRadius = 10
      searchBarTextField.layer.masksToBounds = true
      searchBarTextField.backgroundColor = .white
      searchBarTextField.layer.borderColor = UIColor.lightGray.cgColor
      searchBarTextField.layer.borderWidth = 0.5
    }
    
    let searchImg = UIImage(named: "SearchImg")?.withRenderingMode(.alwaysOriginal)
    
    bar.setImage(UIImage(), for: UISearchBar.Icon.search, state: .normal)
    
    bar.showsBookmarkButton = true
    bar.setImage(searchImg, for: .bookmark, state: .normal)
    
    bar.backgroundImage = UIImage()
    
    return bar
  }
}
