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
        
        presenter.viewDidLoad()
        bindView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        autoFocus()
    }
}

// MARK: - UI

extension MainViewController {
    
    private func bindView() {
        textView.rx_text
            .map { !$0.isEmpty }
            .bindTo(doneButton.rx_enabled)
            .addDisposableTo(disposeBag)
        
        doneButton.rx_tap
            .subscribeNext { [unowned self] _ in
                guard let text = self.textView.text else { return }
                self.presenter.send(text)
                self.clearText()
            }
            .addDisposableTo(disposeBag)
    }
    
    
    private func autoFocus() {
        textView.becomeFirstResponder()
    }
    
    private func clearText() {
        textView.text = ""
    }
}

// MARK: - Segue

extension MainViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let toViewController = segue.destinationViewController.childViewControllers.first as? NoteListViewController
            where segue.identifier == "NoteListSegue" else { fatalError() }
        
        toViewController.setCloseCompletionHandler({
            log.info("close notes view controller")
        })
    }
}
