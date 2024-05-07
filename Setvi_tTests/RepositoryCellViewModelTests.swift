//
//  RepositoryCellViewModelImplTests.swift
//  Setvi_tTests
//
//  Created by Pavle on 7.5.24..
//

import XCTest
@testable import Setvi_t

class RepositoryCellViewModelTests: XCTestCase {

    func testTitleReturnsRepositoryName() {
        // Given
        let repo = Repository(id: 1, name: "Sample123Repo", fullName: "GitHub/Sample123Repo")
        let viewModel = RepositoryCellViewModelImpl(repo: repo)

        // When
        let title = viewModel.title

        // Then
        XCTAssertEqual(title, "Sample123Repo", "Title should return the name of the repository")
    }

    func testSubtitleReturnsRepositoryFullName() {
        // Given
        let repo = Repository(id: 1, name: "Sample123Repo", fullName: "GitHub/Sample123Repo")
        let viewModel = RepositoryCellViewModelImpl(repo: repo)

        // When
        let subtitle = viewModel.subtitle

        // Then
        XCTAssertEqual(subtitle, "GitHub/Sample123Repo", "Subtitle should return the full name of the repository")
    }
}

