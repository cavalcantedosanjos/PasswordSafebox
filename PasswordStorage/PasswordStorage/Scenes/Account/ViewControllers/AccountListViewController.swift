//
//  AccountListViewController.swift
//  PasswordStorage
//
//  Created by João Paulo dos Anjos on 01/02/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AccountListViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet var emptyView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = AccountListViewModel()
    private let disposeBag = DisposeBag()
    
    private let AccountTableViewCellIdentifier = "accountTableViewCellIdentifier"
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindElement()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getAccounts()
    }
    // MARK: - IBActions
    
    @IBAction func logoutButtonTouchUpInside(_ sender: UIBarButtonItem) {
        self.showAlertWithOptions(title: "Logout", message: "", rightButtonTitle: "YES", leftButtonTitle: "NO", rightDissmisBlock: {
           self.popToSignViewContoller()
        }, leftDissmisBlock: { })
    }
    
    @IBAction func addButtonTouchUpInside(_ sender: UIBarButtonItem) {
        self.navigationController?.pushViewController(AccountRegisterViewController.instantiate(), animated: true)
    }
    
    // MARK: - Services
    
    // MARK: - MISC
    
    func setupUI() {
        
    }
    
    // MARK: - Bind
    
    func bindElement() {
        
        viewModel.accounts.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: AccountTableViewCellIdentifier,
                                         cellType: AccountTableViewCell.self)) {
                                            row, data, cell in
                                            cell.setup(with: data)
            }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Account.self)
            .subscribe(onNext: { data in
        
               self.showDetailsViewContoller(account: data)
                
            }).disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
    }
    
    // MARK - Navigation
    
    func showDetailsViewContoller(account: Account) {
        let controller = AccountDetailViewController.instantiate()
        controller.account = account
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func popToSignViewContoller() {
        self.navigationController?.dismiss(animated: true, completion: nil)
        AutoLoginConvience().clear()
    }
    
}

extension AccountListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}


extension AccountListViewController {
    // MARK: - Instantiation
    static func instantiate() -> AccountListViewController {
        let storyboard = UIStoryboard(name: "Account", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! AccountListViewController
    }
}
