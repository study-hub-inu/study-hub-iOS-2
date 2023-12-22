//
//  InfoManager.swift
//  STUDYHUB2
//
//  Created by 최용헌 on 2023/10/14.
//

import Foundation

struct CreateStudyRequest: Codable {
  var chatUrl: String
  var close: Bool
  var content, gender, major: String
  var penalty: Int
  let penaltyWay: String?
  var studyEndDate: String
  var studyPerson: Int
  var studyStartDate, studyWay, title: String
  
}

struct UpdateStudyRequest: Codable {
  var postId: Int
  var chatUrl: String
  var close: Bool
  var content, gender, major: String
  var penalty: Int
  let penaltyWay: String?
  var studyEndDate: String
  var studyPerson: Int
  var studyStartDate, studyWay, title: String
}


//MARK: - Networking (서버와 통신하는) 클래스 모델
final class PostManager {
  static let shared = PostManager()
  
  let tokenManager = TokenManager.shared
  let networkingManager = Networking.networkinhShared
  
  private init() {}
  
  func createPost(createPostDatas: CreateStudyRequest,
                  completion: @escaping () -> Void){
    networkingManager.fetchData(type: "POST",
                                urlPath: "/study-posts",
                                queryItems: nil,
                                tokenNeed: true,
                                createPostData: createPostDatas) { (result: Result<CreateStudyRequest,
                                                                NetworkError>) in
      switch result {
      case .success(let postData):
        print(postData)
        print("성공")
        
        completion()
      case .failure(let error):
        print("Error: \(error)")
      }
    }
  }
}
