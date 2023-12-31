//
//  PostDataManager.swift
//  STUDYHUB2
//
//  Created by 최용헌 on 2023/11/15.
//

import Foundation

// MARK: - PostDataContent
struct PostDataContent: Codable {
  let totalCount: Int
  var postDataByInquiries: PostDataByInquiries
}

// MARK: - PostDataByInquiries
struct PostDataByInquiries: Codable {
  var content: [Content]
  let size, number: Int
  let numberOfElements: Int
  let first, last, empty: Bool
}

// MARK: - Content
struct Content: Codable {
  let postID: Int
  let major, title: String
  let studyStartDate, studyEndDate, createdDate: [Int]
  let studyPerson: Int
  let filteredGender: String
  let penalty: Int
  let penaltyWay: String?
  let remainingSeat: Int
  let close: Bool
  let userData: UserData
  let bookmarked: Bool
  
  enum CodingKeys: String, CodingKey {
    case postID = "postId"
    case major, title, studyStartDate, studyEndDate, createdDate,
         studyPerson, filteredGender, penalty, penaltyWay, remainingSeat, close, userData, bookmarked
  }
}

// MARK: - UserData
struct UserData: Codable {
  let userID: Int
  let major, nickname: String
  let imageURL: String
  
  enum CodingKeys: String, CodingKey {
    case userID = "userId"
    case major, nickname
    case imageURL = "imageUrl"
  }
}


//MARK: - Networking (서버와 통신하는) 클래스 모델
final class PostDataManager {
  
  static let shared = PostDataManager()
  private init() {}
  
  let networkingShared = Networking.networkinhShared
  
  // MARK: - new 모집 중인 스터디
  private var newPostDatas: PostDataContent?
  
  func getNewPostDatas() -> PostDataContent? {
    if let data = newPostDatas {
      return data
    } else {
      // 처리할 값이 없는 경우에 대한 처리를 수행합니다.
      return nil
    }
  }
  
  func getNewPostData(completion: @escaping() -> Void){
    let queryItems = [URLQueryItem(name: "hot", value: "false"),
                      URLQueryItem(name: "page", value: "0"),
                      URLQueryItem(name: "size", value: "5"),
                      URLQueryItem(name: "titleAndMajor", value: "false")]
    
    networkingShared.fetchData(type: "GET",
                               apiVesrion: "v2",
                               urlPath: "/study-posts",
                               queryItems: queryItems,
                               tokenNeed: false,
                               createPostData: nil) { (result: Result<PostDataContent,
                                                          NetworkError>) in
      switch result {
      case .success(let postData):
        self.newPostDatas = postData
        completion()
      case .failure(let error):
        print("에러:", error)
      }
    }
  }
  
  // MARK: - 마감이 임박한 스터디
  private var deadlinePostDatas: PostDataContent?
  
  func getDeadLinePostDatas() -> PostDataContent? {
    if let data = newPostDatas {
      return data
    } else {
      return nil
    }
  }
  
  func getDeadLinePostData(completion: @escaping() -> Void){
    let queryItems = [URLQueryItem(name: "hot", value: "true"),
                      URLQueryItem(name: "page", value: "0"),
                      URLQueryItem(name: "size", value: "4"),
                      URLQueryItem(name: "titleAndMajor", value: "true")]
    networkingShared.fetchData(type: "GET",
                               apiVesrion: "v2",
                               urlPath: "/study-posts",
                               queryItems: queryItems,
                               tokenNeed: false,
                               createPostData: nil) { (result: Result<PostDataContent,
                                                          NetworkError>) in
      switch result {
      case .success(let postData):
        self.newPostDatas = postData
        completion()
      case .failure(let error):
        print("에러:", error)
      }
    }
  }
  
  // MARK: - 스터디 최신순 전체조회
  private var recentPostDatas: PostDataContent?
  
  func getRecentPostDatas() -> PostDataContent? {
    if let data = newPostDatas {
      return data
    } else {
      return nil
    }
  }
  
  func getRecentPostDatas(hotType: String, completion: @escaping () -> Void) {
    let queryItems = [URLQueryItem(name: "hot", value: hotType),
                      URLQueryItem(name: "page", value: "0"),
                      URLQueryItem(name: "size", value: "1"),
                      URLQueryItem(name: "titleAndMajor", value: "false")]
    
    networkingShared.fetchData(type: "GET",
                               apiVesrion: "v2",
                               urlPath: "/study-posts",
                               queryItems: queryItems,
                               tokenNeed: false,
                               createPostData: nil) { [weak self] (result: Result<PostDataContent,
                                                                NetworkError>) in
      switch result {
      case .success(let postData):
        // 추가 데이터 조회를 위한 변수
        var currentPage = 1
        
        if postData.postDataByInquiries.last == false {
          // 추가 데이터 조회
          self?.fetchAdditionalData(hotType: hotType,
                                    currentPage: currentPage + 1,
                                    completion: completion)
        } else {
          self?.newPostDatas = postData
          completion()
        }
      case .failure(let error):
        print("에러:", error)
      }
    }
  }
  
  func fetchAdditionalData(hotType: String, currentPage: Int, completion: @escaping () -> Void) {
    let queryItems = [URLQueryItem(name: "hot", value: hotType),
                      URLQueryItem(name: "page", value: "0"),
                      URLQueryItem(name: "size", value: "\(currentPage)"),
                      URLQueryItem(name: "titleAndMajor", value: "false")]
    networkingShared.fetchData(type: "GET",
                               apiVesrion: "v2",
                               urlPath: "/study-posts",
                               queryItems: queryItems,
                               tokenNeed: false,
                               createPostData: nil) { [weak self] (result: Result<PostDataContent,
                                                                NetworkError>) in
      switch result {
      case .success(let postData):
        if postData.postDataByInquiries.last == false {
          // 추가 데이터 조회
          self?.fetchAdditionalData(hotType: hotType,
                                    currentPage: currentPage + 1,
                                    completion: completion)
        } else {
          // 중복된 데이터 필터링
          let newContent = postData.postDataByInquiries.content.filter { post -> Bool in
            if let existingContent = self?.newPostDatas?.postDataByInquiries.content {
              return !existingContent.contains { $0.postID == post.postID }
            }
            return true
          }
          
          // 중복을 제거한 데이터를 추가
          self?.newPostDatas?.postDataByInquiries.content.append(contentsOf: newContent)
          completion()
        }
      case .failure(let error):
        print("에러:", error)
      }
    }
  }
  
  
}
