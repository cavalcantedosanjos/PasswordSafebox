//
//  SignInViewController.swift
//  PasswordStorage
//
//  Created by João Paulo dos Anjos on 31/01/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import LocalAuthentication

class SignInViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    private var viewModel = SignInViewModel()
    private let disposeBag = DisposeBag()
    
    private var finishedAnimation = false;
    var context = LAContext()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindElement()
        animateTextFiels()
        animateLogo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        moveElements()
        checkTouchID()
    }
    
    // MARK: - IBActions
    @IBAction func loginButtonTouchUpInside(_ sender: UIButton) {
        dismissKeyboard()
        viewModel.postLogin()
    }
    
    @IBAction func registerButtonTouchUpInside(_ sender: UIButton) {
        self.present(SignUpViewController.instantiate(), animated: true, completion: nil)
    }
    
    // MARK: - MISC
    
    func setupUI() {
        fillColor()
    }
    
    func fillColor() {
        registerButton.backgroundColor = ThemeColor.shared.primaryColor;
        loginButton.setTitleColor(ThemeColor.shared.primaryColor, for: .normal)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Bind
    
    func bindElement() {
        emailTextField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        viewModel.isDataValid
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] isValid in
                self.loginButton.isEnabled = isValid
            }).disposed(by: disposeBag)
        
        viewModel.serviceResponse
            .asObservable()
            .subscribe(onNext: { [unowned self] response in
                if let _ = response {
                    DispatchQueue.main.async {
                        self.emailTextField.text = ""
                        self.passwordTextField.text = ""
                        self.present(AccountNavigationController.instantiate(), animated: true, completion: nil)
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
        
        viewModel.isLoading.asObservable()
            .subscribe(onNext: { [unowned self] isLoading in
                self.view.enableLoading(isLoading)
            }).disposed(by: disposeBag)
    }
    
}

extension SignInViewController {
    // MARK: TouchID
    
    func checkTouchID() {
        if !AutoLoginConvience().autoLoginEnable { return }
        
        let policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics
        
        var err: NSError?
        guard context.canEvaluatePolicy(policy, error: &err) else {
            return
        }
        
        loginProcess(policy: policy)
    }
    
    private func loginProcess(policy: LAPolicy) {
        context.evaluatePolicy(policy, localizedReason: "Touch to Sign In", reply: { (success, error) in
            DispatchQueue.main.async {
                guard success else {
                    guard let error = error else {  return }
                    switch(error) {
                    case LAError.authenticationFailed:
                        self.fillEmailTextField()
                        break
                    default:
                        break
                    }
                    return
                }
                self.autoLogin()
            }
        })
    }
    
    func fillEmailTextField() {
        let autoLogin =  AutoLoginConvience()
        emailTextField.text = autoLogin.username
    }
    
    func autoLogin() {
        let autoLogin =  AutoLoginConvience()
        if !autoLogin.autoLoginEnable { return }
        
        viewModel.email.value = autoLogin.username
        viewModel.password.value = autoLogin.password
        viewModel.postLogin()
        
    }
}

extension SignInViewController {
    // MARK: - Animations
    
    func moveElements() {
        if (finishedAnimation) { return }
        emailTextField.center.x += self.view.bounds.width
        passwordTextField.center.x -= self.view.bounds.width
        loginButton.alpha = 0
        registerButton.alpha = 0
    }
    
    func animateTextFiels() {
        UIView.animate(withDuration: 0.5, delay: 1.5, options: [], animations: {
            self.emailTextField.center.x -= self.view.bounds.width
            self.passwordTextField.center.x += self.view.bounds.width
        }) { (sucess) in
            self.animateButtons()
        }
    }
    
    func animateButtons() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            self.loginButton.alpha = 1
            self.registerButton.alpha = 1
        }) { (sucess) in
            self.finishedAnimation = true
        }
    }
    
    func animateLogo() {
        UIView.animate(withDuration: 1, delay: 1, options: [], animations: {
          self.logoImageView.center.y = 0
        }) { (sucess) in
            
        }
    }
    
}

extension SignInViewController {
    // MARK: - Instantiation
    
    static func instantiate() -> SignInViewController {
        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! SignInViewController
    }
}
