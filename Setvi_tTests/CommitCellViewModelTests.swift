//
//  CommitCellViewModelTests.swift
//  Setvi_tTests
//
//  Created by Pavle on 7.5.24..
//

import XCTest
@testable import Setvi_t

class CommitCellViewModelTests: XCTestCase {

    func testInitialization() {
        // Given
        let userName = "John Doe"
        let email = "john.doe@example.com"
        let commitDate = "May 1, 2024"

        // When
        let viewModel = CommitCellViewModelImpl(userName: userName, email: email, commitDate: commitDate)

        // Then
        XCTAssertEqual(viewModel.userName, userName, "User name should be correctly initialized")
        XCTAssertEqual(viewModel.email, email, "Email should be correctly initialized")
        XCTAssertEqual(viewModel.commitDate, commitDate, "Commit date should be correctly initialized")
    }

    func testCreateFromCommit() {
        // Given
        let date = "2019-04-12T15:13:27Z"
        let commitDetail = CommitDetail(author: CommitAuthor(name: "Pera Detlic", email: "pera@gamil.com", date: date))
        let commit = Commit(sha: "123", nodeId: "1234", commit: commitDetail)
        
        // When
        let viewModel = CommitCellViewModelImpl.create(from: commit)

        // Then
        XCTAssertEqual(viewModel.userName, "Pera Detlic", "The user name should be taken from the commit author")
        XCTAssertEqual(viewModel.email, "pera@gamil.com", "The email should be taken from the commit author")
        XCTAssertEqual(viewModel.commitDate, "12. 4. 2019. at 17:13:27", "The commit date should be formatted to a readable string")
    }
}
