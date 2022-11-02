//
//  SignupViewController.swift
//  Login
//
//  Created by 윤여진 on 2022/11/02.
//

import UIKit

final class SignupViewController: BaseViewController {
    
    let mainView = SignupView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
    }
    
}
