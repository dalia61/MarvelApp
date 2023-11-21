//
//  MarvelViewModel.swift
//  MarvelApp
//
//  Created by Dalia on 18/11/2023.
//

import Foundation

class MarvelViewModel {
    private let coordinator: MarvelCoordinator
    var isLoadingData: Observable<Bool> = Observable(false)
    var marvel: Observable<[MarvelCellViewModel]> = Observable([])
    
    var useCase: MarvelUseCase
    
    init(coordinator: MarvelCoordinator,
         useCase: MarvelUseCase = MarvelUseCaseImplementation()) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
    
    func fetchData(isRefresh: Bool) {
        if isLoadingData.value {
            return
        }
        isLoadingData.value = true
        var response: Result<[Series]?, NetworkError>?

        if isRefresh {
            useCase.refresh(response: { [weak self] refreshResponse in
                response = refreshResponse
                self?.handleResponse(response: response)
            })
        } else {
            useCase.fetchSeries(response: { [weak self] fetchResponse in
                response = fetchResponse
                self?.handleResponse(response: response)
            })
        }
    }
    
    func handleResponse(response: Result<[Series]?, NetworkError>?) {
        isLoadingData.value = false
        switch response {
        case .success(let response):
            marvel.value = mapToMarvelViewModels(marvel: response ?? [])
        case .failure(let error):
            print(error)
        case .none:
            print("Error")
        }
    }
    
    func fetchData(title: String) {
        var series: [Series] = []
        
        if !title.isEmpty {
            series = useCase.search(title: title)
        } else {
            series = useCase.series
        }
        marvel.value = mapToMarvelViewModels(marvel: series)
    }
    
    private func mapToMarvelViewModels(marvel: [Series]) -> [MarvelCellViewModel] {
            return marvel.map {
                MarvelCellViewModel(serie: $0)
            }
        }
    
    func getSerieAt(indexPath: IndexPath) -> MarvelCellViewModel {
        return marvel.value[indexPath.row]
    }
}
