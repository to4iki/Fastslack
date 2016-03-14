//
//  SettingViewController.swift
//  Fastslack
//
//  Created by to4iki on 3/2/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit

final class SettingViewController: UIViewController {
    
    private var closeCompletionHandler: (() -> Void)?
}

// MARK: - UIViewController

extension SettingViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Action

extension SettingViewController {
    
    @IBAction func onClickCloseButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: closeCompletionHandler)
    }
}
