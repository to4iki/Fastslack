//
//  MainViewController.swift
//  Fastslack
//
//  Created by to4iki on 2/28/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class MainViewController: UIViewController {

    @IBOutlet private weak var textView: UITextView! {
        didSet {
            automaticallyAdjustsScrollViewInsets = false
        }
    }

    @IBOutlet private weak var doneButton: UIBarButtonItem! {
        didSet {
            doneButton.enabled = false
        }
    }

    private let presenter = EntryNotePresenter()

    private let disposeBag = DisposeBag()
}

// MARK: - UIViewController

extension MainViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        presenter.viewWillAppear(animated)
        autoFocus()
    }
}

// MARK: - UI

extension MainViewController {

    private func bind() {
        presenter.body.asObservable()
            .bindTo(textView.rx_text)
            .addDisposableTo(disposeBag)

        textView.rx_text
            .filter { !$0.isEmpty }
            .subscribeNext { [unowned self] text in
                self.presenter.body.value = text
            }
            .addDisposableTo(disposeBag)

        textView.rx_text
            .map { !$0.isEmpty }
            .bindTo(doneButton.rx_enabled)
            .addDisposableTo(disposeBag)

        doneButton.rx_tap
            .subscribeNext { [unowned self] _ in
                self.presenter.send()
            }
            .addDisposableTo(disposeBag)
    }

    private func autoFocus() {
        textView.becomeFirstResponder()
    }
}

// MARK: - Segue

extension MainViewController {

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let toViewController = segue.destinationViewController.childViewControllers.first as? NoteListViewController
            where segue.identifier == "NoteListSegue" else { fatalError() }

        toViewController.setCloseCompletionHandler({
            log.info("close notes view controller.")
        })
    }
}
