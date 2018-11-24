//
//  MemoryType.swift
//  Memories
//
//  Created by Bepen Neupane on 11/17/18.
//  Copyright © 2018 Bepen Neupane. All rights reserved.
//

import Foundation

enum MemoryType: Int, Codable {
    
    case happy, sad
    
    static let allValues = [happy, sad]
    
    func name() -> String {
        switch self {
        case .happy:                    return NSLocalizedString("str_happy", comment: "")
        case .sad:                      return NSLocalizedString("str_sad", comment: "")
        }
    }
}
