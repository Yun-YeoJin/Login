//
//  ProfileViewController.swift
//  Login
//
//  Created by 윤여진 on 2022/11/02.
//

import UIKit

final class ProfileViewController: BaseViewController {
    
    let mainView = ProfileView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
}
