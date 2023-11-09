//
//  String+.swift
//  STUDYHUB2
//
//  Created by 최용헌 on 2023/10/13.
//

import UIKit

extension String {
  func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
    let boundingBox = self.boundingRect(with: constraintRect,
                                        options: .usesLineFragmentOrigin,
                                        attributes: [NSAttributedString.Key.font: font],
                                        context: nil)
    return ceil(boundingBox.width)
  }
  
  func dateConvert() -> String {
    let inputFormat = "yyyy'년' MM'월' dd'일'"
    let outputFormat = "yyyy-MM-dd"

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = inputFormat

    if let date = dateFormatter.date(from: self) {
        dateFormatter.dateFormat = outputFormat
        let outputDate = dateFormatter.string(from: date)
        return outputDate
    } else {
      return "fail"
    }
  }
  
  func convertMajor(_ major: String, toEnglish: Bool) -> String {
    switch (major, toEnglish) {
    case ("정보통신공학과", true):
      return "INFORMATION_TELECOMMUNICATION_ENGINEERING"
    case ("INFORMATION_TELECOMMUNICATION_ENGINEERING", false):
      return "정보통신공학"
    default:
      return "Unknown"
    }
  }
}
