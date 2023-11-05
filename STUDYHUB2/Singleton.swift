import Foundation
import UIKit

class UserManager {
    static let shared = UserManager()

    private var accessToken: String?
    private var refreshToken: String?
    private var isLoggedIn: Bool = false

    private init() {}

    func setAccessToken(_ token: String) {
        accessToken = token
    }

    func getAccessToken() -> String? {
        return accessToken
    }

    func setRefreshToken(_ token: String) {
        refreshToken = token
    }

    func getRefreshToken() -> String? {
        return refreshToken
    }

    func login() {
        isLoggedIn = true
    }

    func logout() {
        accessToken = nil
        refreshToken = nil
        isLoggedIn = false
    }

    func isUserLoggedIn() -> Bool {
        return isLoggedIn
    }

    func hasValidAccessToken() -> Bool {
        // Implement the logic to check if the access token is valid
        // You can compare it with the expiration date or other criteria
        // For now, we'll assume it's valid if it's not nil
        return accessToken != nil
    }

    // Add this method to check the validity of the refresh token
    func hasValidRefreshToken() -> Bool {
        // Implement the logic to check if the refresh token is valid
        // You can compare it with the expiration date or other criteria
        // For now, we'll assume it's valid if it's not nil
        return refreshToken != nil
    }
}
//import Foundation
//
//class UserManager {
//    static let shared = UserManager()
//
//    private var accessToken: String?
//    private var refreshToken: String?
//    private var isLoggedIn: Bool = false
//
//    private init() {}
//
//    func setAccessToken(_ token: String) {
//        accessToken = token
//    }
//
//    func getAccessToken() -> String? {
//        return accessToken
//    }
//
//    func setRefreshToken(_ token: String) {
//        refreshToken = token
//    }
//
//    func getRefreshToken() -> String? {
//        return refreshToken
//    }
//
//    func login() {
//        isLoggedIn = true
//    }
//
//    func logout() {
//        accessToken = nil
//        refreshToken = nil
//        isLoggedIn = false
//    }
//
//    func isUserLoggedIn() -> Bool {
//        return isLoggedIn
//    }
//
//    func hasValidAccessToken() -> Bool {
//
//        return accessToken != nil
//    }
//
//    func hasValidRefreshToken() -> Bool {
//
//        return refreshToken != nil
//    }
//
//    func checkRefreshTokenValidity(completion: @escaping (Bool) -> Void) {
//        guard let refreshToken = refreshToken else {
//            // If refreshToken is nil, consider it invalid
//            completion(false)
//            return
//        }
//
//        // Create a URLRequest for the refreshToken validation
//        var request = URLRequest(url: URL(string: "https://study-hub.site:443/api/jwt/accessToken")!)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        // Construct the request body
//        let requestBody: [String: String] = ["refreshToken": refreshToken]
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
//        } catch {
//            completion(false)
//            return
//        }
//
//        // Create a URLSessionDataTask to perform the request
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let response = response as? HTTPURLResponse {
//                if response.statusCode == 200 {
//                    // Refresh token is valid
//                    completion(true)
//                } else {
//                    // Refresh token is not valid
//                    completion(false)
//                }
//            } else {
//                completion(false)
//            }
//        }.resume()
//    }
//}

//class UserManager {
//    static let shared = UserManager()
//
//    private let accessTokenKey = "AccessToken"
//    private let refreshTokenKey = "RefreshToken"
//
//    // Access Token을 UserDefaults에 저장
//    func setAccessToken(_ token: String) {
//        UserDefaults.standard.set(token, forKey: accessTokenKey)
//    }
//
//    func getAccessToken() -> String? {
//        return UserDefaults.standard.string(forKey: accessTokenKey)
//    }
//
//    // Refresh Token을 UserDefaults에 저장
//    func setRefreshToken(_ token: String) {
//        UserDefaults.standard.set(token, forKey: refreshTokenKey)
//    }
//
//    func getRefreshToken() -> String? {
//        return UserDefaults.standard.string(forKey: refreshTokenKey)
//    }
//
//    // 로그아웃 시 토큰 삭제
//    func clearTokens() {
//        UserDefaults.standard.removeObject(forKey: accessTokenKey)
//        UserDefaults.standard.removeObject(forKey: refreshTokenKey)
//    }
//
//    // Access Token 만료 여부 확인
//    func isAccessTokenExpired() -> Bool {
//        // 여기에서 Access Token의 만료 여부를 확인하고, 만료되었다면 true를 반환합니다.
//        // 실제 만료 여부를 확인하는 로직을 구현해야 합니다.
//        // 예시로 false를 반환하고 있으니, 실제 로직을 구현하세요.
//        return false
//    }
//
//    // Refresh Token을 사용하여 Access Token 갱신
//    func refreshAccessToken(completion: @escaping (String?) -> Void) {
//        guard let refreshToken = getRefreshToken() else {
//            completion(nil) // Refresh Token이 없으면 갱신 불가능
//            return
//        }
//
//        // 서버로 Refresh Token을 전송하고 새로운 Access Token을 받아옴
//        // 서버 요청 및 응답 처리 코드가 들어갑니다.
//        // 새로운 Access Token을 저장
//        let newAccessToken = "새로운 Access Token 값" // 실제 서버 응답에서 받은 토큰으로 대체해야 합니다.
//        setAccessToken(newAccessToken)
//
//        completion(newAccessToken)
//    }
//}

//class UserManager {
//    static let shared = UserManager()
//
//    private var accessToken: String?
//    private var refreshToken: String?
//    private var isLoggedIn: Bool = false // 추가: 로그인 상태를 저장하는 변수
//
//    // 나머지 코드...
//
//    func setAccessToken(_ token: String) {
//        accessToken = token
//    }
//
//    func getAccessToken() -> String? {
//        return accessToken
//    }
//
//    func setRefreshToken(_ token: String) {
//        refreshToken = token
//    }
//
//    func getRefreshToken() -> String? {
//        return refreshToken
//    }
//
//    func login() {
//        isLoggedIn = true // 로그인 상태로 설정
//    }
//
//    func logout() {
//        accessToken = nil
//        refreshToken = nil
//        isLoggedIn = false // 로그아웃 상태로 설정
//    }
//
//    func isUserLoggedIn() -> Bool {
//        return isLoggedIn
//    }
//}
