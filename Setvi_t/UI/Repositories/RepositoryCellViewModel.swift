//
//  UserCellViewModel.swift
//  Setvi_t
//
//  Created by Pavle on 6.5.24..
//

import Foundation

protocol RepositoryCellViewModel {
    var title: String { get }
    var subtitle: String { get }
}

struct RepositoryCellViewModelImpl: RepositoryCellViewModel {
    
    var title: String { repo.name }
    var subtitle: String { repo.fullName }

    private var repo: Repository
    
    init(repo: Repository) {
        self.repo = repo
    }
}
