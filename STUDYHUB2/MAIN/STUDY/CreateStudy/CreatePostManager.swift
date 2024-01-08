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

// MARK: - UpdataePost
struct UpdateStudyRequest: Codable {
    let chatURL: String
    let close: Bool
    let content, gender, major: String
    let penalty: Int
    let penaltyWay: String
    let postID: Int
    let studyEndDate: String
    let studyPerson: Int
    let studyStartDate, studyWay, title: String

    enum CodingKeys: String, CodingKey {
        case chatURL = "chatUrl"
        case close, content, gender, major, penalty, penaltyWay
        case postID = "postId"
        case studyEndDate, studyPerson, studyStartDate, studyWay, title
    }
}

struct PostResponse: Codable {
  let id: Int
}


final class PostManager {
  static let shared = PostManager()
  
  let tokenManager = TokenManager.shared
  let networkingManager = Networking.networkinhShared
  
  private init() {}

  // 게시글 생성, 반환값 나중에 스웨거보고 확인하기
  func createPost(createPostDatas: CreateStudyRequest,
                  completion: @escaping () -> Void) {
    
    networkingManager.fetchData(type: "POST",
                                apiVesrion: "v1",
                                urlPath: "/study-posts",
                                queryItems: nil,
                                tokenNeed: true,
                                createPostData: createPostDatas) { result in
      switch result {
      case .success(let postResponse):
        print(postResponse) // 이제 id는 Int 타입의 값입니다.
        print("성공")

        completion()
      case .failure(let error):
        print("Error: \(error)")
      }
    }
  }
  
  func updatePost(updatePostDatas: UpdateStudyRequest,
                  completion: @escaping () -> Void) {
    networkingManager.fetchData(type: "PUT",
                                apiVesrion: "v1",
                                urlPath: "/study-posts",
                                queryItems: nil,
                                tokenNeed: true,
                                createPostData: updatePostDatas) { result in
      switch result {
      case .success(let postResponse):
        print(postResponse) // 이제 id는 Int 타입의 값입니다.
        print("성공")

        completion()
      case .failure(let error):
        print("Error: \(error)")
      }
    }
    
  }
}
