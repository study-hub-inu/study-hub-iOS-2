//
//  PostDataManager.swift
//  STUDYHUB2
//
//  Created by 최용헌 on 2023/11/15.
//

import Foundation

// MARK: - MyPostData
struct NewPostData: Codable {
  let content: [NewPostDataContent]
}

// MARK: - Content
struct NewPostDataContent: Codable {
  let postID: Int
  let major, title: String
  let studyPerson: Int
  let penalty: Int
  let remainingSeat: Int
  let close: Bool
  let userData: NewPostUserData
  let bookmarked: Bool
  
  enum CodingKeys: String, CodingKey {
    case postID = "postId"
    case major, title, studyPerson, penalty, remainingSeat, close, userData, bookmarked
  }
}

// MARK: - UserData
struct NewPostUserData: Codable {
  let userID: Int
  let major: String
  
  enum CodingKeys: String, CodingKey {
    case userID = "userId"
    case major
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
                                       completion: @escaping NetworkCompletion<T>) {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "study-hub.site"
    urlComponents.port = 443
    urlComponents.path = "/api/v1" + urlPath
    
    let queryItem1 = URLQueryItem(name:"hot", value: "false")
    let queryItem2 = URLQueryItem(name: "page", value: "0")
    let queryItem3 = URLQueryItem(name: "size", value: "5")
    let queryItem4 = URLQueryItem(name: "titleAndMajor", value: "true")
    
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
  
  // 사용자 데이터를 가져오는 메서드
  func fetchUserData<T: Decodable>(type: String,
                                   urlPath: String,
                                   completion: @escaping NetworkCompletion<T>) {
    fetchData(type: type, urlPath: urlPath, completion: completion)
  }
  
}
