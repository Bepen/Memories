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
    var type: MemoryType
}

class Memories: Codable {
    
    var memoryList = [MemoryItem]()
    
    func add(title: String, description: String, type: MemoryType) {
        let memoryItem = MemoryItem(title: title, description: description, type: type)
        memoryList.insert(memoryItem, at: 0)
    }
    
    func removeItem(at index: Int) {
        if let _ = memoryList[index] as MemoryItem? {
            memoryList.remove(at: index)
        }
    }
    
    func memories(for memoryType: MemoryType) -> [MemoryItem] {
        
        var typeMemories = [MemoryItem]()
        for mem in memoryList {
            if mem.type == memoryType {
                typeMemories.append(mem)
            }
        }
        return typeMemories
    }
}
