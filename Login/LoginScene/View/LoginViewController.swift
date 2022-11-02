//
//  LoginViewController.swift
//  Login
//
//  Created by 윤여진 on 2022/11/02.
//

import UIKit

final class LoginViewController: BaseViewController {
    
    let mainView = LoginView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "개발하는 윤기사"
        navigationItem.titleView?.tintColor = .label
        
        mainView.signupButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func signupButtonClicked() {
        
        let vc = SignupViewController()
        transition(vc, transitionStyle: .push)
        
    }
    
}
