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
}

// MARK: - UIViewController

extension NoteListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        
        setupView()
        bindView()
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
        
        tableView.registerNib(NoteTableViewCell.nib(), forCellReuseIdentifier: NoteTableViewCell.CellIdentifier)
        configureDynamicCellSizing()
        hideSeparator()
    }
    
    private func bindView() {
        presenter.variable.asObservable()
            .bindTo(tableView.rx_itemsWithCellIdentifier(NoteTableViewCell.CellIdentifier, cellType: NoteTableViewCell.self)) { (row, element, cell) -> Void in
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

// MARK: - Action

extension NoteListViewController {
    
    @IBAction func onClickCloseButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: closeCompletionHandler)
    }
}
