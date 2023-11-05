//
//  UIView+.swift
//  STUDYHUB2
//


import UIKit
extension UIView {
    func setHeight(_ height: CGFloat) {
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidth(_ width: CGFloat) {
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setupStackView(_ stackView: UIStackView, with views: [UIView]) {
        views.forEach { stackView.addArrangedSubview($0) }
    }
    
    func setWidth(equalTo view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
}
