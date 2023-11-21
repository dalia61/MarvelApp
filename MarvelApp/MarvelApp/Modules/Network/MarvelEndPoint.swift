//
//  MarvelEndPoint.swift
//  MarvelApp
//
//  Created by Dalia on 17/11/2023.
//

import Foundation
import Alamofire

enum MarvelEndPoint: Endpoint {
    case series(offset: Int, limit: Int)
    
    var path: String {
        switch self {
        case .series:
            return "/v1/public/series"
        }
    }
    
    var parameters: Parameters? {
        let publicKey = Constants.publicKey.rawValue
        let privateKey = Constants.privateKey.rawValue
        let ts =  "\(Date().timeIntervalSince1970)"
        let hashValue = ts + privateKey + publicKey
        let hash = MD5(string: hashValue)

        var defaultParameters: [String: Any] = [
            "ts": ts,
            "apikey": publicKey,
            "hash": hash
        ]

        var params: [String: Any] = [:]

        switch self {
        case let .series(offset, limit):
            params = [
                "offset": offset,
                "limit": limit
            ]
        }
        defaultParameters.merge(params) { (_, new) in new }
        return defaultParameters
    }
    
    var headers: HTTPHeaders {
        let defaultHeaders: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        return defaultHeaders
    }
    var method: HTTPMethod {
        switch self {
        case .series:
            return .get
        }
    }
}
