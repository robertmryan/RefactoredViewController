//
//  AllowedContentViewController.swift
//  BlackList
//
//  Created by Robert Ryan on 4/27/19.
//  Copyright © 2019 Robert Ryan. All rights reserved.
//

import UIKit

protocol AllowedContentViewControllerDelegate: class {
    func allowedContentViewController(_ viewController: AllowedContentViewController, didUpdateAllowed allowed: Set<Category>, flags: Set<Flag>)
}

class AllowedContentViewController: UITableViewController {
    
    // properties set by presenting view controller
    
    weak var delegate: AllowedContentViewControllerDelegate?
    var allowed: Set<Category>!
    var flags: Set<Flag>!
    
    // properties used by this view controller
    
    private var viewModel: AllowedContentViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = AllowedContentViewModel(allowed: allowed, flags: flags)
    }
    
}

// MARK: - Actions

extension AllowedContentViewController {
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        delegate?.allowedContentViewController(self, didUpdateAllowed: viewModel.allowed, flags: viewModel.flags)
        dismiss(animated: true)
    }
}

// MARK: - UITableViewDataSource

extension AllowedContentViewController {
    // you didn't provide the following two, so I'll take a guess what that looked like
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = viewModel.text(for: indexPath.row)
        cell.accessoryType = viewModel.isSelected(row: indexPath.row) ? .checkmark : .none
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension AllowedContentViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 0 else {
            return
        }
        
        viewModel.toggle(row: indexPath.row)
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
