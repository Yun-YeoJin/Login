//
//  APIService.swift
//  Login
//
//  Created by 윤여진 on 2022/11/02.
//

import Alamofire
import UIKit

import RxCocoa
import RxSwift

struct Login: Codable {
    let token: String
}

struct User: Codable {
    let photo: String
    let email: String
    let username: String
}

struct Profile: Codable {
    let user: User
}

class APIService {
    
    func signup(username: String, email: String, password: String) {
        let api = SeSACAPI.signup(userName: username, email: email, password: password)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.header).responseString { response in
            
            print(response)
            print(response.response?.statusCode)
            
        }
        
    }
    
    func login(email: String, password: String) {
        let api = SeSACAPI.login(email: email, password: password)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.header)
            .validate(statusCode: 200...299)
            .responseDecodable(of: Login.self) { response in
                
                switch response.result {
                    
                case .success(let data): //200번대만 성공
                    print(data.token)
                    UserDefaults.standard.set(data.token, forKey: "token")
                    
                case .failure(_): //나머지는 실패
                    print(response.response?.statusCode)
                }
            }
    }
    
    func profile() {
        
        let url = SeSACAPI.profile.url
        let header: HTTPHeaders = SeSACAPI.profile.header
        
        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: Profile.self) { response in
                
                switch response.result {
                    
                case .success(let data): //200번대만 성공
                    print(data)
                    
                case .failure(_): //나머지는 실패
                    print(response.response?.statusCode)
                }
                
            }
    }
    
}

//class SeSACAPIManager {
//
//    static func requestSeSAC(completion: @escaping (Profile?) -> Void ) {
//
//        let sourceURL = SeSACAPI.profile.url
//
//        var request = URLRequest(url: sourceURL)
//
//        request.setValue("\(SeSACAPI.profile.header)", forHTTPHeaderField: "Authorization")
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//
//            if let _ = error {
//                print(error)
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse,(200...299).contains(response.statusCode) else { return }
//
//            if let data = data, let profileData = try?
//                JSONDecoder().decode(Profile.self, from: data) {
//                completion(profileData)
//                return
//            }
//            completion(nil)
//
//        }.resume()
//
//    }
//
//
//}







