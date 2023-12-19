//
//  PostDataManager.swift
//  STUDYHUB2
//
//  Created by 최용헌 on 2023/11/15.
//

import Foundation

// MARK: - newPost 구조체
struct PostData: Codable {
  var content: [PostDataContent]
  let last: Bool
  let numberOfElements: Int
}

// MARK: - Content
struct PostDataContent: Codable {
  let postID: Int
  let major, title: String
  let studyStartDate, studyEndDate, createdDate: [Int]
  let filteredGender: String
  let studyPerson: Int
  let penalty: Int
  let remainingSeat: Int
  let close: Bool
  let userData: PostUserData
  let bookmarked: Bool
  
  enum CodingKeys: String, CodingKey {
    case postID = "postId"
    case major, title, studyPerson, penalty, remainingSeat, close, userData, bookmarked,
         studyStartDate, studyEndDate,createdDate, filteredGender
  }
}

struct PostUserData: Codable {
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
  
  typealias NetworkCompletion<T: Decodable> = (Result<T, NetworkError>) -> Void
  
  // 네트워킹 요청을 생성하는 메서드
  private func createRequest(url: URL, method: String) -> URLRequest {
    var request = URLRequest(url: url)
    request.httpMethod = method
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    return request
  }
  
  // API 응답을 디코딩하는 메서드
  private func decodeResponse<T: Decodable>(data: Data, completion: NetworkCompletion<T>) {
    do {
      let decoder = JSONDecoder()
      let responseData = try decoder.decode(T.self, from: data)
      completion(.success(responseData))
    } catch {
      print("JSON Parsing Error:", error)
      completion(.failure(.parseError))
    }
  }
  
  // 네트워킹 요청하는 메서드
  private func fetchData<T: Decodable>(type: String,
                                       urlPath: String,
                                       hotType: String,
                                       titleAndMajor: String,
                                       numOfResult: String,
                                       completion: @escaping NetworkCompletion<T>) {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "study-hub.site"
    urlComponents.port = 443
    urlComponents.path = "/api/v1" + urlPath
    
    let queryItem1 = URLQueryItem(name:"hot", value: hotType)
    let queryItem2 = URLQueryItem(name: "page", value: "0")
    let queryItem3 = URLQueryItem(name: "size", value: numOfResult)
    let queryItem4 = URLQueryItem(name: "titleAndMajor", value: titleAndMajor)
    
    urlComponents.queryItems = [queryItem1, queryItem2, queryItem3, queryItem4]
    
    guard let url = urlComponents.url else {
      print("Invalid URL")
      completion(.failure(.networkingError))
      return
    }
    
    let request = createRequest(url: url, method: type)
    
    URLSession.shared.dataTask(with: request) { data, response, error in
      if let error = error {
        print("Networking Error:", error)
        completion(.failure(.networkingError))
        return
      }
      
      guard let safeData = data else {
        print("No Data")
        completion(.failure(.dataError))
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse else {
        print("Invalid Response")
        completion(.failure(.networkingError))
        return
      }
      
      print("Response Status Code:", httpResponse.statusCode)
      
      self.decodeResponse(data: safeData, completion: completion)
    }.resume()
  }
  
  // MARK: - new 모집 중인 스터디
  private var newPostDatas: PostData?
  
  func getNewPostDatas() -> PostData? {
    if let data = newPostDatas {
      return data
    } else {
      // 처리할 값이 없는 경우에 대한 처리를 수행합니다.
      return nil
    }
  }
  
  func getNewPostData(completion: @escaping() -> Void){
    fetchData(type: "GET",
              urlPath: "/study-posts",
              hotType: "false",
              titleAndMajor: "false",
              numOfResult: "5") { (result: Result<PostData,
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
  private var deadlinePostDatas: PostData?
  
  func getDeadLinePostDatas() -> PostData? {
    if let data = newPostDatas {
      return data
    } else {
      return nil
    }
  }
  
  func getDeadLinePostData(completion: @escaping() -> Void){
    fetchData(type: "GET",
              urlPath: "/study-posts",
              hotType: "true",
              titleAndMajor: "true",
              numOfResult: "4") { (result: Result<PostData,
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
  private var recentPostDatas: PostData?
  
  func getRecentPostDatas() -> PostData? {
    if let data = newPostDatas {
      return data
    } else {
      return nil
    }
  }
  
  func getRecentPostDatas(completion: @escaping () -> Void) {
    fetchData(type: "GET",
              urlPath: "/study-posts",
              hotType: "false",
              titleAndMajor: "false",
              numOfResult: "1") { [weak self] (result: Result<PostData, NetworkError>) in
      switch result {
      case .success(let postData):
        // 추가 데이터 조회를 위한 변수
        var currentPage = 1
        
        if postData.last == false {
          // 추가 데이터 조회
          self?.fetchAdditionalData(currentPage: currentPage + 1, completion: completion)
        } else {
          self?.newPostDatas = postData
          completion()
        }
      case .failure(let error):
        print("에러:", error)
      }
    }
  }
  
  func fetchAdditionalData(currentPage: Int, completion: @escaping () -> Void) {
    fetchData(type: "GET",
              urlPath: "/study-posts",
              hotType: "false",
              titleAndMajor: "false",
              numOfResult: "\(currentPage)") { [weak self] (result: Result<PostData, NetworkError>) in
      switch result {
      case .success(let postData):
        if postData.last == false {
          // 추가 데이터 조회
          self?.fetchAdditionalData(currentPage: currentPage + 1, completion: completion)
        } else {
          // 중복된 데이터 필터링
          let newContent = postData.content.filter { post -> Bool in
            if let existingContent = self?.newPostDatas?.content {
              return !existingContent.contains { $0.postID == post.postID }
            }
            return true
          }

          // 중복을 제거한 데이터를 추가
          self?.newPostDatas?.content.append(contentsOf: newContent)
          completion()
        }
      case .failure(let error):
        print("에러:", error)
      }
    }
  }
  
  
}
