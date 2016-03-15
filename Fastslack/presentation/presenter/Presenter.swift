//
//  Presenter.swift
//  Fastslack
//
//  Created by to4iki on 3/15/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation

protocol Presenter: class {
    
    // MARK: LifeCycle
    
    func viewDidLoad()
    
    func viewWillAppear(animated: Bool)
    
    func viewDidAppear(animated: Bool)
    
    func viewWillDisappear(animated: Bool)
    
    func viewDidDisappear(animated: Bool)
}

extension Presenter {
    
    func viewDidLoad() {}
    
    func viewWillAppear(animated: Bool) {}
    
    func viewDidAppear(animated: Bool) {}
    
    func viewWillDisappear(animated: Bool) {}
    
    func viewDidDisappear(animated: Bool) {}
}
