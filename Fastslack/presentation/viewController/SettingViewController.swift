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

        bind()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        presenter.viewWillAppear(true)
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

    private func bind() {
        bindView()
        bindSubject()
    }

    private func bindView() {
        presenter.webHookURL.asObservable()
            .bindTo(webHookURLTextField.rx_text)
            .addDisposableTo(disposeBag)

        presenter.channel.asObservable()
            .bindTo(chanelTextField.rx_text)
            .addDisposableTo(disposeBag)

        presenter.botName.asObservable()
            .bindTo(botNameTextField.rx_text)
            .addDisposableTo(disposeBag)

        presenter.iconEmoji.asObservable()
            .bindTo(iconEmojiTextField.rx_text)
            .addDisposableTo(disposeBag)
    }

    private func bindSubject() {
        webHookURLTextField.rx_text
            .filter { !$0.isEmpty }
            .subscribeNext { [unowned self] text in
                self.presenter.webHookURL.value = text
            }
            .addDisposableTo(disposeBag)

        chanelTextField.rx_text
            .filter { !$0.isEmpty }
            .subscribeNext { [unowned self] text in
                self.presenter.channel.value = text
            }
            .addDisposableTo(disposeBag)

        botNameTextField.rx_text
            .filter { !$0.isEmpty }
            .subscribeNext { [unowned self] text in
                self.presenter.botName.value = text
            }
            .addDisposableTo(disposeBag)

        iconEmojiTextField.rx_text
            .filter { !$0.isEmpty }
            .subscribeNext { [unowned self] text in
                self.presenter.iconEmoji.value = text
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
        dismissViewControllerAnimated(true, completion: closeCompletionHandler)
    }
}
