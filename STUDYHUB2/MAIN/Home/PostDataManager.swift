//
//  PostDataManager.swift
//  STUDYHUB2
//
//  Created by 최용헌 on 2023/11/15.
//

import Foundation

// MARK: - PostData
struct PostData: Codable {
  let content: [Content]
}

// MARK: - Content
struct Content: Codable {
  let postID: Int
  let major, title, content: String
  let leftover: Int, studyPerson: Int
  let close: Bool
  
  enum CodingKeys: String, CodingKey {
    case postID = "postId"
    case major, title, content, leftover, studyPerson, close
  }
}

//MARK: - Networking (서버와 통신하는) 클래스 모델
final class PostDataManager {
  
  static let shared = PostDataManager()
  private init() {}
  
  typealias NetworkCompletion = (Result<PostData, NetworkError>) -> Void
  
  // 네트워킹 요청하는 함수
  func fetchUser(completion: @escaping NetworkCompletion) {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "study-hub.site"
    urlComponents.port = 443
    urlComponents.path = "/api/v1/study-posts/find/all"
    
    let queryItem1 = URLQueryItem(name: "page", value: "0")
    let queryItem2 = URLQueryItem(name: "size", value: "5")
    
    urlComponents.queryItems = [queryItem1, queryItem2]
    
    guard let urlString = urlComponents.url?.absoluteString else {
      print("Invalid URL")
      completion(.failure(.networkingError))
      return
    }
    
    getMethod(with: urlString, completion: completion)
  }
  
  private func getMethod(with urlString: String, completion: @escaping NetworkCompletion) {
    guard let url = URL(string: urlString) else {
      print("Invalid URL")
      completion(.failure(.networkingError))
      return
    }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
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
      
      do {
        let decoder = JSONDecoder()
        let userData = try decoder.decode(PostData.self, from: safeData)
        completion(.success(userData))
      } catch {
        print("JSON Parsing Error:", error)
        completion(.failure(.parseError))
      }
    }.resume()
  }
}

