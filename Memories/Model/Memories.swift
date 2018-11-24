/* Bepen Neupane
 * bneupane@u.rochester.edu
 * CSC 214 Fall 2018 - Project 3, 11/24/18
 * I affirm that I have not given or received any unauthorized help on this assignment, and that this work is my own.
 */

import Foundation

let kAppGroupBundleID           = "group.com.examples.Memories"

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
