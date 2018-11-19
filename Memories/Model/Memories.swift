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
    var latitude: String
    var longitude: String
    
}

class Memories: Codable {
    
    var memoryList = [MemoryItem]()
    var index = 0
    
    func add(title: String, description: String, type: MemoryType, latitude: String, longitude: String) {
        let memoryItem = MemoryItem(title: title, description: description, type: type, latitude: latitude, longitude: longitude)
        memoryList.insert(memoryItem, at: 0)
    }
    
    func add(mem: MemoryItem){
        memoryList.insert(mem, at: 0)
    }
    
    func add(mem: MemoryItem, destinationIndexPath: Int){
        memoryList.insert(mem, at: destinationIndexPath)
    }
    
    func removeItem(mem: MemoryItem) {
        memoryList = memoryList.filter() { $0 != mem }
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
    
    func unique(mem: MemoryItem) -> Bool{
        for memory in memoryList {
            if (mem.title == memory.title && mem.description == memory.description && mem.type == memory.type){
                return false
            }
        }
        return true
    }
}
