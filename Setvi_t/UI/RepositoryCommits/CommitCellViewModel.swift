//
//  CommitCellViewModel.swift
//  Setvi_t
//
//  Created by Pavle on 6.5.24..
//

import Foundation

protocol CommitCellViewModel {
    var userName: String { get set }
    var email: String { get set }
    var commitDate: String { get set }
    
    init(userName: String, email: String, commitDate: String)
}

struct CommitCellViewModelImpl: CommitCellViewModel {
    var userName: String
    var email: String
    var commitDate: String
}

extension CommitCellViewModel {
    static func create(from commit: Commit) -> Self {
        return Self(
            userName: commit.commit.author.name,
            email: commit.commit.author.email,
            commitDate: commit.commit.author.date.toReadableDate() ?? "-"
        )
    }
}
