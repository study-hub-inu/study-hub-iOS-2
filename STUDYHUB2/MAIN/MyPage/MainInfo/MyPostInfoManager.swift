

import Foundation

struct MyPostData: Codable {
    let getMyPostData: GetMyPostData
}

struct GetMyPostData: Codable {
    let content: [MyPostInfo]
}

struct MyPostInfo: Codable {
    let close: Bool
    let content, major: String
    let postId, remainingSeat: Int
    let title: String
}


//MARK: - Networking (서버와 통신하는) 클래스 모델
final class MyPostInfoManager {
  
  let tokenManager = TokenManager.shared
  static let shared = MyPostInfoManager()
  private init() {}
  
  typealias NetworkCompletion = (Result<MyPostData, NetworkError>) -> Void
  
  // 네트워킹 요청하는 함수
  func fetchUser(completion: @escaping NetworkCompletion) {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "study-hub.site"
    urlComponents.port = 443
    urlComponents.path = "/api/study-posts/find/mypost"

    guard var token = tokenManager.loadAccessToken() else { return }
    
    let queryItem1 = URLQueryItem(name: "page", value: "0")
    let queryItem2 = URLQueryItem(name: "size", value: "5")
    
    urlComponents.queryItems = [queryItem1, queryItem2]
    
    guard let urlString = urlComponents.url?.absoluteString else {
      print("Invalid URL")
      completion(.failure(.networkingError))
      return
    }
    getMethod(with: urlString, token: token, completion: completion)
  }
  
  private func getMethod(with urlString: String, token: String, completion: @escaping NetworkCompletion) {
    guard let url = URL(string: urlString) else {
      print("Invalid URL")
      completion(.failure(.networkingError))
      return
    }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("\(token)", forHTTPHeaderField: "Authorization")

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
        let userData = try decoder.decode(MyPostData.self, from: safeData)
        completion(.success(userData))
      } catch {
        print("JSON Parsing Error:", error)
        completion(.failure(.parseError))
      }
    }.resume()
  }
}

