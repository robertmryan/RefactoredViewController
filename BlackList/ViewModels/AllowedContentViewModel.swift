//
//  AllowedContentViewModel.swift
//  BlackList
//
//  Created by Robert Ryan on 4/27/19.
//  Copyright © 2019 Robert Ryan. All rights reserved.
//

import Foundation

struct AllowedContentViewModel {
    var allowed: Set<Category>
    var flags: Set<Flag>
    
    func numberOfRows() -> Int {
        return 4
    }
    
    func isSelected(row: Int) -> Bool {
        switch row {
        case 0:  return flags.contains(.nsfw)
        case 1:  return flags.contains(.religious) && flags.contains(.political)
        case 2:  return !allowed.contains(.programming)
        case 3:  return !allowed.contains(.dark)
        default: fatalError("Unexpected row number")
        }
    }
    
    private mutating func select(row: Int) {
        switch row {
        case 0:  flags.insert(.nsfw)
        case 1:  flags.insert(.religious); flags.insert(.political)
        case 2:  allowed.remove(.programming)
        case 3:  allowed.remove(.dark)
        default: fatalError("Unexpected row number")
        }
    }
    
    private mutating func unselect(row: Int) {
        switch row {
        case 0:  flags.remove(.nsfw)
        case 1:  flags.remove(.religious); flags.remove(.political)
        case 2:  allowed.insert(.programming)
        case 3:  allowed.insert(.dark)
        default: fatalError("Unexpected row number")
        }
    }
    
    mutating func toggle(row: Int) {
        if isSelected(row: row) {
            unselect(row: row)
        } else {
            select(row: row)
        }
    }
    
    func text(for row: Int) -> String {
        switch row {
        case 0: return NSLocalizedString("NSFW", comment: "Label")
        case 1: return NSLocalizedString("Religious/political", comment: "Label")
        case 2: return NSLocalizedString("Blacklisted Programming", comment: "Label")
        case 3: return NSLocalizedString("Blacklisted Dark", comment: "Label")
        default: fatalError("Unexpected row number")
        }
    }
}

