//
//  NoteListViewCell.swift
//  Fastslack
//
//  Created by to4iki on 3/17/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit

final class NoteListViewCell: UITableViewCell {

    @IBOutlet private weak var createdAtLabel: UILabel!

    @IBOutlet private weak var bodyLabel: UILabel!

    static let NibName = "NoteListViewCell"

    static let CellIdentifier = "NoteCellIdentifier"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

extension NoteListViewCell {

    static func nib() -> UINib {
        return UINib(nibName: NibName, bundle: nil)
    }

    func bind(note: NoteReadDto) {
        createdAtLabel.text = note.createdAt
        bodyLabel.text = note.body
    }
}
