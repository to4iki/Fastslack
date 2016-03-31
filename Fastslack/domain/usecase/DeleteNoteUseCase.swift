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

	private let repository: NoteRepository

	init(repository: NoteRepository = RealmNoteRepository()) {
		self.repository = repository
	}
}

// MARK: - Action

extension DeleteNoteUseCase {

	func delete(note: Note) -> Observable<Bool> {
		return Observable.create { observer in
			do {
				try self.repository.delete(note)
				observer.onNext(true)
				observer.onCompleted()
			} catch {
				observer.onError(ErrorBundle.DeleteError(message: "delete note failure."))
			}

			return NopDisposable.instance
		}
	}

	func deleteAll() -> Observable<Bool> {
		return Observable.create { observer in
			do {
				try self.repository.deleteAll()
				observer.onNext(true)
				observer.onCompleted()
			} catch {
				observer.onError(ErrorBundle.DeleteError(message: "deleteAll note failure."))
			}

			return NopDisposable.instance
		}
	}
}
