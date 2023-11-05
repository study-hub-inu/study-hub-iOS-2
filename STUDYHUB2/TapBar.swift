//
//  TapBar.swift
//  STUDYHUB2
//
//  Created by 최용헌 on 2023/10/12.
//

import UIKit

class TabBarController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let homeViewController = HomeViewController()
    let studyViewController = StudyViewController()
    let myPageViewController = MyPageViewController()
    
    self.viewControllers = [homeViewController, studyViewController, myPageViewController]
    
    homeViewController.tabBarItem = UITabBarItem(title: "홈",
                                                 image: UIImage(systemName: "house"), tag: 0)
    studyViewController.tabBarItem = UITabBarItem(title: "스터디",
                                                  image: UIImage(systemName: "book"), tag: 1)
    myPageViewController.tabBarItem = UITabBarItem(title: "마이페이지",
                                                   image: UIImage(systemName:"person"), tag: 2)
    
  }
}

