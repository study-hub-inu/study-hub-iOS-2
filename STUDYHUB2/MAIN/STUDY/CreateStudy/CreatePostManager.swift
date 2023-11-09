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
//    let penaltyWay: String
  var studyEndDate: String
  var studyPerson: Int
  var studyStartDate, studyWay, title: String
  
}

//MARK: - Networking (서버와 통신하는) 클래스 모델
final class PostManager {
  
  let tokenManager = TokenManager.shared
  static let shared = PostManager()
  private init() {}
  
  typealias NetworkCompletion = (Result<CreateStudyRequest, NetworkError>) -> Void
  
  // 네트워킹 요청하는 함수
  func fetchUser(postData: CreateStudyRequest,completion: @escaping NetworkCompletion) {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "study-hub.site"
    urlComponents.port = 443
    urlComponents.path = "/api/study-posts"

    guard var token = tokenManager.loadAccessToken() else { return }
    
    guard let urlString = urlComponents.url?.absoluteString else {
      print("Invalid URL")
      completion(.failure(.networkingError))
      return
    }
    getMethod(with: urlString, postData: postData, token: token, completion: completion)
  }
  
  private func getMethod(with urlString: String, postData: CreateStudyRequest,
                         token: String, completion: @escaping NetworkCompletion) {
    guard let url = URL(string: urlString) else {
      print("Invalid URL")
      completion(.failure(.networkingError))
      return
    }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("\(token)", forHTTPHeaderField: "Authorization")
    
    guard let uploadData = try? JSONEncoder().encode(postData) else { return }
    request.httpBody = uploadData
    
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
        let responseJSON = try JSONSerialization.jsonObject(with: safeData, options: []) as? [String: Any]
        if let response = responseJSON?["response"] as? String, response == "ACCEPTED" {
          print("Post completed successfully.")
        } else {
          print("Post request failed.")
        }
      } catch {
        // 반환되는 값을 알아야함
        
        print("JSON 파싱 에러: \(error.localizedDescription)")
        completion(.failure(.parseError))
      }

    }.resume()
  }
}
