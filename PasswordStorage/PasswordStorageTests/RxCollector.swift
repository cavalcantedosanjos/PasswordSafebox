//
//  File.swift
//  PasswordStorageTests
//
//  Created by Joao Paulo Cavalcante dos Anjos on 2/5/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import Foundation
import RxSwift

class RxCollector<T> {
    var bag = DisposeBag()
    var items = [T]()
    func collect(from observable: Observable<T>) -> RxCollector {
        observable.asObservable()
            .subscribe(onNext: { (item) in
                self.items.append(item)
            })
            .disposed(by: bag)
        return self
    }
}
