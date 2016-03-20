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
    
    @IBOutlet private weak var closeButton: UIBarButtonItem!
    
    @IBOutlet private weak var doneButton: UIBarButtonItem! {
        didSet {
            doneButton.enabled = false
        }
    }
    
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
        presenter.viewWillAppear(animated)
    }
}

// MARK: - UI

extension SettingViewController {
    
    private func bindView() {
        bindTextField()
        bindButton()
    }
    
    private func bindTextField() {
        webHookURLTextField.rx_text
            .map { !$0.isEmpty }
            .bindTo(doneButton.rx_enabled)
            .addDisposableTo(disposeBag)
        
        webHookURLTextField.rx_text
            .subscribeNext { [unowned self] text in
                self.presenter.webHookURL.value = text
            }
            .addDisposableTo(disposeBag)
        
        presenter.webHookURL.asObservable()
            .bindTo(webHookURLTextField.rx_text)
            .addDisposableTo(disposeBag)
    }
    
    private func bindButton() {
        doneButton.rx_tap
            .subscribeNext { [unowned self] _ in
                self.presenter.storeWebHookURL()
            }
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
        self.presenter.refreshConfig()
        dismissViewControllerAnimated(true, completion: closeCompletionHandler)
    }
}
