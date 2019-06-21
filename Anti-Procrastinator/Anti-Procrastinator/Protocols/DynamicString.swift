//
//  DynamicString.swift
//  Anti-Procrastinator
//
//  Created by nimma01 on 02/04/19.
//  Copyright © 2019 nimma01. All rights reserved.
//

import Foundation
class DynamicString {
    typealias Listener = (String) -> Void
    var listener : Listener?
    
    func bind(listener : Listener?) {
        self.listener = listener
    }
    
    var value : String {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v:String) {
        value = v
    }
    
}
