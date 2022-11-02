//
//  LoginView.swift
//  Login
//
//  Created by 윤여진 on 2022/11/02.
//

import UIKit

import SnapKit
import Then

class LoginView: BaseView {
    
    let loginLabel = UILabel().then {
        $0.text = "로그인"
        $0.font = .boldSystemFont(ofSize: 28)
        $0.textColor = .label
    }
    
    let emailTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "가입한 이메일 주소 입력", attributes: [NSAttributedString.Key.foregroundColor : Constants.BaseColor.placeholder])
        $0.backgroundColor = Constants.BaseColor.textFieldBackground
        $0.layer.cornerRadius = Constants.Design.cornerRadius
        $0.textAlignment = .center
    }
    
    let passwordTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "비밀번호 입력", attributes: [NSAttributedString.Key.foregroundColor : Constants.BaseColor.placeholder])
        $0.backgroundColor = Constants.BaseColor.textFieldBackground
        $0.layer.cornerRadius = Constants.Design.cornerRadius
        $0.textAlignment = .center
        $0.keyboardType = .default
        $0.textContentType = .oneTimeCode
        $0.isSecureTextEntry = true

    }
    
    let loginButton = UIButton().then {
        $0.setTitle("로그인하기", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.tintColor = .white
        $0.backgroundColor = .systemMint
        $0.layer.cornerRadius = Constants.Design.cornerRadius
    }
    
    let signupButton = UIButton().then {
        $0.setTitle("회원가입하기", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.tintColor = .white
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = Constants.Design.cornerRadius
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func configureUI() {
        
        [loginLabel, emailTextField, passwordTextField, loginButton, signupButton].forEach {
            self.addSubview($0)
        }
        
    }
    
    override func setConstraints() {
        
        loginLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.height.equalTo(44)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(loginLabel.snp.bottom).offset(30)
            make.height.equalTo(60)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(emailTextField.snp.bottom).offset(12)
            make.height.equalTo(60)
        }
        
        loginButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.height.equalTo(60)
        }
        
        signupButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.height.equalTo(60)
        }
        
        
        
    }
    
}
