//
//  SignupViewModel.swift
//  Login
//
//  Created by 윤여진 on 2022/11/02.
//

import Foundation

import Alamofire
import RxCocoa
import RxSwift

protocol CommonViewModel {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

final class SignupViewModel2 {
        
    var nickName = BehaviorRelay<String>(value: "닉네임을 입력해주세요")
    var email = BehaviorRelay<String>(value: "올바른 이메일을 입력해주세요")
    var password = BehaviorRelay<String>(value: "8자리 이상 비밀번호를 입력해주세요")
    var isOK = BehaviorSubject<Bool>(value: false)
    
    var isValid: Observable<Bool> {
        return Observable
            .combineLatest(email, password)
            .map { email, password in
                print(email, password)
                return email.count > 0 && email.contains("@") && email.contains(".") && password.count >= 8
            }
    }
    
        
    func requestSignup() {
        let api = SeSACAPI.signup(userName: nickName.value,
                                  email: email.value,
                                  password: password.value)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.header).responseString { [weak self] response in
            guard let self = self else { return }

            switch response.result {
            case .success:

                self.isOK.onNext(true)

            case .failure:
                print("error")
            }
        }
    }
}

//TODO: INPUT OUTPUT을 사용해서 하려고 했으나 실패..
final class SignupViewModel: CommonViewModel {
    
    var nickName = BehaviorRelay<String>(value: "닉네임을 입력해주세요")
    var email = BehaviorRelay<String>(value: "이메일을 입력해주세요")
    var password = BehaviorRelay<String>(value: "비밀번호를 입력해주세요")
    
    var isOK = BehaviorSubject<Bool>(value: false)
    
    struct Input {
        let tap: ControlEvent<Void>
        let nickNameText: ControlProperty<String?>
        let emailText: ControlProperty<String?>
        let passwordText: ControlProperty<String?>
        
    }
    
    struct Output {
        let tap: ControlEvent<Void>
        let nickNameText: Driver<String>
        let emailText: Driver<String>
        let passwordText: Driver<String>
        let nickNameValid: Observable<Bool>
        let emailValid: Observable<Bool>
        let passwordValid: Observable<Bool>
    }
    
    func transform(input: Input) -> Output {
        
        let nickNameValid = input.nickNameText
            .orEmpty
            .map { $0.count < 4 }
            .share()
        
        let emailValid = input.emailText
            .orEmpty
            .map { $0.count < 1 }
            .share()
        
        let passwordValid = input.passwordText
            .orEmpty
            .map { $0.count < 8 }
            .share()
        
        
        let nickNameText = nickName.asDriver()
        let emailText = email.asDriver()
        let passwordText = password.asDriver()
        
        return Output(tap: input.tap, nickNameText: nickNameText, emailText: emailText, passwordText: passwordText, nickNameValid: nickNameValid, emailValid: emailValid, passwordValid: passwordValid)
        
    }
    
    func requestSignup() {
        
        let api = SeSACAPI.signup(userName: nickName.value, email: email.value, password: password.value)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.header).responseString { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success:
                self.isOK.onNext(true)
                
            case .failure:
                print("error")
            }
        }
        
        //        APIService.shared.requestSeSAC(type: Login.self, url: api.url, method: .post, parameters: api.parameters, headers: api.header) { [weak self] response in
        //
        //            switch response {
        //            case .success(_):
        //                self?.isOK.onNext(true)
        //
        //            case .failure(let error):
        //                self?.isOK.onError(error)
        //            }
        //
        //        }
        
    }
}

