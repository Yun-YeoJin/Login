//
//  LoginViewController.swift
//  Login
//
//  Created by 윤여진 on 2022/11/02.
//

import UIKit

import RxCocoa
import RxSwift

final class LoginViewController: BaseViewController {
    
    let mainView = LoginView()
    
    let viewModel = LoginViewModel()
    
    var disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "개발하는 윤기사"
        navigationItem.titleView?.tintColor = .label
        
        mainView.signupButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
        
        view.backgroundColor = .systemBackground
        
        bindData()
        
        
    }
    
    @objc func signupButtonClicked() {
        
        let vc = SignupViewController()
        transition(vc, transitionStyle: .push)
        
    }
    
    func bindData() {
        
        viewModel.email
            .asDriver()
            .drive(mainView.emailTextField.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.password
            .asDriver()
            .drive(mainView.passwordTextField.rx.text)
            .disposed(by: disposeBag)
        
        mainView.emailTextField.rx.text.orEmpty
            .asDriver()
            .drive(onNext: { [weak self] text in
                self?.viewModel.email.accept(text)
            })
            .disposed(by: disposeBag)
        
        mainView.passwordTextField.rx.text.orEmpty
            .asDriver()
            .drive(onNext: { [weak self] text in
                self?.viewModel.password.accept(text)
            })
            .disposed(by: disposeBag)
        
        viewModel.isValid
            .asDriver(onErrorJustReturn: false)
            .drive(mainView.loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.isValid
            .map { $0 == true ? UIColor.systemMint : UIColor.opaqueSeparator }
            .asDriver(onErrorJustReturn: .opaqueSeparator)
            .drive(mainView.loginButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        mainView.loginButton.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                vc.viewModel.requestLogin()
            }
            .disposed(by: disposeBag)
        
        viewModel.isOK
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe { vc, value in
                if value {
                    vc.navigationController?.pushViewController(ProfileViewController(), animated: true)
                    vc.showSesacAlert(title: "로그인에 성공했습니다.", message: "", buttonTitle: "확인")
                }
                
            } onError: { error in
                self.showSesacAlert(title: "로그인에 실패했습니다.", message: "다시 확인해보세요", buttonTitle: "확인")
            }
            .disposed(by: disposeBag)
    }
    
    
}
