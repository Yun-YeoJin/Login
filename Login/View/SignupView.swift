//
//  SignupView.swift
//  Login
//
//  Created by 윤여진 on 2022/11/02.
//

import UIKit

import SnapKit
import Then

final class SignupView: BaseView {
    
    let signupLabel = UILabel().then {
        $0.text = "회원가입"
        $0.font = .boldSystemFont(ofSize: 28)
        $0.textColor = .label
    }
    
    var nickNameTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "  닉네임을 입력하세요.", attributes: [NSAttributedString.Key.foregroundColor : Constants.BaseColor.placeholder])
        $0.backgroundColor = Constants.BaseColor.textFieldBackground
        $0.layer.cornerRadius = Constants.Design.cornerRadius
        $0.textAlignment = .left
    }
    
    let nickNameValidLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .label
    }
    
    
    var emailTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "  이메일 주소를 입력하세요.", attributes: [NSAttributedString.Key.foregroundColor : Constants.BaseColor.placeholder])
        $0.backgroundColor = Constants.BaseColor.textFieldBackground
        $0.layer.cornerRadius = Constants.Design.cornerRadius
        $0.textAlignment = .left
        $0.keyboardType = .emailAddress
    }
    
    let emailValidLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .label
    }
    
    var passwordTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "  비밀번호를 입력하세요.", attributes: [NSAttributedString.Key.foregroundColor : Constants.BaseColor.placeholder])
        $0.backgroundColor = Constants.BaseColor.textFieldBackground
        $0.layer.cornerRadius = Constants.Design.cornerRadius
        $0.textAlignment = .left
        $0.keyboardType = .default
        $0.textContentType = .oneTimeCode
        $0.isSecureTextEntry = true
    }
    
    let passwordValidLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .label
    }
    
    let signupButton = UIButton().then {
        $0.setTitle("회원가입 완료하기", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.tintColor = .white
        $0.backgroundColor = .systemMint
        $0.layer.cornerRadius = Constants.Design.cornerRadius
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func configureUI() {
        
        [signupLabel, nickNameTextField, nickNameValidLabel,emailTextField, emailValidLabel, passwordTextField, signupButton, passwordValidLabel].forEach {
            self.addSubview($0)
        }
        
    }
    
    override func setConstraints() {
        
        signupLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.height.equalTo(44)
        }
        
        nickNameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(signupLabel.snp.bottom).offset(30)
            make.height.equalTo(50)
        }
        
        nickNameValidLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(nickNameTextField.snp.bottom).offset(8)
            make.height.equalTo(30)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(nickNameValidLabel.snp.bottom).offset(16)
            make.height.equalTo(50)
        }
        
        emailValidLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(emailTextField.snp.bottom).offset(8)
            make.height.equalTo(30)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(emailValidLabel.snp.bottom).offset(16)
            make.height.equalTo(50)
        }
        
        passwordValidLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.height.equalTo(30)
        }
        
        signupButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(passwordValidLabel.snp.bottom).offset(20)
            make.height.equalTo(60)
        }
        
        
        
    }
    
}

