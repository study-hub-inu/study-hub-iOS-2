//
//  Networking.swift
//  STUDYHUB2
//
//  Created by 최용헌 on 2023/12/22.
//

import Foundation

final class Networking {
  static let networkinhShared = Networking()
  
  let tokenManager = TokenManager.shared
  
  typealias NetworkCompletion<T: Codable> = (Result<T, NetworkError>) -> Void
  
  // 네트워킹 요청을 생성하는 메서드
  func createRequest<T: Codable>(url: URL,
                     method: String,
                     tokenNeed: Bool,
                     createPostData: T?) -> URLRequest {
    var request = URLRequest(url: url)
    request.httpMethod = method
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
   
   if tokenNeed == true {
     guard var token = tokenManager.loadAccessToken() else { return request}
     request.setValue("\(token)", forHTTPHeaderField: "Authorization")
     
     guard let uploadData = try? JSONEncoder().encode(createPostData) else { return request }
     request.httpBody = uploadData
   }
    
    return request
  }
  
  // API 응답을 디코딩하는 메서드
 func decodeResponse<T: Codable>(data: Data, completion: NetworkCompletion<T>) {
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
  func fetchData<T: Codable>(type: String,
                               urlPath: String,
                               queryItems: [URLQueryItem]?,
                               tokenNeed: Bool,
                               createPostData: T?,
                               completion: @escaping NetworkCompletion<T>) {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "study-hub.site"
    urlComponents.port = 443
    urlComponents.path = "/api/v1" + urlPath
    
    urlComponents.queryItems = queryItems
    
    guard let url = urlComponents.url else {
      print("Invalid URL")
      completion(.failure(.networkingError))
      return
    }
    
    let request = createRequest(url: url,
                                method: type,
                                tokenNeed: tokenNeed,
                                createPostData: createPostData)
    
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
}
