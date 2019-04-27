//
//  ViewController.swift
//  BlackList
//
//  Created by Robert Ryan on 4/27/19.
//  Copyright © 2019 Robert Ryan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var allowed = Set<Category>()
    var flags = Set<Flag>()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = (segue.destination as? UINavigationController)?.topViewController as? AllowedContentViewController {
            destination.flags = flags
            destination.allowed = allowed
            destination.delegate = self
        }
    }
}

extension ViewController: AllowedContentViewControllerDelegate {
    func allowedContentViewController(_ viewController: AllowedContentViewController, didUpdateAllowed allowed: Set<Category>, flags: Set<Flag>) {
        self.allowed = allowed
        self.flags = flags
    }
}
