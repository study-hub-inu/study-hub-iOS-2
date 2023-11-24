
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
  
  // MARK: - 내가 쓴 게시글 정보 가져오기
  private func fetchMyPostInfo(completion: @escaping NetworkCompletion) {
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
    getMyPostInfo(with: urlString, token: token, completion: completion)
  }
  
  private func getMyPostInfo(with urlString: String, token: String, completion: @escaping NetworkCompletion) {
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
  
  
  // 내가 쓴 게시글 정보
  private var myPostDatas: [MyPostInfo] = []
  
  func getMyPostData() -> [MyPostInfo] {
    return myPostDatas
  }
  
  func getMyPostDataFromApi(completion: @escaping () -> Void) {
    fetchMyPostInfo { result in
      switch result {
      case .success(let myPostData):
        let extractedData: [MyPostInfo] = myPostData.getMyPostData.content.map { content in
          var myPostData = MyPostInfo(
            close: content.close,
            content: content.content,
            major: content.major,
            postId: content.postId,
            remainingSeat: content.remainingSeat,
            title: content.title
          )
          return myPostData
        }
        self.myPostDatas = extractedData
        completion()
      case .failure(let error):
        switch error {
        case .networkingError:
          print("네트워크 에러")
        case .dataError:
          print("데이터 에러")
        case .parseError:
          print("파싱 에러")
        }
      }
    }
  }
  
  // MARK: - 내가 쓴 게시글 삭제
  typealias DeleteNetworkCompletion = (Result<Void, NetworkError>) -> Void

  func fetchDeletePostInfo(postID: Int, completion: @escaping DeleteNetworkCompletion) {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "study-hub.site"
    urlComponents.port = 443
    urlComponents.path = "/api/study-posts/\(postID)"

    guard var token = tokenManager.loadAccessToken() else { return }
    
    guard let urlString = urlComponents.url?.absoluteString else {
      print("Invalid URL")
      completion(.failure(.networkingError))
      return
    }
    deleteMyPost(with: urlString, token: token, completion: completion)
  }
  
  private func deleteMyPost(with urlString: String,
                            token: String,
                            completion: @escaping DeleteNetworkCompletion) {
    guard let url = URL(string: urlString) else {
      print("Invalid URL")
      completion(.failure(.networkingError))
      return
    }
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
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
        let deleteAccepted = String(data: safeData, encoding: .utf8)
        completion(.success(()))
      } catch {
        print("JSON Parsing Error:", error)
        completion(.failure(.parseError))
      }
    }.resume()
  }
}



