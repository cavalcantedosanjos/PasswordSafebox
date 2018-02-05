//
//  AccountRegisterViewController.swift
//  PasswordStorage
//
//  Created by João Paulo dos Anjos on 01/02/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol AccountRegisterViewControllerDelegate {
    func accountRegisterViewController(controller: AccountRegisterViewController, didFinishUpdate account: Account)
}

class AccountRegisterViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    private var viewModel = AccountRegisterViewModel()
    private let disposeBag = DisposeBag()

    var delegate: AccountRegisterViewControllerDelegate?
    var account: Account?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindElement()
    }
    
    // MARK: - IBActions
    @IBAction func addButtonTouchUpInside(_ sender: UIButton) {
        if let account = account {
            viewModel.updateAccount(account: account)
        } else {
            viewModel.saveAccount()
        }
    
       popViewController()
    }
    
    @IBAction func urlTextFieldEditingDidEnd(_ sender: UITextField) {
        logoImageView.loadImageWithAuthorization(url: sender.text!)
    }
    
    @IBAction func cancelButtonTouchUpInside(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - MISC
    
    func setupUI() {
        if let account = account {
            self.title = "Edit"
            urlTextField.text = account.url
            usernameTextField.text = account.username
            passwordTextField.text = account.password
            logoImageView.loadImageWithAuthorization(url: account.url!)
            registerButton.setTitle("Update", for: .normal)
        } else {
            self.title = "Register"
        }
        
        fillColor()
    }
    
    // MARK: - Bind
    
    func bindElement() {
        urlTextField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.url)
            .disposed(by: disposeBag)
        
        usernameTextField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.username)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        viewModel.isDataValid.asObservable()
            .subscribe(onNext: { [unowned self] isValid in
                self.registerButton.isEnabled = isValid
                self.registerButton.backgroundColor = isValid ? ThemeColor.shared.primaryColor : ThemeColor.shared.disableColor
            }).disposed(by: disposeBag)
        
    }
    
    func fillColor() {
        registerButton.backgroundColor = ThemeColor.shared.primaryColor
    }
    
    func popViewController() {
        self.delegate?.accountRegisterViewController(controller: self, didFinishUpdate: viewModel.account)
        self.navigationController?.popViewController(animated: true)
    }

}


extension AccountRegisterViewController {
    // MARK: - Instantiation
    static func instantiate() -> AccountRegisterViewController {
        let storyboard = UIStoryboard(name: "Account", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! AccountRegisterViewController
    }
}
