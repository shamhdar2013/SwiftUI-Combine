//
//  DataFetcher.swift
//  DummyContacts
//
//  Created by radhika sharma on 2/6/24.
//

import Foundation
import Combine

enum Environment {
    case production
    case staging
    case mock
    
    var allEmployeeURL: URL? {
        switch self {
        case .production, .staging:
            return URL(string: DataURLs.getEmployeesURL)
        case .mock:
            return nil
        }
    }
}

enum NetworkError: Error {
    case badUrl
    case apiError
    case decodingError
}

enum DataURLs {
    static let getEmployeesURL = "https://dummy.restapiexample.com/api/v1/employees"
}

protocol DataProviderProtocol {
    func fetchAllEmployees() -> AnyPublisher<EmployeeGroup, Error>
}


class DataProvider {
    var environment: Environment = .staging
    var cancellables: Set<AnyCancellable> = []
    
    
    func fetchAllEmployees() -> AnyPublisher<EmployeeGroup, Error> {
        guard let url = environment.allEmployeeURL else {
            return Fail(error: NetworkError.badUrl).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: EmployeeGroup.self, decoder: JSONDecoder())
            .retry(3)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    

}
