//
//  TableViewController.swift
//  BlackList
//
//  Created by Robert Ryan on 4/27/19.
//  Copyright © 2019 Robert Ryan. All rights reserved.
//

import UIKit

enum PastState {
    case SELECTED
    case UNSELECTED
}

enum Category: CaseIterable {
    case Programming
    case Dark
}

class TableViewController: UITableViewController {
    var blacklisted = Set<Category>()
    var flags = Set<String>()
    
    @IBAction func toggle(_ sender: UISwitch) {
        if (sender.isOn) {
            print("if")
        } else {
            print("else")
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        ViewController.allowed = Set(Category.allCases).subtracting(blacklisted)
        ViewController.flags = flags

        print(ViewController.allowed)
        print(ViewController.flags)
        self.dismiss(animated: true)
    }
    
    var states = [PastState.UNSELECTED, PastState.UNSELECTED, PastState.UNSELECTED, PastState.UNSELECTED]
    
    // you didn't provide the following two, so I'll take a guess what that looked like
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        switch (indexPath.row) {
        case 0:
            cell.textLabel?.text = "NSFW"
            break
            
        case 1:
            cell.textLabel?.text = "Religious/political"
            break
            
        case 2:
            cell.textLabel?.text = "Blacklisted Programming"
            break
            
        case 3:
            cell.textLabel?.text = "Blacklisted Dark"
            break
            
        default: break
        }
        
        cell.accessoryType = (states[indexPath.row] == PastState.SELECTED)
            ? .checkmark
            : .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section != 0) {
            return
        }
        
        tableView.cellForRow(at: indexPath)?.accessoryType
            = (states[indexPath.row] == PastState.SELECTED)
            ? .none
            : .checkmark
        
        switch (indexPath.row) {
        case 0:
            TableViewController.toggleItem(if: states[0], set: &flags, with: "nsfw")
            break
            
        case 1:
            TableViewController.toggleItem(if: states[1], set: &flags, with: "religious", "political")
            break
            
        case 2:
            TableViewController.toggleItem(if: states[2], set: &blacklisted, with: Category.Programming)
            break
            
        case 3:
            TableViewController.toggleItem(if: states[3], set: &blacklisted, with: Category.Dark)
            break
            
        default: break
        }
        
        states[indexPath.row] = (states[indexPath.row] == PastState.SELECTED)
            ? PastState.UNSELECTED
            : PastState.SELECTED
    }
    
    static func toggleItem<T: Hashable>(`if` state: PastState, set: inout Set<T>, with items: T...) {
        if (state == PastState.UNSELECTED) {
            for item in items {
                set.insert(item)
            }
        } else {
            for item in items {
                set.remove(item)
            }
        }
    }

    // you didn't show us how `cellForRowAt` determined whether it was selected or not, so I'll take a guess, patterning this after `toggleItem`
    
    static func determineState<T: Hashable>(set: Set<T>, with items: T...) -> PastState {
        for item in items {
            if (!set.contains(item)) {
                return .UNSELECTED
            }
        }
        
        return .SELECTED
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureStates()
    }

    func configureStates() {
        flags = ViewController.flags
        for category in Category.allCases {
            if (!ViewController.allowed.contains(category)) {
                blacklisted = blacklisted.union([category])
            }
        }

        states = [
            TableViewController.determineState(set: flags, with: "nsfw"),
            TableViewController.determineState(set: flags, with: "religious", "political"),
            TableViewController.determineState(set: blacklisted, with: Category.Programming),
            TableViewController.determineState(set: blacklisted, with: Category.Dark)
        ]
    }
    
}
