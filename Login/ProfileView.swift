//
//  ProfileView.swift
//  Login
//
//  Created by 윤여진 on 2022/11/02.
//

import UIKit

import SnapKit
import Then

class ProfileView: BaseView {
    
    let profileImageView = UIImageView().then {
        $0.image = UIImage(systemName: "person.fill")
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    let nickNameLabel = UILabel().then {
        $0.text = "개발하는 윤기사"
        $0.font = .boldSystemFont(ofSize: 28)
        $0.textColor = .label
    }
    
    let emailLabel = UILabel().then {
        $0.text = "duwls0349@naver.com"
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .label
    }
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func configureUI() {
        
        [profileImageView, nickNameLabel, emailLabel].forEach {
            self.addSubview($0)
        }
        
    }
    
    override func setConstraints() {
        
        profileImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.width.height.equalTo(100)
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.top.equalTo(profileImageView.snp.bottom).offset(50)
            make.height.equalTo(44)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.top.equalTo(nickNameLabel.snp.bottom).offset(50)
            make.height.equalTo(44)
        }
        
    }
}
