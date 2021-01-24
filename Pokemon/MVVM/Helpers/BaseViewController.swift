//
//  BaseViewController.swift
//  Pokemon
//
//  Created by Jaime Uribe on 23/01/21.
//

import Foundation
import SVProgressHUD
import RxSwift

open class BaseViewController: UIViewController {
    
    public let disposeBag = DisposeBag()
    
    public func showProgressIndicator(message : String?){
        DispatchQueue.main.async {
            SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
            SVProgressHUD.setForegroundColor(UIColor.black)
            SVProgressHUD.setBackgroundColor(UIColor.white)
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
            SVProgressHUD.show(withStatus: message)
        }
    }

    public func showProgressWaitIndicator(){
        self.showProgressIndicator(message: WAIT_PLEASE)
    }
    
    public func hideProgressIndicator(){
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        view.frame.origin.y = 0
    }
}
