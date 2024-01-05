//
//  UILabel+.swift
//  STUDYHUB2
//
//  Created by 최용헌 on 2023/11/07.
//

import UIKit

extension UILabel {
  // MARK: - 글자색상 일부분 변경
  func changeColor(label: UILabel,
                            wantToChange: Any,
                            color: UIColor,
                            font: UIFont? = nil,
                            lineSpacing: CGFloat? = nil) {
      let attributedStr = NSMutableAttributedString(string: "\(label.text ?? "")")
      
      if let wantToChangeString = "\(wantToChange)" as? NSString {
          let range = (label.text as NSString?)?.range(of: wantToChangeString as String) ?? NSMakeRange(0, 0)
          
          attributedStr.addAttribute(.foregroundColor, value: color, range: range)
          
          if let font = font {
              attributedStr.addAttribute(.font, value: font, range: range)
          }
      }
      
      if let lineSpacing = lineSpacing {
          let style = NSMutableParagraphStyle()
          style.lineSpacing = lineSpacing
          attributedStr.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: attributedStr.length))
      }
      
      label.attributedText = attributedStr
  }



  func setLineSpacing(spacing: CGFloat) {
      guard let text = text else { return }

      let attributeString = NSMutableAttributedString(string: text)
      let style = NSMutableParagraphStyle()
      style.lineSpacing = spacing
      attributeString.addAttribute(.paragraphStyle,
                                   value: style,
                                   range: NSRange(location: 0, length: attributeString.length))
      attributedText = attributeString
  }
}


