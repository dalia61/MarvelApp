//
//  MarvelUseCase.swift
//  MarvelApp
//
//  Created by Dalia on 18/11/2023.
//

import Foundation

protocol MarvelUseCase {
    var series: [Series] { get set }
    func fetchSeries(response: @escaping (Result<[Series]?, NetworkError>) -> Void)
    func search(title: String) -> [Series]
    func refresh(response: @escaping (Result<[Series]?, NetworkError>) -> Void)
}

class MarvelUseCaseImplementation: MarvelUseCase {
    var series: [Series] = []
    let itemsPerBatch = 20
    var currentOffset = 0
    
    func fetchSeries(response: @escaping (Result<[Series]?, NetworkError>) -> Void) {
        currentOffset = series.isEmpty ? series.count : (series.count + 1)
        let endpoint = MarvelEndPoint.series(offset: currentOffset, limit: itemsPerBatch)
        AlamofireManager.shared.callRequest(MarvelResponse.self, endpoint: endpoint) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(marvelData):
                self.series.append(contentsOf: marvelData.data?.results ?? [])
                response(.success(self.series))
            case let .failure(error):
                response(.failure(error))
                print(error)
            }
        }
    }
    
    func refresh(response: @escaping (Result<[Series]?, NetworkError>) -> Void) {
        series.removeAll()
        currentOffset = 0
        fetchSeries { value in
            response(value)
        }
    }
    
    func search(title: String) -> [Series] {
        return series.filter {
            $0.title?.contains(title) ?? false
        }
    }
    
}
