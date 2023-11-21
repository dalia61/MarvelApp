//
//  MarvelCellViewModel.swift
//  MarvelApp
//
//  Created by Dalia on 18/11/2023.
//

import Foundation

class MarvelCellViewModel {
    
    var name: String?
    var rating: String?
    var year: Int?
    var description: String?
    var image: String?
    init(serie: Series) {
        name = serie.title
        rating = serie.rating
        year = serie.startYear
        description = serie.description
        image = serie.thumbnail?.path
    }
}
