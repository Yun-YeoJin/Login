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
    
    private let viewModel = SignupViewModel2()
    
    var disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideValidText()
        bindData()
       
        view.backgroundColor = .systemBackground
        
    }
    
    func bindData() {
        
        viewModel.nickName
            .asDriver()
            .drive(mainView.nickNameTextField.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.email
            .asDriver()
            .drive(mainView.emailTextField.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.password
            .asDriver()
            .drive(mainView.passwordTextField.rx.text)
            .disposed(by: disposeBag)
        
        mainView.nickNameTextField.rx.text
            .orEmpty
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: { [weak self] nickName in
                self?.viewModel.nickName.accept(nickName)
            })
            .disposed(by: disposeBag)
        
        mainView.emailTextField.rx.text
            .orEmpty
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: { [weak self] email in
                self?.viewModel.email.accept(email)
            })
            .disposed(by: disposeBag)
        
        mainView.passwordTextField.rx.text
            .orEmpty
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: { [weak self] password in
                self?.viewModel.password.accept(password)
            })
            .disposed(by: disposeBag)
        
        viewModel.isValid
            .asDriver(onErrorJustReturn: false)
            .drive(mainView.signupButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.isValid
            .map { $0 == true ? UIColor.systemMint : UIColor.opaqueSeparator }
            .asDriver(onErrorJustReturn: .opaqueSeparator)
            .drive(mainView.signupButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        mainView.signupButton.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                vc.viewModel.requestSignup()
            }
            .disposed(by: disposeBag)

        viewModel.isOK
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe { vc, value in
                if value {
                    vc.navigationController?.pushViewController(LoginViewController(), animated: true)
                    vc.showSesacAlert(title: "회원가입에 성공했습니다.", message: "바로 로그인하러 가보시죠.", buttonTitle: "확인")
                }
            } onError: { error in
                self.showSesacAlert(title: "회원가입에 실패했습니다.", message: "다시 확인해보세요", buttonTitle: "확인")
            }
            .disposed(by: disposeBag)
    }
    
    func hideValidText() {
        
        mainView.nickNameTextField.rx.controlEvent([.editingDidBegin])
            .withUnretained(self)
            .bind { vc, _ in
                vc.viewModel.nickName.accept("")
            }
            .disposed(by: disposeBag)

        mainView.emailTextField.rx.controlEvent([.editingDidBegin])
            .withUnretained(self)
            .bind { vc, _ in
                vc.viewModel.email.accept("")
            }
            .disposed(by: disposeBag)

        mainView.passwordTextField.rx.controlEvent([.editingDidBegin])
            .withUnretained(self)
            .bind { vc, _ in
                vc.viewModel.password.accept("")
            }
            .disposed(by: disposeBag)
        
    }
    
//    func bindData() {
//
//        let input = SignupViewModel.Input(tap: mainView.signupButton.rx.tap, nickNameText: mainView.nickNameTextField.rx.text, emailText: mainView.emailTextField.rx.text, passwordText: mainView.passwordTextField.rx.text)
//
//        let output = viewModel.transform(input: input)
//
//        output.nickNameText
//            .drive { [weak self] value in
//                self?.viewModel.nickName.accept(value)
//            }
//            .disposed(by: disposeBag)
//
//        output.emailText
//            .drive { [weak self] value in
//                self?.viewModel.email.accept(value)
//            }
//            .disposed(by: disposeBag)
//
//        output.passwordText
//            .drive { [weak self] value in
//                self?.viewModel.email.accept(value)
//            }
//            .disposed(by: disposeBag)
//
//        output.passwordValid
//            .asDriver(onErrorJustReturn: false)
//            .drive(mainView.signupButton.rx.isEnabled)
//            .disposed(by: disposeBag)
//
//        output.passwordValid
//            .withUnretained(self)
//            .bind { vc, value in
//                let color: UIColor = value ? .systemGray : .systemMint
//                vc.mainView.signupButton.backgroundColor = color
//            }
//            .disposed(by: disposeBag)
//
//        output.tap
//            .withUnretained(self)
//            .bind { vc, _ in
//                vc.viewModel.requestSignup()
//            }
//            .disposed(by: disposeBag)
//
//        viewModel.isOK
//            .withUnretained(self)
//            .observe(on: MainScheduler.instance)
//            .subscribe { vc, value in
//                if value {
//                    vc.navigationController?.pushViewController(LoginViewController(), animated: true)
//                    vc.showSesacAlert(title: "회원가입에 성공했습니다.", message: "바로 로그인하시죠.", buttonTitle: "확인")
//                }
//            } onError: { error in
//                self.showSesacAlert(title: "회원가입에 실패했습니다.", message: "제대로 작성했는지 확인하세요.", buttonTitle: "확인")
//            }
//            .disposed(by: disposeBag)
//
//
//    }

}
