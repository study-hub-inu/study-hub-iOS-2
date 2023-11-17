//
//  UILabel+.swift
//  STUDYHUB2
//
//  Created by 최용헌 on 2023/11/07.
//

import UIKit

extension UILabel {
  // MARK: - 글자색상 일부분 변경
  func changeColor(label: UILabel, wantToChange: String, color: UIColor){
    let attributedStr = NSMutableAttributedString(string: label.text!)
    
    //위에서 만든 attributedStr에, addAttribute()메소드를 통해 스타일 적용.
    attributedStr.addAttribute(.foregroundColor,
                               value: color,
                               range: (label.text! as NSString).range(of:wantToChange))
    
    //최종적으로 내 label에 text가 아닌, attributedText를 적용
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

