//
//  ContentView.swift
//  EmployeeListSwiftUI
//
//  Created by radhika sharma on 2/14/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var employees: [EmployeeViewModel] = []
    
    @State private var cancellables: Set<AnyCancellable> = []
    @State private var viewModel: EmployeesListViewModel
    @State private var searchStr: String = ""
    
    init(viewModel: EmployeesListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            List(employees) { employee in
                HStack {
                    employee.picture
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    VStack {
                        let name = employee.name +  "( \(employee.age) )"
                        Text(name)
                        Text(employee.salary)
                    }
                }
            }
            .background(Color(red: 0.8627, green: 0.8627, blue: 0.8627))
            .scrollContentBackground(.hidden)
        }
        .searchable(text: $searchStr)
        .onChange(of: searchStr) {
            employees = viewModel.searchResults(searchTerm: searchStr)
        }
        .onAppear {
            viewModel.$dataFetchComplete
                .receive(on: DispatchQueue.main)
                .sink { completed in
                    if completed {
                        employees = viewModel.employees
                    }
                }.store(in: &cancellables)
        }
    }
}

#Preview {
    NavigationStack {
        let employeeVM = EmployeesListViewModel(dataFetcher: DataProvider())
        ContentView(viewModel: employeeVM)
    }
}
