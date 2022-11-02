//
//  UIViewController+Extension.swift
//  Login
//
//  Created by 윤여진 on 2022/11/02.
//

import UIKit

extension UIViewController {
    
    enum TransitionStyle {
        case present //네비게이션 없이 present
        case presentNavigation //네비게이션 임베드 present
        case presentFullNavigation //네비게이션 풀스크린
        case push
    }
    
    func transition<T: UIViewController>(_ viewController: T, transitionStyle: TransitionStyle = .present) {
        
        switch transitionStyle {
        case .present:
            self.present(viewController, animated: true) //self.present(T(), animated: true)와 차이.
        case .presentNavigation:
            let navi = UINavigationController(rootViewController: viewController)
            self.present(navi, animated: true)
        case .presentFullNavigation:
            let navi = UINavigationController(rootViewController: viewController)
            navi.modalPresentationStyle = .fullScreen
            self.present(navi, animated: true)
        case .push:
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
    }
    
    func showSesacAlert(title: String, message: String, buttonTitle: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true)
        
    }
}
