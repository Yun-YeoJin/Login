//
//  SignupViewModel.swift
//  Login
//
//  Created by 윤여진 on 2022/11/02.
//

import Foundation

import RxCocoa
import RxSwift

protocol CommonViewModel {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

final class SignupViewModel: CommonViewModel {
  
    let nickNameValidText = BehaviorRelay(value: "닉네임은 3자 이상 입력해주세요.")
    let emailValidText = BehaviorRelay(value: "올바른 이메일을 입력해주세요.")
    let passwordValidText = BehaviorRelay(value: "비밀번호는 최소 6자 이상 입력해주세요.")
    
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
            .map { $0.count < 3 }
            .share()
        
        let emailValid = input.emailText
            .orEmpty
            .map { $0.count < 1 }
            .share()
        
        let passwordValid = input.passwordText
            .orEmpty
            .map { $0.count < 6 }
            .share()
    
        
        let nickNameText = nickNameValidText.asDriver()
        let emailText = emailValidText.asDriver()
        let passwordText = passwordValidText.asDriver()
        
        return Output(tap: input.tap, nickNameText: nickNameText, emailText: emailText, passwordText: passwordText, nickNameValid: nickNameValid, emailValid: emailValid, passwordValid: passwordValid)
        
    }
    
    
}
