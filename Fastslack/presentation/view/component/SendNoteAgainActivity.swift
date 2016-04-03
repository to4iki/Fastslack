//
//  SendNoteAgainActivity.swift
//  Fastslack
//
//  Created by to4iki on 4/3/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit
import RxSwift

final class SendNoteAgainActivity: UIActivity {

    static let TypeName = "com.github.to4iki.Fastslack.presentation.view.component.SendNoteAgainActivity"

    private lazy var presenter = EntryNotePresenter()

    override func activityTitle() -> String? {
        return "Send Again"
    }

    override func activityType() -> String? {
        return SendNoteAgainActivity.TypeName
    }

    override func canPerformWithActivityItems(activityItems: [AnyObject]) -> Bool {
        return true
    }

    override func prepareWithActivityItems(activityItems: [AnyObject]) {
        send(ActivityItem.fromArray(activityItems))
    }
}

// MARK: - Action

extension SendNoteAgainActivity {

    private func send(item: ActivityItem) {
        presenter.forceSend(item.text)
    }
}
