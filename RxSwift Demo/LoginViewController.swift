//
//  ViewController.swift
//  RxSwift Demo
//
//  Created by 楊朝富 on 2021/11/19.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    @IBOutlet weak var fieldUserName: UITextField!
    
    @IBOutlet weak var labelUserNameErrorHint: UILabel!
    
    @IBOutlet weak var fieldPasswd: UITextField!
    
    @IBOutlet weak var labelPasswdErrorHint: UILabel!
    
    @IBOutlet weak var viewPasswd: UIStackView!
    
    @IBOutlet weak var buttonLogin: UIButton!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let isUserNameValid = fieldUserName.rx.text.orEmpty
            .map { userName in
                userName.count >= 5
            }
            .share(replay: 1)
        
        isUserNameValid
            .bind(to: Binder(viewPasswd.rx.base) { control,value in
                control.isHidden = !value
            })
            .disposed(by: disposeBag)
        
        let isPasswdValid = fieldPasswd.rx.text.orEmpty
            .map { passwd in
                passwd.count >= 8
            }
            .share(replay: 1)
        
        let isEverythingOK = Observable.combineLatest(isUserNameValid, isPasswdValid) {
            $0 && $1
        }
        
        isEverythingOK
            .bind(to: buttonLogin.rx.isEnabled)
            .disposed(by: disposeBag)
        
        buttonLogin.rx.tap
            .subscribe(onNext: {
                self.showLoginSuccessAlert()
            })
            .disposed(by: disposeBag)

    }
    
    func showLoginSuccessAlert() {
        let alert = UIAlertController(
            title: "Login Success",
            message: "Welcome home!",
            preferredStyle: .alert
        )
        let actionOK = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        )
        alert.addAction(actionOK)
        present(alert, animated: true)
    }


}

