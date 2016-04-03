//
//  Presenter.swift
//  Fastslack
//
//  Created by to4iki on 3/15/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation

/// I/F
protocol Presenter: class {

    func viewDidLoad()

    func viewWillAppear(animated: Bool)

    func viewDidAppear(animated: Bool)

    func viewWillDisappear(animated: Bool)

    func viewDidDisappear(animated: Bool)
}

// MARK: - LifeCycle

extension Presenter {

    func viewDidLoad() { }

    func viewWillAppear(animated: Bool) { }

    func viewDidAppear(animated: Bool) { }

    func viewWillDisappear(animated: Bool) { }

    func viewDidDisappear(animated: Bool) { }
}
