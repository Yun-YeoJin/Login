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

class APIService {
    
    static let shared = APIService()
    
    private init() { }
    
    func requestSeSAC<T: Decodable>(type: T.Type = T.self, url: URL, method: HTTPMethod, parameters: [String:String]? = nil, headers: HTTPHeaders, completion: @escaping (Result<T, Error>) -> Void) {
        
        AF.request(url, method: .get, parameters: parameters, headers: headers)
            .responseDecodable(of: type) { response in
                
                switch response.result {
                    
                case .success(let data): //200번대만 성공
                    completion(.success(data)) //탈출 클로저, enum 등
                    
                case .failure(let error): //나머지는 실패
                    
                    guard let statusCode = response.response?.statusCode else { return }
                    guard let error = SeSACError(rawValue: statusCode) else { return }
                    
                    completion(.failure(error))
                }
                
            }
    }
}








