//
//  MainViewController.swift
//  Fastslack
//
//  Created by to4iki on 2/28/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    
    @IBOutlet private weak var inputTextView: UITextView! {
        didSet {
            automaticallyAdjustsScrollViewInsets = false
            autoFocus()
        }
    }
}

// MARK: - UIViewController

extension MainViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - UI

extension MainViewController {
    
    private func autoFocus() {
        inputTextView.becomeFirstResponder()
    }
}

// MARK: - Segue

extension MainViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let toViewController = segue.destinationViewController.childViewControllers.first as? NotesViewController
            where segue.identifier == "NotesSegue" else { fatalError() }
        
        toViewController.setCloseCompletionHandler({
            log.info("close notes view controller")
            self.autoFocus()
        })
    }
}
