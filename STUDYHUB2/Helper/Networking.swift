//
//  Networking.swift
//  STUDYHUB2
//
//  Created by 최용헌 on 2023/12/22.
//

import Foundation

import Moya
import UIKit

enum networkingAPI {
  case storeImage(_image: UIImage)
  case editUserNickName(_nickname: String)
  case editUserMaojr(_major: String)
  case editUserPassword(_checkPassword: Bool, _password: String)
  case verifyPassword(_password: String)
}

extension networkingAPI: TargetType {
  var baseURL: URL {
    return URL(string: "https://study-hub.site:443/api")!
  }

  var path: String {
    switch self {
    case .storeImage(_image: _):
      return "/v1/users/image"
    case .editUserNickName(_nickname: _):
      return "/v1/users/nickname"
    case .editUserMaojr(_major: _):
      return "/v1/users/major"
    case .editUserPassword(_checkPassword: _, _password: _):
      return "/v1/users/password"
    case .verifyPassword(_password: _):
      return "/v1/users/password/verify"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .storeImage(_image: _):
      return .put
    case .editUserNickName(_nickname: _):
      return .put
    case .editUserMaojr(_major: _):
      return .put
    case .editUserPassword(_checkPassword: _, _password: _):
      return .put
    case .verifyPassword(_password: _):
      return .post
    }
  }
  
  var task: Moya.Task {
    switch self {
    // 파라미터로 요청
    case .storeImage(let image):
      let imageData = image.jpegData(compressionQuality: 0.5)
      let formData = MultipartFormBodyPart(provider: .data(imageData!), name: "image",
                                           fileName: "image.jpg", mimeType: "image/jpeg")
      return .uploadMultipartFormData([formData])
      
    // 바디에 요청
    case .editUserNickName(let nickname):
      let params = EditNickName(nickname: nickname)
      return .requestJSONEncodable(params)
    case .editUserMaojr(let major):
      let params = EditMajor(major: major)
      return .requestJSONEncodable(params)
    case .editUserPassword(let checkPassword, let password):
      let params = EditPassword(auth: checkPassword, password: password)
      return .requestJSONEncodable(params)
    case .verifyPassword(let password):
      let params: [String: Any] = [
        "password": password
      ]
      return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
    }
  }
  
  var headers: [String : String]? {
    guard let acceessToken = TokenManager.shared.loadAccessToken() else { return nil}
    return ["Content-type": "application/json",
            "Content-Type" : "multipart/form-data",
            "Accept": "application/json",
            "Authorization": "\(acceessToken)"]
  }
}

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
     guard let token = tokenManager.loadAccessToken() else { return request}
     request.setValue("\(token)", forHTTPHeaderField: "Authorization")
     
     if createPostData != nil {
       guard let uploadData = try? JSONEncoder().encode(createPostData) else { return request }
       request.httpBody = uploadData
     }
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
                             apiVesrion: String,
                               urlPath: String,
                               queryItems: [URLQueryItem]?,
                               tokenNeed: Bool,
                               createPostData: T?,
                               completion: @escaping NetworkCompletion<T>) {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "study-hub.site"
    urlComponents.port = 443
    urlComponents.path = "/api/" + apiVesrion + urlPath
    
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
