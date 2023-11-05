//
//  String+.swift
//  STUDYHUB2
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
  
}
