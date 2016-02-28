//
//  MainViewController.swift
//  Fastslack
//
//  Created by to4iki on 2/28/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit

/// New Note
final class MainViewController: UIViewController {
}

// MARK: - LifeCycle

extension MainViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


// MARK: - Segue

extension MainViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let toViewController = segue.destinationViewController.childViewControllers.first as? NotesViewController
            where segue.identifier == "NotesSegue" else { fatalError() }
        
        toViewController.setCloseCompletionHandler({
            print("close notes view controller")
        })
    }
}
