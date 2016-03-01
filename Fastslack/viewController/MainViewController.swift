//
//  MainViewController.swift
//  Fastslack
//
//  Created by to4iki on 2/28/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
}

// MARK: - UIViewController

extension MainViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Segue

extension MainViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let toViewController = segue.destinationViewController.childViewControllers.first as? NotesViewController
            where segue.identifier == "NotesSegue" else { fatalError() }
        
        toViewController.setCloseCompletionHandler({
            log.info("close notes view controller")
        })
    }
}
