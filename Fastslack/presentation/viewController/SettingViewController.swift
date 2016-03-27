//
//  SettingViewController.swift
//  Fastslack
//
//  Created by to4iki on 3/2/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SettingViewController: UITableViewController {
    
    @IBOutlet private weak var webHookURLTextField: UITextField!
    
    @IBOutlet private weak var chanelTextField: UITextField!
    
    @IBOutlet private weak var botNameTextField: UITextField!
    
    @IBOutlet private weak var iconEmojiTextField: UITextField!
    
    private var closeCompletionHandler: (() -> Void)?
    
    private let presenter = ConfigureSlackPresenter()
    
    private let disposeBag = DisposeBag()
}

// MARK: - UIViewController

extension SettingViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.viewDidDisappear(animated)
    }
}

// MARK: - UI

extension SettingViewController {
    
    private func bindView() {
        bindTextField()
    }
    
    private func bindTextField() {
        webHookURLTextField.rx_text
            .subscribeNext { [unowned self] text in
                self.presenter.webHookURL.value = text
            }
            .addDisposableTo(disposeBag)
        
        presenter.webHookURL.asObservable()
            .bindTo(webHookURLTextField.rx_text)
            .addDisposableTo(disposeBag)
    }
}

// MARK: - Setter

extension SettingViewController {
    
    func setCloseCompletionHandler(handler: () -> Void) {
        closeCompletionHandler = handler
    }
}

// MARK: - Action

extension SettingViewController {
    
    @IBAction func onClickCloseButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: closeCompletionHandler)
    }
}
