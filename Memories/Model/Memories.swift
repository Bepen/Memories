//
//  Memories.swift
//  Memories
//
//  Created by Bepen Neupane on 11/17/18.
//  Copyright © 2018 Bepen Neupane. All rights reserved.
//

import Foundation

let kAppGroupBundleID           = "group.com.examples.Passwords"

/*
 ** default items
 */
let dDate                       = "date"
let dNumLaunches                = "num_launches"

struct MemoryItem: Equatable, Codable {
    var title: String
    var description: String
    var happy: MemoryType
}

class Memories: Codable {
    
    var memoryList = [MemoryItem]()
    
    func add(title: String, description: String, happy: MemoryType) {
        let memoryItem = MemoryItem(title: title, description: description, happy: happy)
        memoryList.insert(memoryItem, at: 0)
    }
    
    func removeItem(at index: Int) {
        if let _ = memoryList[index] as MemoryItem? {
            memoryList.remove(at: index)
        }
    }
}
