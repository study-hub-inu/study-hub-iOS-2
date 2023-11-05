//
//  UITextField+.swift
//  STUDYHUB2
//


import UIKit
// MARK: - 문자 길이에 따라 크기 증가
extension UITextView: UITextViewDelegate {
  func adjustUITextViewHeight() {
    self.translatesAutoresizingMaskIntoConstraints = true
    self.sizeToFit()
    self.isScrollEnabled = false
  }
  

}
