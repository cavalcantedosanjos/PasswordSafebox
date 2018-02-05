//
//  AccountDetailViewController.swift
//  PasswordStorage
//
//  Created by João Paulo dos Anjos on 02/02/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AccountDetailViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var urlTitleLabel: UILabel!
    @IBOutlet weak var usernameTitleLabel: UILabel!
    @IBOutlet weak var passwordTitleLabel: UILabel!
    
    
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var copyButton: UIButton!
    
    var account = Account()
    var password = ""
    
    private let viewModel = AccountDetailViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fillColor()
    }
    
    // MARK: - IBActions
    
    @IBAction func deleteButtonTouchUpInside(_ sender: UIBarButtonItem) {
        self.showAlertWithOptions(title: "", message: "Want to exclude?", rightButtonTitle: "YES", leftButtonTitle: "NO", rightDissmisBlock: {
             self.viewModel.deleteAccount(account: self.account)
            self.popToAccountListViewContoller()
        }, leftDissmisBlock: {})
        
    }
    
    @IBAction func editButtonTouchUpInside(_ sender: UIBarButtonItem) {
        showAccountRegisterViewController()
    }
    
    @IBAction func showPaswordTouchUpInside(_ sender: UIButton) {
        showButton.isSelected = !showButton.isSelected
        passwordLabel.text = showButton.isSelected ? "*********" : password
        
    }
    
    @IBAction func copyPasswordTouchUpInside(_ sender: UIButton) {
        UIPasteboard.general.string = self.passwordLabel.text;
        self.showToaster(message: "Password copied")
    }
    
    // MARK: - MISC
    
    func setupUI() {
        if let url = account.url, let username = account.username, let password = account.password {
            urlLabel.text = url
            usernameLabel.text = username
            passwordLabel.text = password
            logoImageView.loadImageWithAuthorization(url: url)
            self.password = password
        }
        showButton.isSelected = true
        passwordLabel.text = "*********"
    }
    
    func fillColor() {
        urlTitleLabel.textColor = ThemeColor.shared.primaryColor;
        usernameTitleLabel.textColor = ThemeColor.shared.primaryColor;
        passwordTitleLabel.textColor = ThemeColor.shared.primaryColor;
        copyButton.setTitleColor(ThemeColor.shared.primaryColor, for: .normal)
        showButton.setTitleColor(ThemeColor.shared.primaryColor, for: .normal)
    }
    
    // MARK: - Navigation
    func showAccountRegisterViewController() {
        let controller = AccountRegisterViewController.instantiate()
        controller.account = account
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func popToAccountListViewContoller() {
        self.navigationController?.popViewController(animated: true)
    }

}

// MARK: - AccountRegisterViewControllerDelegate

extension AccountDetailViewController: AccountRegisterViewControllerDelegate {
    func accountRegisterViewController(controller: AccountRegisterViewController, didFinishUpdate account: Account) {
        self.account = account
        self.setupUI()
    }
}


extension AccountDetailViewController {
    // MARK: - Instantiation
    static func instantiate() -> AccountDetailViewController {
        let storyboard = UIStoryboard(name: "Account", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! AccountDetailViewController
    }
}
