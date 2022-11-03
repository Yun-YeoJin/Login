//
//  ProfileViewModel.swift
//  Login
//
//  Created by 윤여진 on 2022/11/02.
//

import Foundation
import RxSwift

class ProfileViewModel {
    
    let profile = PublishSubject<Profile>()
    
    func getProfile() {
        
        let api = SeSACAPI.profile
        
        APIService.shared.requestSeSAC(type: Profile.self, url: api.url, method: .get, headers: api.header) { [weak self] response in
            
            switch response {
            case .success(let data):
                self?.profile.onNext(data)
                
            case .failure(let error):
                self?.profile.onError(error)
            }
            
        }
    }
    
}
