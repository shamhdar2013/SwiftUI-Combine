//
//  EmployeesListViewModel.swift
//  DummyContacts
//
//  Created by radhika sharma on 2/12/24.
//

import Foundation
import Combine

class EmployeesListViewModel {
    @Published private(set) var employees: [EmployeeViewModel] = []
    private var cancellables: Set<AnyCancellable> = []
    @Published var dataFetchComplete: Bool = false
    
    private let dataFetcher: DataProvider
    
    init(dataFetcher: DataProvider) {
        self.dataFetcher = dataFetcher
        fetchEmployees()
    }
    
    func fetchEmployees() {
        dataFetcher.fetchAllEmployees().sink
        { [weak self] completion in
            switch completion {
            case .finished:
                self?.dataFetchComplete = true
            case .failure(let error):
                debugPrint(error)
            }
        } receiveValue: { [weak self] employeeGroup in
            guard let self, let employees = employeeGroup.employees else {
                self?.employees = []
                return
            }
            self.employees = employees.map(EmployeeViewModel.init)
        }.store(in: &cancellables)
        
    }
    
    func searchResults(searchTerm: String) -> [EmployeeViewModel] {
        
        guard !employees.isEmpty else {
            return []
        }
        
        guard !searchTerm.isEmpty else {
            return employees
        }
        
        let filtered = employees.filter { $0.name.contains(searchTerm) }
        return filtered
    }
}
