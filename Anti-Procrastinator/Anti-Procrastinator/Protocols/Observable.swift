//
//  DynamicString.swift
//  Anti-Procrastinator
//
//  Created by nimma01 on 02/04/19.
//  Copyright © 2019 nimma01. All rights reserved.
//

import Foundation
class Observable <T>{
    typealias Listener = (T) -> Void
    var listener : Listener?
    
    func bind(listener : Listener?) {
        self.listener = listener
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
