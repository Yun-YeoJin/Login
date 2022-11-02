//
//  SignupViewController.swift
//  Login
//
//  Created by 윤여진 on 2022/11/02.
//

import UIKit

import RxCocoa
import RxSwift

final class SignupViewController: BaseViewController {
    
    private let mainView = SignupView()
    
    private let viewModel = SignupViewModel()
    
    var disposeBag = DisposeBag()
    
    private let api = APIService()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
        
        
        view.backgroundColor = .systemBackground
        
    }
    
    private func bindData() {
        
        let input = SignupViewModel.Input(tap: mainView.signupButton.rx.tap, nickNameText: mainView.nickNameTextField.rx.text, emailText: mainView.emailTextField.rx.text, passwordText: mainView.passwordTextField.rx.text)
        
        let output = viewModel.transform(input: input)
        
        output.nickNameText
            .drive(mainView.nickNameValidLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.emailText
            .drive(mainView.emailValidLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.passwordText
            .drive(mainView.passwordValidLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.nickNameValid
            .bind(to: mainView.emailTextField.rx.isHidden, mainView.nickNameValidLabel.rx.isEnabled, mainView.passwordTextField.rx.isHidden,
                  mainView.signupButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.emailValid
            .bind(to: mainView.passwordTextField.rx.isHidden,
                  mainView.signupButton.rx.isHidden,
                  mainView.emailValidLabel.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.passwordValid
            .bind(to: mainView.signupButton.rx.isEnabled, mainView.passwordValidLabel.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.passwordValid
            .withUnretained(self)
            .bind { vc, value in
                let color: UIColor = value ? .systemGray : .systemMint
                vc.mainView.signupButton.backgroundColor = color
            }
            .disposed(by: disposeBag)
        
        output.tap
            .withUnretained(self)
            .bind { vc, _ in
                vc.api.signup(username: vc.mainView.nickNameTextField.text ?? "", email: vc.mainView.emailTextField.text ?? "", password: vc.mainView.passwordTextField.text ?? "")
                vc.showSesacAlert(title: "회원가입이 완료되었습니다!", message: "축하드립니다!", buttonTitle: "확인")
            }
            .disposed(by: disposeBag)
        
    }
    
}
