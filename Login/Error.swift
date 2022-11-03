//
//  Error.swift
//  Login
//
//  Created by 윤여진 on 2022/11/03.
//

import Foundation

enum SeSACError: Error {
    
    case invalidAuthorization
    case takenEmail
    case emptyParameters
    
}
 
extension SeSACError: LocalizedError {
    
    var errorDescription: String? {
        
        switch self {
        case .invalidAuthorization:
            return "토큰이 만료되었습니다. 다시 로그인 해주세요."
        case .takenEmail:
            return "이미 가입된 회원입니다. 로그인 해주세요."
        case .emptyParameters:
            return "파라미터가 없습니다."
        }
    }
    
}
