//
//  NoteListFooterView.swift
//  Fastslack
//
//  Created by to4iki on 3/27/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit

final class NoteListFooterView: UIView {

    private static let NibName = "NoteListFooterView"
}

extension NoteListFooterView {

    private static func nib() -> UINib {
        return UINib(nibName: NibName, bundle: nil)
    }

    static func insance() -> NoteListFooterView {
        guard let view = nib().instantiateWithOwner(self, options: nil)[0] as? NoteListFooterView else {
            fatalError("failure instanced NoteListFooterView.")
        }
        return view
    }
}
