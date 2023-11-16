//
//  File.swift
//  STUDYHUB2
//
//  Created by 최용헌 on 2023/10/12.
//

import UIKit

class LoginManager: UIViewController {
  
  let tokenManager = TokenManager.shared
  static let shared = LoginManager()
  
  func autoLogin() {
    guard let autoLoginURL = URL(string: "https://study-hub.site:443/api/jwt/accessToken") else {
      return
    }
    
    guard let refreshToken = tokenManager.loadRefreshToken() else {
      return
    }
    
    let tokenData: [String: Any] = [
      "refreshToken": refreshToken
    ]
    
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: tokenData, options: [])
      // Create a URLRequest with the login URL
      var request = URLRequest(url: autoLoginURL)
      request.httpMethod = "POST"
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      request.httpBody = jsonData
      
      // Create a URLSessionDataTask to perform the request
      let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
        // Handle the response
        if let response = response as? HTTPURLResponse {
          switch response.statusCode {
          case 200:
            // Login successful
            if let data = data {
              do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                  if let data = json["data"] as? [String: Any],
                     let accessToken = data["accessToken"] as? String,
                     let refreshToken = data["refreshToken"] as? String {
                    // Store the access token in Keychain
                    print("refresh: " + refreshToken)
                    print("access: " + accessToken)
                  }
                }
              } catch {
                // Handle JSON parsing error
                print("JSON Parsing Error: \(error)")
              }
            }
          case 401:
            // Token expired
            print("토큰이 만료되었습니다.")
          default:
            // Handle other status codes
            print("통신 실패 - 상태 코드: \(response.statusCode)")
          }
        } else if let error = error {
          // Handle network error
          print("네트워크 에러: \(error.localizedDescription)")
        }
      }
      
      // Start the URLSessionDataTask
      task.resume()
      
    } catch {
      // Handle JSON serialization error
      print("JSON Serialization Error: \(error)")
    }
  }

  
  func login(email: String, password: String ){
    guard let loginURL = URL(string: "https://study-hub.site:443/api/users/login") else {
      return
    }
    
    // Create a dictionary to represent the login data
    let loginData: [String: Any] = [
      "email": email,
      "password": password
    ]
    
    // Convert the loginData dictionary to JSON data
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: loginData, options: [])
      
      // Create a URLRequest with the login URL
      var request = URLRequest(url: loginURL)
      request.httpMethod = "POST"
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      request.httpBody = jsonData
      
      // Create a URLSessionDataTask to perform the request
      let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
        // Handle the response
        if let data = data,
           let response = response as? HTTPURLResponse,
           response.statusCode == 200 {
          // Login successful
          do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
              if let data = json["data"] as? [String: Any],
                 let accessToken = data["accessToken"] as? String,
                 let refreshToken = data["refreshToken"] as? String{
                // Store the access token in Keychain
                print("refresh:" + refreshToken)
                print("access:" + accessToken)
                
                self?.tokenManager.deleteTokens()
                self?.tokenManager.saveTokens(accessToken: accessToken,
                                              refreshToken: refreshToken)
              }
            }
            
          } catch {
            // Handle JSON parsing error
            print("JSON Parsing Error: \(error)")
          }
        } else {
          // Login failed, show an alert
          DispatchQueue.main.async {
            self?.alertShow(title: "로그인 실패", message: "존재하지 않는 사용자입니다.")
          }
        }
      }
      
      // Start the URLSessionDataTask
      task.resume()
      
    } catch {
      // Handle JSON serialization error
      print("JSON Serialization Error: \(error)")
    }
  }
}


