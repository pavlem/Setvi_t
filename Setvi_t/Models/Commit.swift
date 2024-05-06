//
//  Commit.swift
//  Setvi_t
//
//  Created by Pavle on 6.5.24..
//

import Foundation

struct Commit: Decodable, Identifiable {
    var id: String { return sha }
    
    let sha: String
    let nodeId: String
    let commit: CommitDetail
}

struct CommitDetail: Decodable {
    let author: CommitAuthor
}

struct CommitAuthor: Decodable {
    let name: String
    let email: String
    let date: String
}
