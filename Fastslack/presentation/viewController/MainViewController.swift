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
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet private weak var textView: UITextView! {
        didSet {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    @IBOutlet weak var doneButton: UIBarButtonItem! {
        didSet {
            doneButton.enabled = false
        }
    }
}

// MARK: - UIViewController

extension MainViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            .map({ !$0.isEmpty })
            .bindTo(doneButton.rx_enabled)
            .addDisposableTo(disposeBag)
        
        doneButton.rx_tap
            .subscribeNext({ [unowned self] _ in
                guard let text = self.textView.text else { return }
                log.info(text)
                self.clearText()
            })
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
        guard let toViewController = segue.destinationViewController.childViewControllers.first as? NotesViewController
            where segue.identifier == "NotesSegue" else { fatalError() }
        
        toViewController.setCloseCompletionHandler({
            log.info("close notes view controller")
        })
    }
}
