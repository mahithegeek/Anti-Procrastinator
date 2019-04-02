//
//  Dynamic.swift
//  Anti-Procrastinator
//
//  Created by nimma01 on 20/03/19.
//  Copyright © 2019 nimma01. All rights reserved.
//

import Foundation
class Dynamic<T> {
    typealias Listener = (T) -> ()
    var listener : Listener?
    
    func bind(_ listener:Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener:Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    var value : T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v:T) {
        value = v
    }
}
