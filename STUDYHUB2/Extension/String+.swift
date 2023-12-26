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
  
  
  func convertMajor(_ koreanName: String, isEnglish: Bool) -> String {
    let conversionTable: [String: String] = [
      "공연예술과": "PERFORMING_ARTS",
      "IBE전공": "IBE",
      "건설환경공학": "CIVIL_AND_ENVIRONMENTAL_ENGINEERING",
      "건축공학": "ARCHITECTURAL_ENGINEERING",
      "경영학부": "BUSINESS_ADMINISTRATION",
      "경제학과": "ECONOMICS",
      "국어교육과": "KOREAN_LANGUAGE_EDUCATION",
      "국어국문학과": "KOREAN_LANGUAGE_AND_LITERATURE",
      "기계공학과": "MECHANICAL_ENGINEERING",
      "데이터과학과": "BUSINESS_WITH_DATA_SCIENCE",
      "도시건축학": "ARCHITECTURE_AND_URBAN_DESIGN",
      "도시공학과": "URBAN_ENGINEERING",
      "도시행정학과": "URBAN_POLICY_AND_ADMINISTRATION",
      "독어독문학과": "GERMAN_LANGUAGE_AND_LITERATURE",
      "동북아통상전공": "SCHOOL_OF_NORTHEAST_ASIAN_STUDIES",
      "디자인학부": "DIVISION_OF_DESIGN",
      "무역학부": "INTERNATIONAL_TRADE",
      "문헌정보학과": "LIBRARY_AND_INFORMATION_SCIENCE",
      "물리학과": "PHYSICS",
      "미디어커뮤니케이션학과": "MASS_COMMUNICATION",
      "바이오-로봇 시스템 공학과": "MECHANICAL_ENGINEERING_AND_ROBOTICS",
      "법학부": "LAW",
      "불어불문학과": "FRENCH_LANGUAGE_AND_LITERATURE",
      "사회복지학과": "SOCIAL_WELFARE",
      "산업경영공학과": "INDUSTRIAL_AND_MANAGEMENT_ENGINEERING",
      "생명공학부(나노바이오공학전공)": "NANO_BIOENGINEERING",
      "생명공학부(생명공학전공)": "BIOENGINEERING",
      "생명과학부(분자의생명전공)": "MOLECULAR_AND_MEDICAL_SCIENCE",
      "생명과학부(생명과학전공)": "BIOLOGICAL_SCIENCES",
      "서양화전공(조형예술학부)": "WESTERN_PAINTING_MAJOR",
      "세무회계학과": "TAX_AND_ACCOUNTING",
      "소비자학과": "CONSUMER_SCIENCE",
      "수학과": "MATHEMATICS",
      "수학교육과": "MATHEMATICS_EDUCATION",
      "스마트물류공학전공": "SMART_LOGISTICS_ENGINEERING",
      "스포츠과학부": "SPORT_SCIENCE",
      "신소재공학과": "MATERIALS_SCIENCE_AND_ENGINEERING",
      "안전공학과": "SAFETY_ENGINEERING",
      "에너지화학공학": "ENERGY_AND_CHEMICAL_ENGINEERING",
      "역사교육과": "HISTORY_EDUCATION",
      "영어교육과": "ENGLISH_LANGUAGE_EDUCATION",
      "영어영문학과": "ENGLISH_LANGUAGE_AND_LITERATURE",
      "운동건강학부": "HEALTH_AND_KINESIOLOGY",
      "유아교육과": "EARLY_CHILDHOOD_EDUCATION",
      "윤리교육과": "ETHICS_EDUCATION",
      "일본지역문화학과": "JAPANESE_LANGUAGE_AND_LITERATURE",
      "일일어교육과": "JAPANESE_LANGUAGE_EDUCATION",
      "임베디드시스템공과": "EMBEDDED_SYSTEMS_ENGINEERING",
      "전기공학과": "ELECTRICAL_ENGINEERING",
      "전자공학과": "ELECTRONICS_ENGINEERING",
      "정보통신학과": "INFORMATION_TELECOMMUNICATION_ENGINEERING",
      "정치외교학과": "POLITICAL_SCIENCE_AND_INTERNATIONAL_STUDIES",
      "중어중국학과": "CHINESE_LANGUAGE_AND_CULTURAL_STUDIES",
      "창의인개발학과": "CREATIVE_HUMAN_RESOURCE_DEVELOPMENT",
      "체육교육과": "PHYSICAL_EDUCATION",
      "컴퓨터공학부": "COMPUTER_SCIENCE_ENGINEERING",
      "테크노경영학과": "TECHNOLOGY_MANAGEMENT",
      "패션산업학과": "FASHION_AND_INDUSTRY",
      "한국화전공(조형예술학부)": "KOREAN_PAINTING",
      "해양학과": "MARINE_SCIENCE",
      "행정학과": "PUBLIC_ADMINISTRATION",
      "화학과": "CHEMISTRY",
      "환경공학": "ENVIRONMENTAL_ENGINEERING"
    ]
    
    let convertedName = isEnglish ? conversionTable[koreanName] ?? "" :
    Array(conversionTable.keys).first(where: { conversionTable[$0] == koreanName }) ?? ""
    
    return convertedName.uppercased().replacingOccurrences(of: " ", with: "_")
  }
  
  
}
