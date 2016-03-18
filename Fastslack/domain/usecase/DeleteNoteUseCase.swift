//
//  DeleteNoteUseCase.swift
//  Fastslack
//
//  Created by to4iki on 3/18/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation
import RxSwift

final class DeleteNoteUseCase {
    
    private lazy var repository = RealmNoteRepository()
}

// MARK: - Action

extension DeleteNoteUseCase {
    
    func delete(note: Note) -> Observable<Bool> {
        return Observable.create { observer in
            do {
                try self.repository.delete(note)
                observer.onNext(true)
            } catch {
                observer.onError(ErrorBundle.DeleteError(message: "delete note failure."))
            }
            
            observer.onCompleted()
            
            return NopDisposable.instance
        }
    }
}
