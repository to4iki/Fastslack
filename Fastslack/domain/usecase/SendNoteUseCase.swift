//
//  SendNoteUseCase.swift
//  Fastslack
//
//  Created by to4iki on 3/15/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation
import RxSwift

protocol SendNoteUseCaseDelegate: class {
    
    func onSendNoteSuccess(message: String, note: Note)
    
    func onSendNoteError(error: ErrorType)
}

final class SendNoteUseCase: NSObject {

    weak var delegate: SendNoteUseCaseDelegate?
    
    private let disposeBag = DisposeBag()
    
    private lazy var slackAPI = SlackAPI()
}

// MARK: - Action

extension SendNoteUseCase {
    
    func send(note: Note) {
        slackAPI.send(note.body).subscribe(
            onNext: { [weak self] s in self?.delegate?.onSendNoteSuccess(s, note: note) },
            onError: { [weak self] e in self?.delegate?.onSendNoteError(e) },
            onCompleted: nil,
            onDisposed: nil
        ).addDisposableTo(disposeBag)
    }
}
