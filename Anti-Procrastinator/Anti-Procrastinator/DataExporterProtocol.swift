//
//  DataExporterProtocol.swift
//  Anti-Procrastinator
//
//  Created by nimma01 on 03/06/19.
//  Copyright © 2019 nimma01. All rights reserved.
//

import Foundation

typealias CompletionHandler = (Bool,NSError?)->Void

protocol DataExporterProtocol {
    func exportData(data:[Any],completion:CompletionHandler)
    
}
