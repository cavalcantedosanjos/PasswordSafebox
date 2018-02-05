//
//  SignUpViewController.swift
//  PasswordStorage
//
//  Created by João Paulo dos Anjos on 31/01/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var amountCharsLabel: UILabel!
    @IBOutlet weak var amountLettersLabel: UILabel!
    @IBOutlet weak var amountNumberLabel: UILabel!
    @IBOutlet weak var amountSpecialLabel: UILabel!
    @IBOutlet weak var amountUpperCaseLabel: UILabel!
    
    private var viewModel = SignUpViewModel()
    private let disposeBag = DisposeBag()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindElement()
    }

    
    // MARK: - IBActions
    @IBAction func closeButtonTouchUpInside(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerButtonTouchUpInside(_ sender: UIButton) {
        viewModel.postRegister()
    }
    
    // MARK: - MISC
    
    func setupUI() {
        fillColor()
    }
    
    func fillColor() {
        registerButton.backgroundColor = ThemeColor.shared.primaryColor;
        //registerButton.setTitleColor(ThemeColor.shared.primaryColor, for: .normal)
    }
    
    // MARK: - Bind
    
    func bindElement() {
        nameTextField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.name)
            .disposed(by: disposeBag)
        
        emailTextField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        viewModel.isValidAmountChar.asObservable()
            .subscribe(onNext: { [unowned self] isValid in
                self.amountCharsLabel.textColor = isValid ? ThemeColor.shared.sucessColor : ThemeColor.shared.errorColor
            }).disposed(by: disposeBag)
        
        viewModel.isValidAmountLetter.asObservable()
            .subscribe(onNext: { [unowned self] isValid in
                self.amountLettersLabel.textColor = isValid ? ThemeColor.shared.sucessColor : ThemeColor.shared.errorColor
            }).disposed(by: disposeBag)
        
        viewModel.isValidAmountNumber.asObservable()
            .subscribe(onNext: { [unowned self] isValid in
                self.amountNumberLabel.textColor = isValid ? ThemeColor.shared.sucessColor : ThemeColor.shared.errorColor
            }).disposed(by: disposeBag)
        
        viewModel.isValidAmountSpecial.asObservable()
            .subscribe(onNext: { [unowned self] isValid in
                self.amountSpecialLabel.textColor = isValid ? ThemeColor.shared.sucessColor : ThemeColor.shared.errorColor
            }).disposed(by: disposeBag)
        
        viewModel.isValidAmountUppercaseLetter.asObservable()
            .subscribe(onNext: { [unowned self] isValid in
                self.amountUpperCaseLabel.textColor = isValid ? ThemeColor.shared.sucessColor : ThemeColor.shared.errorColor
            }).disposed(by: disposeBag)
        
        viewModel.isDataValid
            .subscribe(onNext: { [unowned self] isValid in
               self.registerButton.isEnabled = isValid
                self.registerButton.backgroundColor = isValid ? ThemeColor.shared.primaryColor : ThemeColor.shared.disableColor
            }).disposed(by: disposeBag)
        
        viewModel.isLoading.asObservable()
            .subscribe(onNext: { [unowned self] isLoading in
              self.view.enableLoading(isLoading)
            }).disposed(by: disposeBag)
        
        
        viewModel.serviceResponse
            .asObservable()
            .subscribe(onNext: { [unowned self] response in
                if let _ = response {
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }).disposed(by: disposeBag)
        
        viewModel.errorResponse
            .asObservable()
            .subscribe(onNext: { [unowned self] response in
                
                if let response = response {
                    self.showAlert(title: "Error", message: response.message!, buttonTitle: "OK", dissmisBlock: { })
                }
                
            }).disposed(by: disposeBag)
        
        
    }
}

extension SignUpViewController {
    // MARK: - Instantiation
    static func instantiate() -> SignUpViewController {
        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! SignUpViewController
    }
}
