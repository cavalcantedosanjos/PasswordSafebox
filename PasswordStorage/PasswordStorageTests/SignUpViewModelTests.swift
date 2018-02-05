//
//  SignUpViewModelTests.swift
//  PasswordStorageTests
//
//  Created by Joao Paulo Cavalcante dos Anjos on 2/4/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import XCTest
import RxSwift

@testable import PasswordStorage

class SignUpViewModelTests: XCTestCase {
    
    
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    
    func testPassword() {
        
        let viewModel = SignUpViewModel()
        viewModel.password.value = "A123456789@"
        
        assert(viewModel.checkAmountChar(), "Wrong size")
        assert(viewModel.isContaisLetterInPassword, "Need a letter")
        assert(viewModel.isContaisNumberInPassword, "Need a number")
        assert(viewModel.isContaisSymbolsInPassword, "Need a symbol")
        assert(viewModel.isContaisUppercaseInPassword, "Need a uppercase letter")
    }
    
    func testDataValidation() {
        
        let viewModel = SignUpViewModel()
        
        let collector = RxCollector<Bool>()
            .collect(from: viewModel.isDataValid)
        
        viewModel.email.value = "jpdosanjos@live.com"
        viewModel.password.value = "A123456789@"
        viewModel.name.value = "Joao"
        
        
        XCTAssertEqual(collector.items, [false, false, false, true])
    }
    
}


