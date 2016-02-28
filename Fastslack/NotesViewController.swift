//
//  NotesViewController.swift
//  Fastslack
//
//  Created by to4iki on 3/1/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit

/// Archive Notes
final class NotesViewController: UIViewController {
    
    private var closeCompletionHandler: (() -> Void)?
}

// MARK: - LifeCycle

extension NotesViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - Setup

extension NotesViewController {
    
    func setCloseCompletionHandler(handler: () -> Void) {
        closeCompletionHandler = handler
    }
}
