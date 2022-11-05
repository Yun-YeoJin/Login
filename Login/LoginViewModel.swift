//
//  LoginViewModel.swift
//  Login
//
//  Created by 윤여진 on 2022/11/02.
//

import Foundation

import Alamofire
import RxCocoa
import RxSwift

final class LoginViewModel {
    
    var email: BehaviorRelay = BehaviorRelay<String>(value: "")
    var password: BehaviorRelay = BehaviorRelay<String>(value: "")
    
    var isOK = BehaviorRelay<Bool>(value: false)
    
    var isValid: Observable<Bool> {
        return Observable
            .combineLatest(email, password)
            .map { email, password in
                print(email, password)
                return email.count > 0 && email.contains("@") && email.contains(".") && password.count >= 8
            }
    }
    
    func requestLogin() {
        let api = SeSACAPI.login(email: email.value, password: password.value)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.header).responseDecodable(of: Login.self) { [weak self] response in
            guard let self = self else { return }
            guard let value = response.value else { return }

            switch response.result {
            case .success:
                UserDefaults.standard.set(value.token, forKey: "token")
                self.isOK.accept(true)

            case .failure:
                print("error")
            }
        }
    }
}
