//
//  NoteListViewController.swift
//  Fastslack
//
//  Created by to4iki on 3/1/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class NoteListViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    private let presenter = NoteListPresenter()
    
    private let disposeBag = DisposeBag()
    
    private var closeCompletionHandler: (() -> Void)?
    
    private lazy var longPressRecognizer: UILongPressGestureRecognizer =
        UILongPressGestureRecognizer(target: self, action: .cellLongPressed)
}

// MARK: - UIViewController

extension NoteListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        
        setupView()
        bindView()
        setupRecognizer()
    }
}

// MARK: - UI

extension NoteListViewController {
    
    private func setupView() {
        func configureDynamicCellSizing() {
            tableView.estimatedRowHeight = 44
            tableView.rowHeight = UITableViewAutomaticDimension
        }
        
        func hideSeparator() {
            let view = UIView(frame: CGRect.zero)
            view.backgroundColor = UIColor.clearColor()
            tableView.tableHeaderView = view
            tableView.tableFooterView = view
        }
        
        tableView.registerNib(NoteListViewCell.nib(), forCellReuseIdentifier: NoteListViewCell.CellIdentifier)
        configureDynamicCellSizing()
        hideSeparator()
    }
    
    private func bindView() {
        presenter.notes.asObservable()
            .bindTo(tableView.rx_itemsWithCellIdentifier(
                NoteListViewCell.CellIdentifier,
                cellType: NoteListViewCell.self)) { (row, element, cell) -> Void in
                    cell.bind(element)
            }
            .addDisposableTo(disposeBag)
        
        tableView.rx_itemDeleted
            .subscribeNext { [unowned self] indexPath in
                self.presenter.deleteNoteBy(indexPath.row)
            }
            .addDisposableTo(disposeBag)
    }
}

// MARK: - Setter

extension NoteListViewController {
    
    func setCloseCompletionHandler(handler: () -> Void) {
        closeCompletionHandler = handler
    }
}

// MARK: - UIGestureRecognizerDelegate

extension NoteListViewController: UIGestureRecognizerDelegate {
    
    private func setupRecognizer() {
        longPressRecognizer.delegate = self
        tableView.addGestureRecognizer(longPressRecognizer)
    }
    
    func cellLongPressed(recognizer: UILongPressGestureRecognizer) {
        let point = recognizer.locationInView(tableView)
        let indexPath = tableView.indexPathForRowAtPoint(point)
        
        if recognizer.state == UIGestureRecognizerState.Began {
            // TODO: Show ActionBar
        }
    }
}


// MARK: - Action

extension NoteListViewController {
    
    @IBAction func onClickCloseButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: closeCompletionHandler)
    }
}

// MARK: - Selector in ViewController

private extension Selector {
    
    static let cellLongPressed = #selector(NoteListViewController.cellLongPressed(_:))
}
