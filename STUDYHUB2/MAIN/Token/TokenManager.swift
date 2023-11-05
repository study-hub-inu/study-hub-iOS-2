//
//  TokenManager.swift
//  STUDYHUB2
//
//  Created by 최용헌 on 2023/10/06.
//

import Foundation
import Security

final class TokenManager {
  
  // MARK: Shared instance
  static let shared = TokenManager()
  private init() { }
  
  // MARK: Keychain
  
  private let account = "accessToken"
  private let service = Bundle.main.bundleIdentifier
  
  private lazy var query: [CFString: Any]? = {
    guard let service = self.service else { return nil }
    return [kSecClass: kSecClassGenericPassword,
      kSecAttrService: service,
      kSecAttrAccount: account]
  }()
  
  func saveAccessToken(_ accessToken: String) -> Bool {
    guard let service = self.service,
          let data = accessToken.data(using: .utf8) else { return false }
    
    let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                            kSecAttrService: service,
                            kSecAttrAccount: account,
                              kSecValueData: data]
    
    // Keychain에 refresh token을 저장합니다.
    return SecItemAdd(query as CFDictionary, nil) == errSecSuccess
  }
  
  func loadAccessToken() -> String? {
    guard let service = self.service else { return nil }
    let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                            kSecAttrService: service,
                            kSecAttrAccount: account,
                             kSecMatchLimit: kSecMatchLimitOne,
                             kSecReturnData: true]
    
    var item: CFTypeRef?
    if SecItemCopyMatching(query as CFDictionary, &item) != errSecSuccess { return nil }
    
    guard let data = item as? Data,
          let accessToken = String(data: data, encoding: .utf8) else { return nil }
    
    return accessToken
  }
  
  func deleteAccessToken() -> Bool {
    guard let query = self.query else { return false }
    return SecItemDelete(query as CFDictionary) == errSecSuccess
  }
}
