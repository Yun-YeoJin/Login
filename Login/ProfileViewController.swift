//
//  ProfileViewController.swift
//  Login
//
//  Created by 윤여진 on 2022/11/02.
//

import UIKit

import Kingfisher
import RxCocoa
import RxSwift

final class ProfileViewController: BaseViewController {
    
    let mainView = ProfileView()
    
    let viewModel = ProfileViewModel()
    
    var disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.profile
            .withUnretained(self)
            .subscribe { vc, value in
                let url = URL(string: value.user.photo)
                vc.mainView.profileImageView.kf.setImage(with: url)
                vc.mainView.nickNameLabel.text = value.user.username
                vc.mainView.emailLabel.text = value.user.email
            } onError: { error in
                print(error.localizedDescription)
            }
            .disposed(by: disposeBag)
        
        viewModel.getProfile()

        
    }
    
}
