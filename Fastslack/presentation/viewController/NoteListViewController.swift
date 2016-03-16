//
//  NoteListViewController.swift
//  Fastslack
//
//  Created by to4iki on 3/1/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit

final class NoteListViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    private let presenter = NoteListPresenter()
    
    private var closeCompletionHandler: (() -> Void)?
}

// MARK: - UIViewController

extension NoteListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

// MARK: - Setup

extension NoteListViewController {
    
    func setCloseCompletionHandler(handler: () -> Void) {
        closeCompletionHandler = handler
    }
}

// MARK: - Action

extension NoteListViewController {
    
    @IBAction func onClickCloseButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: closeCompletionHandler)
    }
}
