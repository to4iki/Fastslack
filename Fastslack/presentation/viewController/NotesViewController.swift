//
//  NotesViewController.swift
//  Fastslack
//
//  Created by to4iki on 3/1/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit

final class NotesViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    private var closeCompletionHandler: (() -> Void)?
}

// MARK: - UIViewController

extension NotesViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Setup

extension NotesViewController {
    
    func setCloseCompletionHandler(handler: () -> Void) {
        closeCompletionHandler = handler
    }
}

// MARK: - Action

extension NotesViewController {
    
    @IBAction func onClickCloseButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: closeCompletionHandler)
    }
}
