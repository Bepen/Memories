/* Bepen Neupane
 * bneupane@u.rochester.edu
 * CSC 214 Fall 2018 - Project 3, 11/24/18
 * I affirm that I have not given or received any unauthorized help on this assignment, and that this work is my own.
 */

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
